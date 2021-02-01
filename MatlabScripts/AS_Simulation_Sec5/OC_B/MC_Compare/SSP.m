clear
clc

load 'Samples_N_St.mat'
load 'eigenvector_70.mat'
load 'f_GR.mat'

figure(1)
new_input = V(:,end)'*Samples_N_St';
plot(new_input,f_GR,'ko','MarkerSize',6,'LineWidth',1.2)

axis([-4 4 -30 30])
xlabel('Active Variable','FontSize',14)
ylabel('Growth Rate (rad/s)','FontSize',14)

set(gca,'FontSize',14)
grid on

fig = gcf;
fig.PaperPositionMode = 'auto';
print('B_SSP','-dtiff','-r800')