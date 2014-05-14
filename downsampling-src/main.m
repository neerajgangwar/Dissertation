%% clear command prompt and start libraries
clear all
clc

addpath('./sparse-lib/');

%% load dataset

% for randomfaces, uncomment this code.
% fprintf('Computing D and A_test\n');
% load data/YaleExtendedBDatabase.mat
% feature_dim = input('Please enter feature dimension = ');
% R = randn(feature_dim, size(A_test, 1));
% D = R * double(mat2gray(A_train));
% A_test = R * double(mat2gray(A_test));

% for downsampling, uncomment this code
feature_dim = input('Please enter feature dimension = ');
datafile = ['data/YaleExtendedBDatabase_' num2str(feature_dim) '.mat'];
load(datafile);
D = double(mat2gray(A_train));
A_test = double(mat2gray(A_test));

%% Classification process
pos = 0;
neg = 0;
errorImg = [];

num_classes = size(H_train, 1);
atoms_per_class = ceil(size(D, 2)/num_classes);

fprintf('Atoms per class = %f\n', atoms_per_class);

fprintf('Computing sparse representation...\n');
alpha = compute_sparse_codes(A_test, D);

fprintf('Classification...\n');

H_act = [];
H_est = [];

for i = 1 : 1 : size(alpha, 2)
    alp = alpha(:, i);
    
    try
        face_class = face_classification(D, A_test(:, i), alp, atoms_per_class);
        [C, I] = max(H_test(:, i));
        actual_class = I;
        
        H_act = [H_act actual_class];
        H_est = [H_est face_class];
        
        if face_class == actual_class
            pos = pos + 1;
        else
            neg = neg + 1;
        end
    catch err
        errorImg = [errorImg i];
    end
end

fprintf('Recognition rate = %f\n', pos/(pos+neg));
