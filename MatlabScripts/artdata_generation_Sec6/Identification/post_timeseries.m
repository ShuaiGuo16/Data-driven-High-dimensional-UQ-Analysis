clear
clc

%%
load('data_Luis_30kW_9.5%.mat')
% data = data(ceil(25e-3/data.Ts):0.35/data.Ts);

%%
data.y = ( data.y - mean(data.y) ) / mean(data.y);
data.u = ( data.u - mean(data.u) ) / mean(data.u);
size_data = 1:size(data.y,1);

%%
figure(1)
% subplot(2,1,1)
% plot(size_data'*data.Ts,data.u,'k','LineWidth',1.2)
% axis([0 0.35 -0.5 0.5])
% axis off
% set(gca,'FontSize',12)

% subplot(2,1,2)
plot(size_data'*data.Ts,data.y,'k','LineWidth',1.2)

axis([0 0.35 -0.5 0.5])
axis off
% set(gca,'FontSize',12)
set(gcf,'units','points','position',[10,10,450,100])

% fig = gcf;
% fig.PaperPositionMode = 'auto'
% print('TimeSerise_350ms_Q','-dtiff','-r600')