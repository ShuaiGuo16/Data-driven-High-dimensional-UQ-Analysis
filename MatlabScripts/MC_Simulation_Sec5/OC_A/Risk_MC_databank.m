clear
clc

% --------------------------------------------------------------------------------
% Description:      Risk factor computation - Monte Carlo Simulation
% --------------------------------------------------------------------------------
% Method:           (Random sampling)   Monte Carlo Sampling 
%                                    
% --------------------------------------------------------------------------------
% Steps:            1* Generate sampling points 
%                       2* Evaluate
%                       3* Plot converged results
% --------------------------------------------------------------------------------

% --------------------------------------------------------------------------------
% 1* Generate sampling points
% --------------------------------------------------------------------------------
load 'model_Luis_30kW_9.5%_4_21_350ms.mat'                                  % load original FIR model
temp_mean = model.B(4:19);                                                           % Mean values of FTF data
temp_cov = getcov(model);                                                                  % Covariance matrix of original data

% Orthogonal transformation matrix calculation
[Con_V,Cov_D] = eig(temp_cov);                   
A = Con_V';                                                 % Transformation matrix

% Normalization parameters
mean_translation = A*temp_mean';                            % Translational value for mean
variance_translation = sqrt(diag(Cov_D));                   % Translational value for variance

sample_num=40000;                                        % each uncertain coefficients

f_MC_GR = zeros(sample_num,3);
f_MC_FR = zeros(sample_num,3);

for loop_i=1:16
    Samples_St(:,loop_i) = normrnd(0,1,sample_num,1);     % Construst a sample matrix
end   

save 'Samples_St.mat' Samples_St

for index = 1:16
    Samples_tunning_full(:,index) = Samples_St(:,index)*variance_translation(index) + mean_translation(index);
end
Samples = (A'*Samples_tunning_full')';
% ----------------------------------------------------------------------------------

% ----------------------------------------------------------------------------------
% 2* Evaluate
% ----------------------------------------------------------------------------------
Remaining_step = sample_num;
options = optimoptions('fsolve','Display','off');
initial_value = [45.94*2*pi,-50.15;107.6*2*pi,-70.94;426.37*2*pi,-6];   % 3 modes based on derterministic analzsis

for index=1:sample_num
    
    h = Samples(index,:);
    
    for k = 1:3
        
        EigenFun = @(omega) Eigenmode_solver(omega,h);
        Eigen = fsolve(EigenFun, initial_value(k,1)-initial_value(k,2)*1i,options);    % solving characteristic equation
        f_MC_FR(index,k) = real(Eigen)/(2*pi);
        f_MC_GR(index,k) = -imag(Eigen);
    
    end


    Remaining_step = Remaining_step -1
    
    
end

save 'f_MC_GR.mat' f_MC_GR
save 'f_MC_FR.mat' f_MC_FR
% -----------------------------------------------------------------------------------

% -----------------------------------------------------------------------------------
% 3* plot convergence results
% -----------------------------------------------------------------------------------
for j=1:100
    boundary=j*400;
    risk_factor(j) = 100*size(find(f_MC_GR(1:boundary,3)>0),1)/boundary;
end

figure(1)
plot(400:400:40000,risk_factor,'-o')
% ------------------------------------------------------------------------------------
figure(2)
histogram(f_MC_GR(:,3),'Normalization','pdf')

figure(3)
plot(f_MC_GR(:,3),f_MC_FR(:,3),'o')
