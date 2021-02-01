clear
clc
clf

% --------------------------------------------------------------------------------
model_200 = load( 'ConceptDemo_200ms.mat')                             % load original FIR model
model_500 = load( 'ConceptDemo_500ms.mat')
model_1400 = load( 'ConceptDemo_1400ms.mat')

figure(1)
[y,t,x,ysd] = impulse(model_200.model);
h1 = stem(t,y,'k','LineWidth',1,'MarkerSize',6)
hold on
p1 = plot(t,y+3*ysd,'k--','LineWidth',1.2)
p2 = plot(t,y-3*ysd,'k--','LineWidth',1.2)
grid on

[y,t,x,ysd] = impulse(model_500.model);
h2 = stem(t,y,'b','d','LineWidth',1,'MarkerSize',6)
p3 = plot(t,y+3*ysd,'b--','LineWidth',1.2)
p4 = plot(t,y-3*ysd,'b--','LineWidth',1.2)
% 
[y,t,x,ysd] = impulse(model_1400.model);
h3 = stem(t,y,'r','s','LineWidth',1,'MarkerSize',6)
p5 = plot(t,y+3*ysd,'r--','LineWidth',1.2)
p6 = plot(t,y-3*ysd,'r--','LineWidth',1.2)


axis([0 0.015 -450 900])
xticks(0:0.005:0.015)
yticks(-450:150:900)
h = gca;
h.FontSize = 14;

xlabel('Time (s)','FontSize',14)
ylabel('Amplitude','FontSize',14)
% legend([h1 h2 h3 p1 p3 p5],'FIR-200','FIR-500','FIR-1400','FIR-200-region','FIR-500-region','FIR-1400-region')

% fig = gcf;
% fig.PaperPositionMode = 'auto';
% print('Conpdemo_T_UQ','-dtiff','-r800')




