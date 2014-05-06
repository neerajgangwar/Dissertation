function [cost, grad_alpha, grad_W] = softmaxCost(W, data, H_train)

% numClasses - the number of classes 
% inputSize - the size N of the input vector
% lambda - weight decay parameter
% data - the N x M input matrix, where each column data(:, i) corresponds to
%        a single test set
% labels - an M x 1 matrix containing the labels corresponding for the input data
%

W = W';

numCases = size(data, 2);
cost = 0;

numClasses = size(H_train, 1);
inputSize = size(data, 1);
grad_W = zeros(numClasses, inputSize);

y = H_train;
m = numCases;

% note that if we subtract off after taking the exponent, as in the
% text, we get NaN
td = W * data;
td = bsxfun(@minus, td, max(td));
temp1 = exp(td);
temp2 = temp1' * W;

denominator = sum(temp1);
p = bsxfun(@rdivide, temp1, denominator);

cost = (-1/m) * sum(sum(y .* log(p)));

grad_W = (-1/m) * (y - p) * data';
grad_W = grad_W';

q = bsxfun(@rdivide, temp2, denominator');

W_temp = [];

for i = 1 : 1 : size(H_train, 2)
    [C, I] = max(H_train(:, i));
    W_temp(i, :) = W(I, :);
end

grad_alpha = - ( W_temp - q );
grad_alpha = grad_alpha';
end