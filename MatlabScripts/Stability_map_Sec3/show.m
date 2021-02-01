clear
clc

load 'X.mat'
load 'Y.mat'
load 'max_growth.mat'

figure(1)
contour(X,Y,max_growth,'LineColor','k','ShowText','on','LevelStep',20)
hold on
contour(X,Y,max_growth,'LineColor','r','ShowText','on','LevelList',0,'LineWidth',3)
contour(X,Y,max_growth,'LineColor','b','ShowText','on','LevelList',-4,'LineWidth',2,'LineStyle','--','LabelSpacing',110)
xlabel('Combustor Length','FontSize',14)
ylabel('Reflection Coefficient','FontSize',14)
hold off

fig = gcf;
fig.PaperPositionMode = 'auto';
print('stability_map_full','-dtiff','-r800')