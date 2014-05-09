function alpha = computeSparseCodes(A, D)
    param.lambda = 0.15;
    param.lambda2 = 0;
    param.numThreads = -1;
    param.mode = 2;
    
    alpha = mexLasso(A, D, param);

%     alpha = [];
%     for i = 1 : 1 : size(A, 2)
%         G = D'*D;
%         Gamma = omp(D'*A(:, i), G, 40);
%         alpha = [alpha Gamma];
%     end
end