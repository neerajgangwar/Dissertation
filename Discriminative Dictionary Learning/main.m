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

iterations = 15;
dictsize = 38*15;
sparsity = 25;

reg2 = 0.01;
t0 = iterations/10;
rho = 2;
nu = 10^(-5); 

[Dinit, Winit] = initialization(A_train, H_train, dictsize, sparsity);
D1 = Dinit;

%% Task Driven Dictionary Learning
D = [];
W = [];
Di = normcols(Dinit);
Wi = Winit;

%% Stochastic Gradient Descent
% for i = 1 : 1 : iterations
%     fprintf(['Computing Sparse Code for iteration ' num2str(i) '...\n']);
%     alpha = computeSparseCodes(A_train(:, 1), Di);
%     
%     
%     % Stochastic gradient descent
%     fprintf(['SGD for iteration ' num2str(i) '...\n']);
%     for j = 1 : 1 : size(alpha, 2)
%         alp = alpha(:, j);
%         lambda = find(alp);
%         [cost, grad_alpha, grad_W] = softmaxCost(Wi, alp, H_train(:, j));
%         
%         D_lambda = Di(:, lambda);
%         grad_alpha_delta = grad_alpha(lambda);
%         beta_star = zeros(size(alp));
%         
%         beta_lambda = ((D_lambda'*D_lambda) + reg2 * eye(size(D_lambda'*D_lambda))) \ grad_alpha_delta;
%         beta_star(lambda) = beta_lambda;
%         
%         % Choosing learning rate
%         rho_t = min([rho rho*(t0/i)]);
%         
%         Wi = Wi - rho_t * (grad_W + nu * Wi);
%         Di = Di - rho_t * ( (-Di*beta_star*alp') + ((A_train(:, j) - Di*alp)*beta_star'));
%         Di = normcols(Di);
%     end
% end
% 
% D = Di;
% W = Wi;


%% Gradient Descent
for i = 1 : 1 : iterations
    fprintf(['Computing Sparse Code for iteration ' num2str(i) '...\n']);
    alpha = computeSparseCodes(A_train, Di);
    fprintf(['Gradient descent for iteration ' num2str(i) '...\n']);
    [cost, grad_alpha, grad_W] = softmaxCost(Wi, alpha, H_train);
    
    beta_star = [];
    
    for j = 1 : 1 : size(alpha, 2)
        alp = alpha(:, j);
        lambda = find(alp);
        D_lambda = Di(:, lambda);
        grad_alpha_delta = grad_alpha(lambda, j);
        beta = zeros(size(alp));
        
        beta_lambda = ((D_lambda'*D_lambda) + reg2 * eye(size(D_lambda'*D_lambda))) \ grad_alpha_delta;
        beta(lambda) = beta_lambda;
        
        beta_star = [beta_star beta];
        
    end
    D = Di;
    W = Wi;
    Wi = Wi - rho * (grad_W + nu * Wi);
    Di = Di - rho * ( (-Di*beta_star*alpha') + ((A_train - Di*alpha)*beta_star'));
    Di = normcols(Di);
end
  
