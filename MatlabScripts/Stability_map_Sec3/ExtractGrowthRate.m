% run parameter study in a controlled way
clear
clc

load 'model_Luis_30kW_9.5%_4_21_350ms.mat'
h = model.B(4:19);
initial_value = [45.94*2*pi,-50.15;107.6*2*pi,-70.94;426.37*2*pi,-21.7]; 

node = 30;
combustor_lengh = linspace(0.25,0.9,node);
reflection = linspace(-1,-0.5,node);
max_growth = zeros(node,node);
max_freq = zeros(node,node);

[X,Y] = meshgrid(combustor_lengh,reflection);

remaining = node*node;
f_FR = zeros(1,3);
f_GR = zeros(1,3);
options = optimoptions('fsolve','Display','off');

for index_i = 1:node
    
    for index_j = 1:node
       
        for k = 1:3
            
            EigenFun = @(omega) Eigenmode_solver(omega,h,reflection(index_i),combustor_lengh(index_j));
            Eigen = fsolve(EigenFun, initial_value(k,1)-initial_value(k,2)*1i,options);
            f_FR(k) = real(Eigen)/(2*pi);
            f_GR(k) = -imag(Eigen);
            
        end
        
        [max_growth(index_i,index_j), location] = max(f_GR);
        max_freq(index_i,index_j) = f_FR(location);
        
        remaining = remaining - 1
        
    end
    
end

save 'X.mat' X
save 'Y.mat' Y
save 'max_growth.mat' max_growth

figure(1)
contour(X,Y,max_growth,'LineColor','k','ShowText','on','LevelStep',20)
hold on
contour(X,Y,max_growth,'LineColor','r','ShowText','on','LevelList',0,'LineWidth',3)
contour(X,Y,max_growth,'LineColor','b','ShowText','on','LevelList',-6,'LineWidth',2,'LineStyle','--')
xlabel('Combustor Length','FontSize',14)
ylabel('Reflection Coefficient','FontSize',14)
hold off

fig = gcf;
fig.PaperPositionMode = 'auto';
print('stability_map_500Hz','-dtiff','-r600')


