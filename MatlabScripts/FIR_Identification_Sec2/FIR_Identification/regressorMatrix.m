function Phi = regressorMatrix(u,nb,nk)
% Assemble regressor matrix
% Inputs
%   u: system inputs
%   nb: number of coefficents
%   nk: number of time delays
% Outputs
%   Phi: regressor matrix
%
% Armin Witte, 2017-03-29

N = length(u); % length of time series
Phi = zeros(N-nb+1-nk,nb); % initialize observation matrix
for i = 1:nb % for every coefficient
    Phi(:,i) = u((nb-i+1):(N-i+1-nk)); % write u in a column of Phi with the right offset
end