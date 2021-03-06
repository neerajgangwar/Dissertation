function [Dinit, Winit] = initialization(training_feats, H_train, dictsize, sparsitythres)

    fprintf(['Initialization...\n']);

    %% Use k-SVD for each class separately and concatinate
    num_class = size(H_train, 1); % number of objects
    num_per_class = round(dictsize/num_class); % initial points from each classes
    Dinit = []; % for LC-Ksvd1 and LC-Ksvd2

    iterations = 20;

    for classid = 1 : num_class
        col_ids = find(H_train(classid, :)==1);
        data_ids = find(colnorms_squared_new(training_feats(:, col_ids)) > 1e-6);   % ensure no zero data elements are chosen
        perm = [1 : length(data_ids)]; 
        Dpart = training_feats(:, col_ids(data_ids(perm(1 : num_per_class))));
        para.data = training_feats(:, col_ids(data_ids));
        para.Tdata = sparsitythres;
        para.iternum = iterations;
        para.memusage = 'high';
        % normalization
        para.initdict = normcols(Dpart);
        % ksvd process
        [Dpart, Xpart, Errpart] = ksvd(para, '');
        Dinit = [Dinit Dpart];
    end

    %% Generate random dictionary
    % Dinit = randn(size(training_feats, 1), dictsize);
    % Winit = randn(dictsize, numClass);

    %% Use k-SVD for all class and generate a reconstructive dictionary
    % Dpart = training_feats(:, 1 : dictsize);
    % para.data = training_feats;
    % para.Tdata = sparsitythres;
    % para.iternum = 5;
    % para.memusage = 'high';
    % para.initdict = normcols(Dpart);
    % [Dinit, Xpart, Errpart] = ksvd(para, '');

    %% Use SPAMS to generate dictionary
    % param.K = dictsize;  % learns a dictionary with 100 elements
    % param.lambda = 0.15;
    % param.numThreads = -1; % number of threads
    % param.batchsize = 400;
    % param.verbose = true;
    % param.iter = 1000;
    % Dinit = mexTrainDL(training_feats,param);


    %% Calculate Winit
    param1.lambda = 0.15;
    param1.lambda2 = 0;
    param1.numThreads = -1;
    param1.mode = 2;

    X = mexLasso(training_feats, Dinit, param1);

    Winit = inv(X*X'+eye(size(X*X')))*X*H_train';
end
