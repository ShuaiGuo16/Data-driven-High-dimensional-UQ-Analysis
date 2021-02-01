clear
clc

%%
load('data_Luis_30kW_9.5%.mat')
slice_data = data(1:0.12/data.Ts);

%%
data.y = ( data.y - mean(data.y) ) / mean(data.y);
data.u = ( data.u - mean(data.u) ) / mean(data.u);
size_data = 1:size(data.y,1);

slice_data.y = (slice_data.y-mean(slice_data.y))/mean(slice_data.y);
slice_data.u = (slice_data.u-mean(slice_data.u))/mean(slice_data.u);
size_slice = 1:size(slice_data.y,1);

%%
figure(1)
subplot(2,1,1)
hold on
plot(size_data'*data.Ts,data.u,'k','LineWidth',1.2)
plot(size_slice'*data.Ts,slice_data.u,'r','LineWidth',1.2)
hold off
axis([0 0.35 -0.5 0.5])
set(gca,'FontSize',12)
ylabel('$u^{\prime}/\bar{u}$','Interpreter','latex')

subplot(2,1,2)
hold on
plot(size_data'*data.Ts,data.y,'k','LineWidth',1.2)
plot(size_slice'*data.Ts,slice_data.y,'r','LineWidth',1.2)
hold off
xlabel('Time/s')
ylabel('$\dot{Q}^{\prime}/\bar{\dot{Q}}$','Interpreter','latex')

axis([0 0.35 -0.5 0.5])
set(gca,'FontSize',12)
set(gcf,'units','points','position',[10,10,450,200])


% figure(2)
% hold on
% plot(size_data(1:56000)'*data.Ts,0.15*sin(10*pi/0.35*size_data(1:56000)'*data.Ts),'k','LineWidth',1.2)
% plot(size_data(7000:56000)'*data.Ts,0.15*1.5*sin(10*pi/0.35*size_data(7000:56000)'*data.Ts-pi/4),'b','LineWidth',1.2)
% axis([0 0.35 -0.5 0.5])
% axis off

fig = gcf;
fig.PaperPositionMode = 'auto'
print('TimeSerise','-dpdf','-r600')