clear
clc
clf

% --------------------------------------------------------------------------------
load 'model_Luis_30kW_9.5%_4_21_350ms.mat'                             % load original FIR model

figure(1)
[y,t,x,ysd] = impulse(model);
stem(t,y,'k','filled','LineWidth',1,'MarkerSize',5)
hold on
% plot(t,y,'r-','LineWidth',4)
% hold on
p1 = plot(t,y+1.96*ysd,'r--','LineWidth',1)
% p1.Color = [0.411765 0.411765 0.411765]
p2 = plot(t,y-1.96*ysd,'r--','LineWidth',1)
% p2.Color = [0.411765 0.411765 0.411765]
grid on

axis([0 0.015 -300 750])
xticks(0:0.005:0.015)
yticks(-300:150:750)
h = gca;
h.FontSize = 14;

xlabel('Time (s)','FontSize',14)
ylabel('Amplitude','FontSize',14)

fig = gcf;
fig.PaperPositionMode = 'auto';
print('FTF_T_UQ','-dtiff','-r800')




