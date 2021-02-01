function compareHistNormal(samples,mu,sigma)
% Plot histogram and show normal distribution with sample mean ans sample
% standard deviation (scaled)
% Inputs
%   samples: samples to plot histogram
%   mu: mean of pdf to compare with
%   sigma: standard deviation of pdf to compare with
% Outputs
%   -
%
% Armin Witte, 2017-03-29

h = histogram(samples); % plot histogram
area = sum(h.Values)*(h.BinEdges(2)-h.BinEdges(1)); % get area for scaling
hold on
X = linspace(min(samples),max(samples)); % x values for pdf
Y = normpdf(X,mean(samples),std(samples))*area; % scaled y values for pdf
plot(X,Y,'r','LineWidth',2); % plot pdf

Y = normpdf(X,mu,sigma)*area; % scaled y values for pdf to compare
plot(X,Y,'g','LineWidth',2); % plot pdf
hold off
