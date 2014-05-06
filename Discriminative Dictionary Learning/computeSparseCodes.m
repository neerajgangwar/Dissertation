function alpha = computeSparseCodes(A_train, D)
%     param.lambda = 0.25;
%     param.lambda2 = 0;
%     param.numThreads = -1;
%     param.mode = 2;
%     
%     alpha = mexLasso(A_train, D, param);

    alpha = [];
    for i = 1 : 1 : size(A_train, 2)
        G = D'*D;
        Gamma = omp(D'*A_train(:, i), G, 40);
        alpha = [alpha Gamma];
    end
end