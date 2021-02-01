clear
clc

load 'ConceptDemo_1400ms.mat'

figure;
showConfidence(impulseplot(model,30e-3))
axis([0 0.03 -200 800]);

fig = gcf;
fig.PaperPositionMode = 'auto'
print('FIR_1400ms','-dtiff','-r600')