clear
clc

%%
load('data_superlong.mat')
data_timeseries = data_timeseries(ceil(25e-3/data_timeseries.Ts):1.4/data_timeseries.Ts);

%%
size_data = 1:size(data_timeseries.u,1);

%%
figure(1)
% subplot(2,1,1)
% plot(size_data'*data_timeseries.Ts,data_timeseries.u,'k','LineWidth',1.2)
% axis([1 2.4 -0.5 0.5])
% axis off
% set(gca,'FontSize',12)

% subplot(2,1,2)
plot(1+size_data'*data_timeseries.Ts,data_timeseries.u,'r','LineWidth',1.2)

axis([1 2.4 -0.5 0.5])
% axis off
set(gca,'FontSize',12)
set(gcf,'units','points','position',[10,10,252,100])

% fig = gcf;
% fig.PaperPositionMode = 'auto'
% print('TimeSerise_1400ms_q','-dtiff','-r600')