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
iterations = 200;
dictsize = 38*20;
sparsity = 30;

reg2 = 0.01;
t0 = iterations/20;
rho1 = 10;
rho2 = 0.1;
nu = 10^(-3); 

[Dinit, Winit] = initialization(A_train, H_train, dictsize, sparsity);

% load Data/dict.mat
%% Task Driven Dictionary Learning
D = [];
W = [];
Di = Dinit;
Wi = Winit;

%% Stochastic Gradient Descent
% for i = 1 : 1 : iterations
%     fprintf(['Computing Sparse Code for iteration ' num2str(i) '...\n']);
%     Di = normcols(Di);
%     alpha = computeSparseCodes(A_train, Di);
%     
%     
%     % Stochastic gradient descent
%     fprintf(['SGD for iteration ' num2str(i) '...\n']);
%     for j = 1 : 1 : size(alpha, 2)
%         alp = alpha(:, j);
%         lambda = find(alp);
%         [cost, grad_alpha, grad_W] = softmaxCost(Wi(:), numClasses, dictsize, alp(:), H_train(:, j));
%         
%         D_lambda = Di(:, lambda);
%         grad_alpha_delta = grad_alpha(lambda);
%         beta_star = zeros(size(alp));
%         
%         beta_lambda = ((D_lambda'*D_lambda) + reg2 * eye(size(D_lambda'*D_lambda))) \ grad_alpha_delta;
%         beta_star(lambda) = beta_lambda;
%         
%         % Choosing learning rate
%         rho = min([rho1 rho1*(t0/i)]);
%         
%         Wi = Wi - rho * (grad_W + nu * Wi);
%         Di = Di - rho * ( (-Di*beta_star*alp') + ((A_train(:, j) - Di*alp)*beta_star'));
%     end
%     Di = normcols(Di);
%     test
% end
% 
% D = Di;
% W = Wi;

mat_gradW = [];
mat_gradAlp = [];
mat_cost = [];


%% Debugging code
% W = [Wi(:)];
% d = [alpha(:)];
% alpha = computeSparseCodes(A_train, Di);
% [cost, grad_alpha, grad_W] = softmaxCost(Wi, numClasses, dictsize, d, H_train);
% numGrad = computeNumericalGradient( @(x) softmaxCost(W, numClasses, dictsize, x, H_train), d);
                            

%% Gradient Descent
for i = 1 : 1 : iterations
    
%     if i > 6
%         fprintf('');
%     end
    
    classification
    test
    
    fprintf(['Computing Sparse Code for iteration ' num2str(i) '...\n']);
    tic
    alpha = computeSparseCodes(A_train, Di);
    toc
    
    fprintf('Norm of alpha = %f\n', norm(alpha(:)));
    
    fprintf(['Gradient descent for iteration ' num2str(i) '...\n']);
    [cost, grad_alpha, grad_W] = softmaxCost(Wi(:), numClasses, dictsize, alpha(:), H_train);
    
    mat_gradW = [mat_gradW norm(grad_W)];
    mat_gradAlp = [mat_gradAlp norm(grad_alpha)];
    mat_cost = [mat_cost norm(cost)];
    
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
        % Di = Di - rho1 * ( (-Di*beta*alp') + ((A_train(:, j) - Di*alp)*beta'));
    end
    
    rho = min([rho1 rho1*(t0/i)]);
    fprintf(['rho = ' num2str(rho) '\n']);
    
    Wi = Wi - rho * (grad_W + nu * Wi);
    % Di = Di - rho * ( -(Di*beta_star*alpha') + ((A_train - Di*alpha)*beta_star'));
    delta_D = ( -(Di*beta_star*alpha') + ((A_train - Di*alpha)*beta_star'));
    Di = Di - delta_D;
    Di = normcols(Di);
    
    D = Di;
    W = Wi;
    fprintf('\n');
end