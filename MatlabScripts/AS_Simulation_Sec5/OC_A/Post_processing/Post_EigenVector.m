clear
clc

N_400 = load('eigenvector_70.mat')

figure(1)
stem(N_400.V(:,end),'kd-','MarkerSize',8,'MarkerFaceColor','k','LineWidth',1.2)

xlabel('Index','FontSize',14)
ylabel('Eigenvector Components','FontSize',14)
axis([0 16 -0.2 0.8])
set(gca,'FontSize',14)
grid on

xticks(0:4:16)
yticks(-0.2:0.2:0.8)

fig = gcf;
fig.PaperPositionMode = 'auto';
print('EigenVector_A','-dtiff','-r800')