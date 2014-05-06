% ========================================================================
% Initialization for Label consistent KSVD algorithm
% USAGE: [Dinit,Tinit,Winit,Q] = initialization4LCKSVD(training_feats,....
%                               H_train,dictsize,iterations,sparsitythres)
% Inputs
%       training_feats  -training features
%       H_train         -label matrix for training feature [each row correspond to a class and 1's in the row indicate that feature with that index belong to that class]
%       dictsize        -number of dictionary items
%       iterations      -iterations
%       sparsitythres   -sparsity threshold
% Outputs
%       Dinit           -initialized dictionary
%       Winit           -initialized classifier parameters
% ========================================================================


function [Dinit, Winit] = initialization(training_feats, H_train, dictsize, sparsitythres)

fprintf(['Initialization...\n']);
% numClass = size(H_train, 1); % number of objects
% numPerClass = round(dictsize/numClass); % initial points from each classes
% Dinit = []; % for LC-Ksvd1 and LC-Ksvd2
% 
% iterations = 5;
% 
% for classid = 1 : numClass
%     col_ids = find(H_train(classid, :)==1);
%     data_ids = find(colnorms_squared_new(training_feats(:, col_ids)) > 1e-6);   % ensure no zero data elements are chosen
%     perm = [1 : length(data_ids)]; 
%     Dpart = training_feats(:, col_ids(data_ids(perm(1 : numPerClass))));
%     para.data = training_feats(:, col_ids(data_ids));
%     para.Tdata = sparsitythres;
%     para.iternum = iterations;
%     para.memusage = 'high';
%     % normalization
%     para.initdict = normcols(Dpart);
%     % ksvd process
%     [Dpart, Xpart, Errpart] = ksvd(para, '');
%     Dinit = [Dinit Dpart];
% end

% Dinit = randn(size(training_feats, 1), dictsize);
% Winit = randn(dictsize, numClass);
Dpart = training_feats(:, 1 : dictsize);
para.data = training_feats;
para.Tdata = sparsitythres;
para.iternum = 5;
para.memusage = 'high';
para.initdict = normcols(Dpart);
[Dinit, Xpart, Errpart] = ksvd(para, '');

param1.lambda = 0.15;
param1.lambda2 = 0;
param1.numThreads = -1;
param1.mode = 2;

X = mexLasso(training_feats, Dinit, param1);

Winit = inv(X*X'+eye(size(X*X')))*X*H_train';
 
