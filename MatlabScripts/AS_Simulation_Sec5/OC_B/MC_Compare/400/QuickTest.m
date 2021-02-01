clear
clc

load 'eigenvector_70.mat'
load 'Samples_N_St.mat'

new_input = (V(:,end)'*Samples_N_St')';