function [dataFTF,dataFTF_fg , SNR] = generateData(sys,dataInput,uEx,noiseEx,uPrimeName,qPrimeName)
datau = addNoise2Signal(dataInput,uEx,noiseEx);
data = sim(sys,datau);
dataFTF = iddata(data(:,qPrimeName,[]).y,data(:,uPrimeName,[]).y,data.Ts,'InputName','u','OutputName','q');

dataFTF_fg = [dataFTF data(:,[3,4],1)];

sys.Blocks{getBlock(sys,'uPrime')};

datau(:,[],'v@y1').u = zeros(size(datau(:,[],'v@y1').u));
dataNoNoise = sim(sys,datau);
dataNoNoise = iddata(dataNoNoise(:,qPrimeName,[]).y,dataNoNoise(:,uPrimeName,[]).y,dataNoNoise.Ts,'InputName','u','OutputName','q');

SNR = var(dataNoNoise.y)./var(dataFTF.y-dataNoNoise.y);
