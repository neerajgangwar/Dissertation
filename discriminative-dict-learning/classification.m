D = Di;
G = D'*D;
gamma = computeSparseCodes(A_test, D);
pos = 0;
neg = 0;

for u = 1 : size(gamma, 2)
    a = gamma(:, u);
    estClass = estimateClass(A_test(:, u), D, a, 38);
    [C, actualClass] = max(H_test(:, u));
    
    if actualClass == estClass
        pos = pos + 1;
    else
        neg = neg + 1;
    end
    
end

fprintf([num2str(pos) ' , ' num2str(neg) ' , ' num2str(pos/(pos+neg)) '\n']);