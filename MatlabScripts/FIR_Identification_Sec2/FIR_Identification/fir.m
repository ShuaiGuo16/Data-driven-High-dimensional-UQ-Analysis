function mod = fir(data,nb,nk,l)
% Identify a FIR model for a SISO system
% Inputs
%   data: iddata object
%   nb: number of coefficents
%   nk: number of time delays
%   l: regularization parameter
% Outputs
%   mod: idpoly model
%
% Armin Witte, 2017-03-29

u = data.u;
y = data.y;
Ts = data.Ts;

y = y(nb+nk:end); % shorten y to exclude initiial condition
Phi = regressorMatrix(u,nb,nk); % call function to create regression matrix
b = wcls(Phi,y,nb,nk,[],l); % call weighted constrained least squares function
e = residuals(u,y,b,nb,nk); % call function to calculate residuals
varcov = covmat(Phi,e,nb,l); % call function to calculate covariance matrix

mod0 = idpoly([],b(:)',[],[],[],var(e),Ts); % create an idpoly object from data
mod = setcov(mod0,varcov); % set covariance matrix for idpoly model
