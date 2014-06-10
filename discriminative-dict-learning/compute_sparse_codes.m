function alpha = compute_sparse_codes(A, D, reg1, reg2)
    param.lambda = reg1;
    param.lambda2 = reg2;
    param.numThreads = -1;
    param.mode = 2;
    
    alpha = mexLasso(A, D, param);

%     alpha = [];
%     for f = 1 : 1 : size(A, 2)
%         alp = olveBP(D, A(:, f), size(D, 2));
%         alpha = [alpha alp];
%     end
end