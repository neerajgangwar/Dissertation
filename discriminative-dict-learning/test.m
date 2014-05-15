% computes recognition rate using trained parameter W
D = Di;
W = Wi;
alpha = computeSparseCodes(A_test, D);
pos = 0;
neg = 0;

for v = 1 : 1 : size(alpha, 2)
    alp = alpha(:, v);
    temp = W' * alp;
    [C, I] = max(temp);
    [D, J] = max(H_test(:, v));
    if I == J
        pos = pos + 1;
    else
        neg = neg + 1;
    end
end

percentage = pos*100/(pos + neg);
fprintf(['Classification rate using W ' num2str(percentage) '\n']);

%% Debugging code
% W = [Wi(:)];
% d = [alpha(:)];
% alpha = computeSparseCodes(A_train, Di);
% [cost, grad_alpha, grad_W] = softmaxCost(Wi, numClasses, dictsize, d, H_train);
% numGrad = computeNumericalGradient( @(x) softmaxCost(W, numClasses, dictsize, x, H_train), d);