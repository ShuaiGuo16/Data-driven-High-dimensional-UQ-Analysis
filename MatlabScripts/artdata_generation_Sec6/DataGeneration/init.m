%% init
%% new  version
% 
fMax = 5000;
sys = scatter(tax('BRS_Tay.slx',fMax));
% sys = scatter(tax('BRS_Tay_compact.slx',fMax));


uPrimeName = 'u_uPrime_y';
qPrimeName = 'Q_uPrime';
%load FTF

% load('model4taxDiscrete_FIRnoise.mat')
load('modelPSD_fit.mat')
load('model_Luis_30kW_9.5%_4_21_350ms.mat');
sta_gain = idpoly(tf(0.1,1));
newTF = [model sta_gain];
newTF.u = modelPSD_fit.u;
newTF.y = modelPSD_fit.y;
nb=16;
% nb= modelPSD_fit.nb(1);  nc= modelPSD_fit.nb(2); nd= modelPSD_fit.nf(2); nf= modelPSD_fit.nf(1);
model4tax = ss(newTF);

FTFref = model4tax;
model4tax = sss(model4tax);
model4tax.y = {qPrimeName};
model4tax.u{1} = uPrimeName;
sys.Ts = model4tax.Ts;
%connect FTF and tax
sys = connect(sys,model4tax,{'02f',model4tax.u{2},'07g'}',{model4tax.y{1} ,uPrimeName,'07f_y','02g_y' }');

index = getBlock(sys,'scatter1');
uMean = sys.Blocks{index}.Connection{2}.Mach*sys.Blocks{index}.Connection{2}.c;

% noiseEx = 'v@y1'
noiseEx = sys(:,'v@y1').u{1};
uEx  = '02f';


f  = linspace(0,1/2/sys.Ts,1e3);

