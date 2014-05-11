function C = estimateClass(A, D, X, numOfClasses)

numOfAtoms = size(D, 2)/numOfClasses;
e = [];
n1 = norm(X);

for i = 1 : numOfAtoms : size(D, 2)
    x = X(i : i + numOfAtoms - 1);
    error = norm(x)/n1;
    e = [e error];
end
% figure, stem(e)
[n, C] = max(e);
end