clear
clc

A_sample = load ('../OC_A/MC_Compare/Samples_N_St.mat')
A_eigen = load ('../OC_A/MC_Compare/eigenvector_70.mat')
A_GR = load ('../OC_A/MC_Compare/f_GR.mat')
A_coef = load('../OC_A/MC_Compare/beta.mat')

B_sample = load ('../OC_B/MC_Compare/Samples_N_St.mat')
B_eigen = load ('../OC_B/MC_Compare/eigenvector_70.mat')
B_GR = load ('../OC_B/MC_Compare/f_GR.mat')
B_coef = load('../OC_B/MC_Compare/beta.mat')

figure(1)
new_input_A = A_eigen.V(:,end)'*A_sample.Samples_N_St';
new_input_B = B_eigen.V(:,end)'*B_sample.Samples_N_St';
plot(new_input_A,A_GR.f_GR(:,3),'ko','MarkerSize',6,'LineWidth',1.2)
hold on

plot(new_input_B,B_GR.f_GR,'b>','MarkerSize',6,'LineWidth',1.2)

coor_x = -4:0.01:4;
coor_y_A = A_coef.beta(1)+A_coef.beta(2)*coor_x+A_coef.beta(3)*coor_x.^2;
coor_y_B = B_coef.beta(1)+B_coef.beta(2)*coor_x+B_coef.beta(3)*coor_x.^2;

plot(coor_x,coor_y_A,'k','LineWidth',1.2)
plot(coor_x,coor_y_B,'b','LineWidth',1.2)

hold off

axis([-4 4 -30 30])
xlabel('Active Variable','FontSize',14)
ylabel('Growth Rate (rad/s)','FontSize',14)

set(gca,'FontSize',14)
grid on


% fig = gcf;
% fig.PaperPositionMode = 'auto';
% print('SSP','-dtiff','-r800')
