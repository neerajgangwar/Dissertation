G = D'*D;
gamma = omp(D'*A_test, G, sparsity);
pos = 0;
neg = 0;

for i = 1 : size(gamma, 2)
    a = gamma(:, i);
    estClass = estimateClass(A_test(:, i), D, a, 38);
    [C, actualClass] = max(H_test(:, i));
    
    if actualClass == estClass
        pos = pos + 1;
    else
        neg = neg + 1;
    end
    
end

disp(pos);
disp(neg);