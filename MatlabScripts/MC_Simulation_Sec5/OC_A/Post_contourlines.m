clear
clc

% 0 - reference value
ref_GR = -4;
ref_FR = 434.2;

% 1 - Data loading
load 'f_MC_GR.mat'
load 'f_MC_FR.mat'

% 2- Range setting
Ran_GR = [-30 30];
Ran_FR = [430 438];

% 3 - Interval setting
int_GR = 2;
int_FR = 0.4;

% 4 - Data storage point
ele_GR = (max(Ran_GR)-min(Ran_GR))/int_GR;
ele_FR = (max(Ran_FR)-min(Ran_FR))/int_FR;

GR = linspace(min(Ran_GR)+int_GR/2,max(Ran_GR)-int_GR/2,ele_GR);
FR = linspace(min(Ran_FR)+int_FR/2,max(Ran_FR)-int_FR/2,ele_FR);

% 5 - Data sorting
count = zeros(ele_FR,ele_GR);


for i = 1:ele_FR
    
    for j = 1:ele_GR
        
        center_point_FR = FR(i);
        center_point_GR = GR(j);
        area_range = [center_point_GR-int_GR/2,center_point_GR+int_GR/2,center_point_FR-int_FR/2,center_point_FR+int_FR/2];
        count(i,j) = points_count(area_range,f_MC_GR(1:30000,3),f_MC_FR(1:30000,3))/30000/(int_GR*int_FR);      % PDF
        
    end
    
end

max_density = max(max(count));

[X,Y] = meshgrid(GR, FR);

%%%%%%%%%%%%%%%%%%%%
figure(1)
% contourf(X,Y,count,60,'LineColor','none')
contour(X,Y,count,'LineColor','k','ShowText','off','LevelList',0.1*max_density,'LineWidth',2,'LabelSpacing',110)
hold on

contour(X,Y,count,'LineColor','k','ShowText','off','LevelList',0.3*max_density,'LineWidth',2,'LabelSpacing',110)
contour(X,Y,count,'LineColor','k','ShowText','off','LevelList',0.5*max_density,'LineWidth',2,'LabelSpacing',110)
contour(X,Y,count,'LineColor','k','ShowText','off','LevelList',0.7*max_density,'LineWidth',2,'LabelSpacing',110)
contour(X,Y,count,'LineColor','k','ShowText','off','LevelList',0.9*max_density,'LineWidth',2,'LabelSpacing',110)

plot(ref_GR,ref_FR,'r>','MarkerFaceColor','r','MarkerSize',8)
hold off

h = gca;
h.FontSize = 14;
h.XLim = [-30 30];
h.YLim = [430 438];
xlabel('Growth Rate (rad/s)')
ylabel('Frequency (Hz)')


% fig = gcf;
% fig.PaperPositionMode = 'auto';
% print('PDFContour_MC_A','-dtiff','-r800')
