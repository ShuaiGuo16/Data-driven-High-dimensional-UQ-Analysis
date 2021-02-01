function data = addNoise2Signal(data,uEx,noiseEx)
data.InputName = uEx;
% noise that is added to excitation signal is of type 'random gaussian
% white noise' and has the same time series length as the excitaion signal
data = [data iddata([],idinput(data.n,'rgs'),data.Ts,'Tstart',data.Tstart,'InputName',noiseEx)];
