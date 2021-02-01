clear
clc

% --------------------------------------------------------------------------------
% Description:      Active Subspace method - dimension reduction
% --------------------------------------------------------------------------------
% Method:           (Random sampling)   1) Latin Hypercube Sampling for M
%                                       2) Latin Hypercube Sampling for N
%                   (Model reduction)   Active Subspace                   
% --------------------------------------------------------------------------------
% Steps:            1* Define approximation accuracy
%                   2* Orthogonal transformation & normalization
%                   3* Create sampling points 
%                   4* Evaluate at N points (Algorithm 1.2)
%                   5* Find p nearst points
%                   6* Eigenvalue decomposition
%                   7* Plot eigenvalue
%                   8* Sufficient summary plot
% --------------------------------------------------------------------------------

%% 1* Define approximation accuracy

m = 16;                                  % Dimension, number of elements in input vector
k = 3;                                   % One greater than the largest dimension in subsequent analysis
alpha = 8;                               % Oversampling factor

N = 400;                                 % Reference value for N is alpha * m
M = round(alpha * k * log(m));            % Reference value for M is alpha * k * log(m)
p = 30;                                  % Reference value for p is between (m+1) & N
% ---------------------------------------------------------------------------------


%% 2* Orthogonal transformation & normalization

load 'model_Luis_30kW_9.5%_4_21_350ms.mat'                             % load original FIR model
temp_mean = model.B(4:19);                                % Mean values of original data
temp_cov = getcov(model);                                   % Covariance matrix of original data

% Orthogonal transformation matrix calculation
[Con_V,Cov_D] = eig(temp_cov);                   
A = Con_V'; 

% Normalization parameters
mean_translation = A*temp_mean';                            % Translational value for mean
variance_translation = sqrt(diag(Cov_D));                         % Translational value for variance
% ----------------------------------------------------------------------------------


%% 3* Create sampling points 

% Latin Hypercube Sampling for N - Sampling based on standard distribution                                     
Samples_N_St = lhsnorm(zeros(m,1),diag(ones(m,1)),N);      % Original points [N * full dimention]

save 'Samples_N_St.mat' Samples_N_St

% Undo normalization
for i = 1:m
    Samples_N_temp(:,i) = Samples_N_St(:,i)*variance_translation(i) + mean_translation(i);
end
Samples_N = (A'*Samples_N_temp')';

save 'Samples_N.mat' Samples_N

% Latin Hypercube Sampling for M - Sampling based on standard distribution                                     
Samples_M_St = lhsnorm(zeros(m,1),diag(ones(m,1)),M);      % Original points [M * full dimention]

save 'Samples_M_St.mat' Samples_M_St
% ----------------------------------------------------------------------------------


%% 4* Evaluate at N points 

C = zeros(m,m);                                           % Covariance matrix
f_GR = zeros(N,1);                                        % Growth Rate vector
f_FR = zeros(N,1);                                        % Frequency vector
initial_value = [107.6*2*pi,-4];   % 3 modes based on derterministic analzsis

remaining_steps = N;                                     % Counter

options = optimoptions('fsolve','Display','off');
for index = 1:N
   
    h = Samples_N(index,:);    % current sample
    
    
        
        EigenFun = @(omega) Eigenmode_solver(omega,h);
        Eigen = fsolve(EigenFun, initial_value(1)-initial_value(2)*1i,options);    % solving characteristic equation
        f_FR(index) = real(Eigen)/(2*pi);
        f_GR(index) = -imag(Eigen);
    
    
    
    remaining_steps = remaining_steps -1                  % Display counter
    
end

save 'f_GR.mat' f_GR
save 'f_FR.mat' f_FR
% --------------------------------------------------------------------------------


%% 5* Find p nearst points

for M_num = 1:M
    
    [ index ] = Find_p_points(Samples_M_St(M_num,:),Samples_N_St, p);
    
    % Least-squares fitting
    Y = f_GR(index);                 % Response value
    X = ones(p,m+1);
    
    for j = 1:p
        X(j,2:end) = Samples_N_St(index(j),:);
    end
    
    beta = regress(Y,X);    % regression coefficients
    
    C = C + beta(2:end)*beta(2:end)';
    
end

C = C/M;
% ---------------------------------------------------------------------------------


%% 6* Eigenvalue decomposition - in natural order

[V,D] = eig(C);
save 'eigenvalue_70' D
save 'eigenvector_70' V
% ---------------------------------------------------------------------------------


%% 7* Eigenvalue plot  - normalized eigenvalue

figure(1)
semilogy(m:-1:1,diag(D)/D(end,end),'k*')     % in decreasing order
% ---------------------------------------------------------------------------------

%% 8* Sufficient Summary Plot

% Ragrading the first active variable
figure(2)
new_input = V(:,end)'*Samples_N_St';
plot(new_input,f_GR,'ko')
% ---------------------------------------------------------------------------------

figure(3)
plot(f_GR,f_FR,'ko')
hold off
