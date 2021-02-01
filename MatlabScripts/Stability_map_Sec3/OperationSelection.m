clear
clc
%%%%%%%%%%%%%%%
%%% Operational_point_A = [0.51, -0.9883];    (acoustic mode)
%%% Operational_point_B = [0.6, -0.6351];      (intrinsic mode)
%%%%%%%%%%%%%%%

combustor_lengh = 0.51;
reflection = -0.9883;

load 'model_Luis_30kW_9.5%_4_21_350ms.mat'
h = model.B(4:19);
initial_value = [45.94*2*pi,-50.15;107.6*2*pi,-70.94;426.37*2*pi,-21.7]; 

f_FR = zeros(1,3);
f_GR = zeros(1,3);
options = optimoptions('fsolve','Display','off');

for k = 1:3
    
    EigenFun = @(omega) Eigenmode_solver(omega,h,reflection,combustor_lengh);
    Eigen = fsolve(EigenFun, initial_value(k,1)-initial_value(k,2)*1i,options);
    f_FR(k) = real(Eigen)/(2*pi);
    f_GR(k) = -imag(Eigen);
    
end

figure(1)
plot(-4,97.46,'ro','MarkerSize',8,'LineWidth',2)
text(-10,120,'Case B','FontSize',14,'Margin',1)
hold on

plot(-4,434.17,'ro','MarkerSize',8,'LineWidth',2)
text(-10,410,'Case A','FontSize',14,'Margin',1)

axis([-30 30 0 500])
xlabel('Growth Rate (rad/s)','FontSize',14)
ylabel('Frequency (Hz)','FontSize',14)
set(gca,'FontSize',14)
grid on

xticks(-30:15:30)
yticks(0:100:500)

% fig = gcf;
% fig.PaperPositionMode = 'auto';
% print('EigenFreq_OC','-dtiff','-r800')