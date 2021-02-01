function e = residuals(u,y,b,nb,nk)
% Compute residuals
% Inputs
%   u: system inputs
%   y: system outputs
%   b: impulse response coefficients
%   nb: number of coefficents
%   nk: number of time delays
% Outputs
%   e: residuals (innovations)
%
% Armin Witte, 2017-03-29

N = length(u); % length of time series
yHat = zeros(N,1); % initialize predicted output vector
u_ = [zeros(nb+nk,1); u(:)]; % zero initial conditions

for i = 1:N % for every time step
    yHat(i) = b(:)' * u_(i+nb+nk:-1:i+1); % calculate model output
end

yHat = yHat(nb+nk:end); % cut initial conditions
e = y - yHat; % residials are the difference between true output y and prediction yHat
e = [zeros(nb+nk-1,1); e(:)]; % append zeros for initial conditions