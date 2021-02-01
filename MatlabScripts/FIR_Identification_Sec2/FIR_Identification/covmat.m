function varcov = covmat(Phi,e,nb,l)
% Compute covariance matrix from inverse Gramian
% Inputs
%   Phi: observation matrix
%   e: residuals
%   nb: number of coefficents
%   l: regularization parameter
% Outputs
%   varcov: covariance matrix
%
% Armin Witte, 2017-03-29
%
% NOT IMPLEMENTED FOR WEIGHTING YET!

PhiGramian = Phi'*Phi + l * eye(nb); % compute Gramian matrix of Phi
varcov = ( PhiGramian )^-1 * var(e); % compute covariance matrix for independent white noise residuals
% varcov = ( Phi' * Phi )^-1 * Phi' * var(e) * Phi * ( Phi' * Phi )^-1; % general covariance???