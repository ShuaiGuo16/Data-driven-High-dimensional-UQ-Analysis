function b = wcls(varargin)
% Compute weighted constrained least squares estimate
% Inputs
%   Phi: regressor matrix
%   y: system outputs
%   nb: number of coefficents
%   nk: number of time delays
%   W: weigting vector/matrix
%   l: regularization parameter
% Outputs
%   b: impulse response coefficients
%
% Armin Witte, 2017-03-29

Phi = varargin{1};
y = varargin{2};
nb = varargin{3};
nk = varargin{4};
W = varargin{5};
l = varargin{6};

% set wighting to 1 if not specified
[m,n] = size(W);
if m == 0 || n == 0
    W = eye(size(Phi,1));
elseif m == 1 || n == 1
    W = diag(W);
end

% set regularization to 0 if not specified
if isempty(l)
    l = 0;
end

b_ = (Phi' * W * Phi + l*eye(nb))^-1 * Phi' * W * y; % compute weighted constrained least squares estimate
b = [zeros(nk,1);b_]; % set zeros for nk