clear
clc

% 0 - reference value
ref_GR = -4;
ref_FR = 97.5;

% 1 - Data loading
load 'f_MC_GR.mat'
load 'f_MC_FR.mat'

% 2- Range setting
Ran_GR = [-30 30];
Ran_FR = [94 100];

% 3 - Interval setting
int_GR = 0.5;
int_FR = 0.2;

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
        count(i,j) = points_count(area_range,f_MC_GR(1:30000),f_MC_FR(1:30000))/30000;
        
    end
    
end
%%%%%%%%%%%%%%%%
max_density = max(max(count));
min_density = min(min(count));

%%%% Color specification %%%%%
figure(1)
for i = 1:20000
    if f_MC_FR(i)<min(Ran_FR) || f_MC_FR(i)>max(Ran_FR) || f_MC_GR(i)<min(Ran_GR) || f_MC_GR(i)>max(Ran_GR)
        continue
    else
        location_i = ceil((f_MC_FR(i)-min(Ran_FR))/int_FR);
        location_j = ceil((f_MC_GR(i)-min(Ran_GR))/int_GR);
        r = (count(location_i,location_j)-min_density)/(max_density-min_density)*(0.05-0.8)+0.8;
        color_data = [r r r];
        plot(f_MC_GR(i),f_MC_FR(i),'o','LineWidth',1,'MarkerFaceColor',color_data,'MarkerEdgeColor',color_data)
        hold on
    end
    
    if rem(i,1000) == 0
        
        remain_num = 20 - i/1000
    
    end
    
end

plot(ref_GR,ref_FR,'ro','MarkerFaceColor','r')
hold off

h = gca;
h.FontSize = 14;
h.XLim = [-30 30];
h.YLim = [94 100];
xlabel('Growth Rate (rad/s)')
ylabel('Frequency (Hz)')
grid on

cm=flipud(gray);
colormap(cm)
colorbar('Ticks',[0,0.2,0.4,0.6,0.8,1],'TickLabels',{'0','0.003','0.006','0.009','0.012','0.015'})
colorbar

fig = gcf;
fig.PaperPositionMode = 'auto';
print('Scatter_MC_B','-dtiff','-r800')