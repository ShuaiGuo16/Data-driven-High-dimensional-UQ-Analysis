%%%%% Plot matrix %%%%
clear
clc
clf

load 'model_Luis_30kW_9.5%_4_21_350ms.mat' 
temp_cov = getcov(model);
imagesc(temp_cov)
colorbar

set(gca,'XAxisLocation','top')
xticks(1:16);
yticks(1:16);

fig = gcf;
fig.PaperPositionMode = 'auto';
print('Cov_matrix','-dtiff','-r800')
