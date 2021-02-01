clear
clc
clf

load 'model_Luis_30kW_9.5%_4_21_350ms.mat'
[mag,phase,wout,sdmag,sdphase] = bode(model);
phase0 = phase(1);

% Phase
figure(1)
plot(wout/2/pi,(squeeze(phase)-phase0)/180*pi,'k','LineWidth',2)
hold on
% ar = area(wout/2/pi,squeeze(2*1.96*sdphase)/180*pi)
% ar.FaceColor = 'r'
% ar.EdgeColor = 'r'
% ar.FaceAlpha = 0.4
% ar.EdgeAlpha = 0
plot(wout/2/pi,(squeeze(phase+1.96*sdphase)-phase0)/180*pi,'r--','LineWidth',1)
plot(wout/2/pi,(squeeze(phase-1.96*sdphase)-phase0)/180*pi,'r--','LineWidth',1)
axis([0 500 -16 4])

grid on

xticks(0:100:500)
yticks(-16:4:4)
h = gca;
h.FontSize = 14;

xlabel('Frequency (Hz)','FontSize',14)
ylabel('Phase (rad)','FontSize',14)

% fig = gcf;
% fig.PaperPositionMode = 'auto';
% print('FTF_UQ_Freq_Phase','-dtiff','-r800')

% Gain
figure(2)
plot(wout/2/pi,(squeeze(mag)),'k','LineWidth',2)
hold on
% ar = area(wout/2/pi,squeeze(2*1.96*sdmag))
% ar.FaceColor = 'r'
% ar.EdgeColor = 'r'
% ar.FaceAlpha = 0.4
% ar.EdgeAlpha = 0
plot(wout/2/pi,(squeeze(mag+1.96*sdmag)),'r--','LineWidth',1)
plot(wout/2/pi,(squeeze(mag-1.96*sdmag)),'r--','LineWidth',1)

axis([0 500 0 2])
grid on

xticks(0:100:500)
yticks(0:0.5:2)
h = gca;
h.FontSize = 14;
xlabel('Frequency (Hz)','FontSize',14)
ylabel('Magnitude (abs)','FontSize',14)

hold off
% 
% % a = squeeze(sdmag);
% % b = squeeze(mag);
% % 
% % figure(3)
% % plot(wout/2/pi,a./b*100,'k','LineWidth',2)
% % axis([0 500 0 40])
% % grid on
% % 
% % xticks(0:100:500)
% % yticks(0:10:40)
% % h = gca;
% % h.FontSize = 14;
% % xlabel('Frequency (Hz)','FontSize',14)
% % ylabel('Error','FontSize',14)
% 
% 
% fig = gcf;
% fig.PaperPositionMode = 'auto';
% print('FTF_UQ_Freq_Pha','-dtiff','-r800')