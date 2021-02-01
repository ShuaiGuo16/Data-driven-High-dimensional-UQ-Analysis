clear
clc
clf

load 'f_MC_GR.mat'
load 'f_MC_FR.mat'

% figure(1)
% plot(f_MC_GR(1:4355),f_MC_FR(1:4355),'ko','LineWidth',1.2)
% 
% h = gca;
% h.FontSize = 14;
% h.XLim = [-60 40]
% h.YLim = [75 90]
% xlabel('Maximum Growth Rate (rad/s)')
% ylabel('Frequency (Hz)')
% title('70 coefficients')
% grid on

% hold on
% plot(-4,84.16,'ro','MarkerSize',10,'LineWidth',2)

% sys = tax('BRS_Malte_PSD2_1.slx',1000);
% [V,D] = eig(sys);
% [ f_GR, f_FR ] = acoustic_eigenval_ITA( D )


% plot PDF comparison
MC_GR = f_MC_GR(1:20000,3);
unstable_MC_GR = MC_GR(MC_GR>0);
figure(1)
hold on
H1 = histogram(MC_GR,'Normalization','pdf');
set(H1,'FaceColor','black');

edges = 0:0.5:30;
N = histcounts(unstable_MC_GR,edges);
N = N/20000/0.5;
H2 = histogram('BinEdges',edges,'BinCounts',N);
set(H2,'FaceColor','red');
hold off

h = gca;
h.FontSize = 14;
h.XLim = [-30 30]
h.YLim = [0 0.08]
xlabel('Growth Rate (rad/s)')
ylabel('PDF')
xticks(-30:10:30)
yticks(0:0.02:0.08)


% for j=1:100
%     boundary=j*500;
%     risk_factor(j) = 100*size(find(f_MC_GR(1:boundary)>0),1)/boundary;
%     mean_value(j) = mean(f_MC_GR(1:boundary));
%     St(j) = sqrt(sum((f_MC_GR(1:boundary)-mean_value(j)).^2)/boundary);
% end
% 
% figure(2)
% plot(500:500:50000,risk_factor,'-o')
% 
% figure(3)
% plot(500:500:50000,mean_value,'-o')
% 
% figure(4)
% plot(500:500:50000,St,'-o')


% fig = gcf;
% fig.PaperPositionMode = 'auto';
% print('PDF_MC_A','-dtiff','-r800')