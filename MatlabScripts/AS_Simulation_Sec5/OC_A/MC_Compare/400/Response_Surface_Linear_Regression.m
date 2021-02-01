clear
clc


% --------------------------------------------------------------------------------
% Description:      Response surface construction - low-order model
% --------------------------------------------------------------------------------
% Method:           (Response surface)   Linear Regression 
%                                      
% --------------------------------------------------------------------------------
% Steps:            1* Load eigenvalue & eigenvector from Active Subspace
%                      run 
%                   2* Define dimension of reduced model
%                   3* Sampling - Latin Hypercube
%                   4* Obtain training data for low-order model
%                   5* Construct relevant matrix & compute regression
%                      coefficients
%                   6* Monte Carlo simulation on low-order model
%                   7* Risk factor computation
%                   8* Assessment of linear regression (optional)
% --------------------------------------------------------------------------------

% --------------------------------------------------------------------------------
% 1* Load eigenvalue & eigenvector from Active Subspace run 
% --------------------------------------------------------------------------------
load ('eigenvector_70.mat');                   % eigenvector matrix
% --------------------------------------------------------------------------------

% --------------------------------------------------------------------------------
% 2* Define dimension of reduced model
% --------------------------------------------------------------------------------
n = 1;                                                % dimension of reduced model
m = size(V,1);
eg_vector = fliplr(V(:,end-n+1:end));                 % eigenvector matrix partition
% --------------------------------------------------------------------------------

% --------------------------------------------------------------------------------
% 5* Construct relevant matrix & compute regression coefficients
% --------------------------------------------------------------------------------
load 'f_GR.mat'
load 'Samples_N_St.mat'
new_input = V(:,end)'*Samples_N_St';

index = [5,12,19,22,31,37,91];
X = ones(7,n+2);
X(:,2) = new_input(index);
X(:,3) = new_input(index).^2;

beta = regress(f_GR(index,3),X);    % regression coefficients
save 'beta.mat' beta
% --------------------------------------------------------------------------------

figure(1)
new_input = V(:,end)'*Samples_N_St';
plot(new_input,f_GR(:,3),'ko')
hold on

coor_x = -3:0.05:3;
coor_y = beta(1)+beta(2)*coor_x+beta(3)*coor_x.^2;
plot(coor_x,coor_y)
hold off
