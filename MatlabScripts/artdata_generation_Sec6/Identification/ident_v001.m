clc
clear
close all hidden

%%
load('data_superlong.mat')
figure(1)
plot(data_timeseries)

%% data shifting
% data = data_timeseries(ceil(1/data_timeseries.Ts):1.7/data_timeseries.Ts);
data = data_timeseries(ceil(1/data_timeseries.Ts):2.4/data_timeseries.Ts);
data4y = data_timeseries(ceil(1/data_timeseries.Ts):2.4/data_timeseries.Ts);
data.y = data4y.y;

data4u =  data_timeseries(ceil(1/data_timeseries.Ts+2):(2.4/data_timeseries.Ts+2));
data.u = data4u.u;

% data.y = ( data.y - mean(data.y) ) / mean(data.y);
% data.u = ( data.u - mean(data.u) ) / mean(data.u);

figure(2)
plot(data)
%%
fprintf('Nyquist frequency: %f Hz\n',1/(2*data.Ts));

%% Identification
nb = 16; % number of non-zero impulse response coefficients
nk = 3; % number of time delays
l = 1; % regularization parameter (0 = no regularization)
model = fir(data,nb,nk,l);
varcov = getcov(model);
save 'ConceptDemo_1400ms.mat' model

%%
figure;
showConfidence(impulseplot(model,30e-3))
axis([0 0.03 -200 800]);

%%
opts = bodeoptions();
opts.MagUnits = 'abs';
opts.FreqUnits = 'Hz';
opts.FreqScale = 'linear';
opts.Xlim = [0 1000];
opts.Ylim = {[0 2],[-2000 0]};
opts.PhaseMatching = 'on';
opts.PhaseMatchingFreq = 0;
opts.PhaseMatchingValue = 0;
figure('Name','Frequency Response');
showConfidence(bodeplot(model,opts))


% %%
% figure('Name','Histogram of Residuals')
% e = resid(rdata,model);
% histNormal(e.y)
% 
% %%
% figure('Name','Compare model output with measured output')
% compare(rdata,model)