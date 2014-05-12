clear all
clc

A_train = [];
H_train = [];

dim = 56;

fprintf('Loading data...\n');
load data/ARdb.mat
load data/eigenfaces_ARdb.mat

fprintf('Computing D and A_test...\n');
s = S(:, (size(S, 2) - (dim - 1)) : size(S, 2));
p = inv(s'*s)*s';
D = p * double(A_train);
A_test = p * double(A_test);