clear
clc

%% Loading all necessary data
load 'beta.mat'
load 'eigenvector_70'
model1400 = load('ConceptDemo_1400ms.mat');
model200 = load('ConceptDemo_200ms.mat');
load 'f_MC_GR.mat'

%% Reconstruct expression for active variable
mean200 = model200.model.B(4:19);  
variance200 = sqrt(diag(getcov(model200.model)));

a_prime = V(:,end)./variance200;
const = sum(mean200'.*V(:,end)./variance200);

%% Generating samples for 350ms
mean1400 = model1400.model.B(4:19);  
temp_cov = getcov(model1400.model);

[Con_V,Cov_D] = eig(temp_cov);                   
A = Con_V'; 
mean_translation = A*mean1400';                            
variance_translation = sqrt(diag(Cov_D));  

m = 16;  Sample_num = 40000;
Samples_N_St = lhsnorm(zeros(m,1),diag(ones(m,1)),Sample_num); 

for i = 1:m
    Samples_N_temp(:,i) = Samples_N_St(:,i)*variance_translation(i) + mean_translation(i);
end
Samples_N = (A'*Samples_N_temp')';

%% Calculate PDF based on low-order model
f_ROM = zeros(Sample_num,1);

for i = 1:Sample_num
    AV = sum(a_prime'.*Samples_N(i,:)) - const;
    f_ROM(i) = beta(1)+beta(2)*AV+beta(3)*AV^2;
end
save 'f_ROM_1400.mat' f_ROM
%% PDF comparison
pts = -20:0.1:20;
figure(1)
[f_Pre,xi_Pre] = ksdensity(f_ROM,pts);
plot(xi_Pre,f_Pre,'k-','LineWidth',2)
hold on
% [f_Full,xi_Full] = ksdensity(f_MC_GR(1:40000,3),pts);
% plot(xi_Full,f_Full,'k--','LineWidth',2)
H = histogram(f_MC_GR(1:40000,3),'Normalization','pdf');
set(H,'FaceColor','black');


h = gca;
h.FontSize = 14;
h.XLim = [-20 20]
h.YLim = [0 0.18]
xlabel('Growth Rate (rad/s)')
ylabel('PDF')
xticks(-20:10:20)
yticks(0:0.03:0.18)
legend('SM','DMC','Location','NorthWest')

plot([0 0],[0 0.18],'k--','LineWidth',2)

hold off

% fig = gcf;
% fig.PaperPositionMode = 'auto';
% print('PDF_Conpdemo_1400','-dtiff','-r800')