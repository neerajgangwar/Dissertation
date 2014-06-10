clear all
clc

addpath('./OMPbox/');
addpath('./ksvdbox/');
addpath('./sparse-lib/');

% load data/ARdb_130.mat
D = randn(64, 400);
Y = randn(64, 1000);

% a = double(mat2gray(A_train));
para.data = Y;
para.Tdata = 35;
para.iternum = 50;
para.memusage = 'high';
para.dictsize = 400;
fprintf('K-SVD...\n');
[D, X, E] = ksvd(para, '');


% alpha = [];
% for i = 1 : size(a, 2)
%     x = SolveBP(D, a(:, i), size(D, 2));
%     alpha = [alpha x];
%     fprintf('%d\n', i);
% end
%%
e = Y - D * X;
norm_e = [];
for i = 1 : size(e, 2)
norm_e = [norm_e norm(e(:, i))/norm(Y(:, i))];
end
plot(norm_e)