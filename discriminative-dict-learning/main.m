%% Alogrithm is taken from
% Mairal, J.; Bach, F.; Ponce, J., "Task-Driven Dictionary Learning," Pattern Analysis and Machine Intelligence,
% IEEE Transactions on , vol.34, no.4, pp.791,804, April 2012

%% clear the window
clear all
clc

%% start libraries
addpath(genpath('./ksvdbox'));  % add K-SVD box
addpath(genpath('./OMPbox')); % add sparse coding algorithem OMP
start_spams

%% load features
db = input('Please enter DB name = ', 's');
dimension = input('Please enter feature dimension = ');
if strcmp(db, 'yale') == 1
    datafile = ['data/YaleExtendedBDatabase_' num2str(dimension) '.mat'];
elseif strcmp(db, 'ardb') == 1
    datafile = ['data/ARdb_' num2str(dimension) '.mat'];
else
    fprintf('Please enter a vaild DB name.\n');
end


load(datafile);

A_train = mat2gray(A_train);
A_test = mat2gray(A_test);

numClasses = size(H_train, 1);
param.iter = 500;
param.dictsize = 100*7;
param.sparsity = 12;
param.reg1 = 0.25;
param.reg2 = 0.01;
param.rho = 10;
param.nu = 10^(-5); 

[D, W] = learn_dictionary(A_train, H_train, A_test, H_test, param);

[H_est, H_act, C, recognition_rate] = classification(D, A_test, H_test);

result_file = ['results/' db '/result_' num2str(dimension) '.mat'];
save(result_file, 'H_est', 'H_act', 'C');