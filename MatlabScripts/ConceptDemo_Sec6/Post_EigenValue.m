clear
clc

load 'eigenvalue_70'

figure(1)
semilogy(16:-1:1,diag(D)/D(end,end),'k*','MarkerSize',10,'LineWidth',1.2)

xlabel('Index','FontSize',14)
ylabel('Eigenvalue','FontSize',14)

ca = gca;
ca.FontSize = 14;
grid on

% fig = gcf;
% fig.PaperPositionMode = 'auto';
% print('EigenValue_ConpDemo','-dtiff','-r800')