function mod = firBootstrap(data,nb,nk,l,nBoot)
% Identify a FIR model for a SISO system and evaluate covariance with
% bootstrapping
% Inputs
%   data: iddata object
%   nb: number of coefficents
%   nk: number of time delays
%   l: regularization parameter
%   nBoot: number of bootrstrap samples
% Outputs
%   mod: idpoly model
%
% Armin Witte, 2017-03-29

u = data.u;
y = data.y;
Ts = data.Ts;

y = y(nb+nk:end); % shorten y to exclude initiial condition
Phi = regressorMatrix(u,nb,nk); % call function to create regression matrix

bBootstrap = zeros(nBoot,nb+nk); % array for coefficient vectors
N = length(y);
for n = 1:nBoot
    resort = ceil(rand(N,1)*N); % get a resort vector (mask)
    y_ = y(resort); % resort output
    Phi_ = Phi(resort,:); % resort regressor matrix
    b_ = wcls(Phi_,y_,nb,nk,[],l); % calculate weighted constrained least squares estimate 
    bBootstrap(n,:) = b_(:); % save in array
end

b = mean(bBootstrap); % use mean of bootstrap samples
e = residuals(u,y,b,nb,nk); % call function to calculate residuals

% figure('Name','sorted values from resampling')
% plot(sort(resort))

varcov_ = cov(bBootstrap); % calculate covariance matrix from bootstrap data
varcov = varcov_(nk+1:end,nk+1:end); % cut the zeros because of nk
mod0 = idpoly([],b(:)',[],[],[],var(e),Ts); % create an idpoly object from data
mod = setcov(mod0,varcov); % set covariance matrix for idpoly model





