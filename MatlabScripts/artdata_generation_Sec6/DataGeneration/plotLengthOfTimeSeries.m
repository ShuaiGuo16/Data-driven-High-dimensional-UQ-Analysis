clear
clc

init
%% generate input
% Nimpulse = 1e4;
Nimpulse = 3000;
A = 0.10;

dataInput = iddata([],idinput(Nimpulse*nb,'prbs')*uMean*A,sys.Ts);

%% simulate

disp('Starting simulation of tax model')
tic
nMonte = 1;

dataFTF = cell(nMonte,1);

for i = 1:nMonte
    dataFTF{i} = generateData(sys,dataInput,uEx,noiseEx,uPrimeName,qPrimeName);
end

data_timeseries = dataFTF{1}

save 'data_superlong.mat' data_timeseries

