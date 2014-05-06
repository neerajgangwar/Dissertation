a = A_train(:, 1:32);
alpha = computeSparseCodes(a, D);
plot(alpha)
classification