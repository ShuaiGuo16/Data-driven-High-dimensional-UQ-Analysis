clc
clear
close all hidden

%%
load('data_Luis_30kW_9.5%.mat')

figure;
plot(data)
%%
data = data(ceil(25e-3/data.Ts):0.35/data.Ts);

data.y = ( data.y - mean(data.y) ) / mean(data.y);
data.u = ( data.u - mean(data.u) ) / mean(data.u);

%%
rdata = resample(data,1,500);
fprintf('Nyquist frequency: %f Hz\n',1/(2*rdata.Ts));

%% Identification
nb = 16; % number of non-zero impulse response coefficients
nk = 3; % number of time delays
l = 1; % regularization parameter (0 = no regularization)
model = fir(rdata,nb,nk,l);
varcov = getcov(model);
save 'model_Luis_30kW_9.5%_4_21_350ms.mat' model

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
figure('Name','Compare model output with measured output')
compare(rdata,model)