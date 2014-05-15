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
load Data/YaleExtendedBDatabase_504.mat

A_train = mat2gray(A_train);
A_test = mat2gray(A_test);

numClasses = size(H_train, 1);
param.iter = 200;
param.dictsize = 38*20;
param.sparsity = 30;
param.reg1 = 0.25;
param.reg2 = 0.01;
param.rho = 10;
param.nu = 10^(-5); 

[D, W] = learn_dictionary(A_train, H_train, param);