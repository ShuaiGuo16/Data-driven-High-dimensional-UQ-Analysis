clear
clc

%%%%%%
%%% PDF comparison between MC & AS
%%%%%%

load 'beta.mat'
load 'eigenvector_70.mat'
load 'f_MC_GR.mat'

m = 16;
n = 1;
eg_vector = V(:,end);

%% AS low-order model - data generation
sampling_num=30000;
Samples = lhsnorm(zeros(m,1),diag(ones(m,1)),sampling_num); 
X_input = ones(sampling_num,n+2);
X_input(:,2) = (eg_vector'*Samples')';
X_input(:,3) = X_input(:,2).^2;

f_ROM = X_input * beta;

pts = -30:0.1:20;
figure(1)
[f_Pre,xi_Pre] = ksdensity(f_ROM,pts);
h1 = plot(xi_Pre,f_Pre,'k-','LineWidth',2)
hold on
% [f_Full,xi_Full] = ksdensity(f_MC_GR(1:40000,3),pts);
% plot(xi_Full,f_Full,'k--','LineWidth',2)
H = histogram(f_MC_GR(1:30000,3),'Normalization','pdf');
set(H,'FaceColor','black');

h = gca;
h.FontSize = 14;
h.XLim = [-30 20]
h.YLim = [0 0.08]
xlabel('Growth Rate (rad/s)')
ylabel('PDF')
xticks(-30:10:20)
yticks(0:0.02:0.08)

plot([0 0],[0 0.08],'k--','LineWidth',2)

hold off
legend([h1,H],{'Active Subspace','Monte Carlo'},'Location','NorthWest')

fig = gcf;
fig.PaperPositionMode = 'auto';
print('PDF_Comp_A','-dtiff','-r800')