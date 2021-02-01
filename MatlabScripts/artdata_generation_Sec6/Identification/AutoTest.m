clear
clc

load('data_Luis_30kW_9.5%.mat')

data = data(ceil(25e-3/data.Ts):end);

data.y = ( data.y - mean(data.y) ) / mean(data.y);
data.u = ( data.u - mean(data.u) ) / mean(data.u);

autocorr(data.y,1000)