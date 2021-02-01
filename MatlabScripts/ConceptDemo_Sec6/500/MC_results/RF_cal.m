clear
clc

load 'f_MC_GR.mat' 
risk_factor = 100*size(find(f_MC_GR(1:40000,3)>0),1)/40000