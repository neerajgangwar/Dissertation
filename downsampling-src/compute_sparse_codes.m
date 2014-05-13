function alpha = compute_sparse_codes(A, D)
%     param.lambda = 0.15;
%     param.lambda2 = 0;
%     param.L = 20;
%     param.numThreads = -1;
%     param.mode = 2;
%     alpha = mexOMP(A, D, param);
%     alpha = SolveBP(D, A, size(D, 2));

    alpha = [];
    for j = 1 : 1 : size(A, 2)
        alp = SolveBP(D, A(:, j), size(D, 2));
        alpha = [alpha alp];
    end
end