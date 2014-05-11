%% Clear command prompt
clear all
clc

%% Load training data
fprintf('Loading data...\n');
load YaleExtendedBDatabase.mat A_train

%% Make data zero mean
fprintf('Making data zero mean...\n');
mu = mean(A_train, 2);
A = A_train - repmat(mu, 1, size(A_train, 2));

%% Eigenvectors and eigenvalues of covariance matrix C
fprintf('Computing covariance matrix...\n');
C = A'*A;

fprintf('Computing eigenvectors...\n');
[S, D] = eig(C);
S = A*S;

%% Save data in a mat file
fprintf('Saving data...\n');
save eigenfacesYale S D

fprintf('Done! :)\n');