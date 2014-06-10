function alpha = compute_sparse_codes(A, D, reg1, reg2)
%     param.lambda = reg1;
%     param.lambda2 = reg2;
%     param.numThreads = -1;
%     param.mode = 2;
%     
%     alpha = mexLasso(A, D, param);
    
    G = D'*D;
    alpha = [];
    for f = 1 : 1 : size(A, 2)
        fprintf('%d\n', f);
        alp = SolveBP(D, A(:, f), size(D, 2));
        %alp = omp(D'*A(:, f), G, 200);
        alpha = [alpha alp];
    end
end