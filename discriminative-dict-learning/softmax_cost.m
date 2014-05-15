function [cost, grad_alpha, grad_W] = softmax_cost(W, num_classes, input_size, data, H)

    % numClasses - the number of classes 
    % inputSize - the size N of the input vector
    % lambda - weight decay parameter
    % data - the N x M input matrix, where each column data(:, i) corresponds to
    %        a single test set
    % labels - an M x 1 matrix containing the labels corresponding for the input data
    
    data = reshape(data, input_size, size(H, 2));
    W = reshape(W, input_size, num_classes);
    W = W';

    num_cases = size(data, 2);
    cost = 0;

    num_classes = size(H, 1);
    input_size = size(data, 1);
    grad_W = zeros(num_classes, input_size);

    y = H;
    m = num_cases;

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

    for i = 1 : 1 : size(H, 2)
        [C, I] = max(H(:, i));
        W_temp(i, :) = W(I, :);
    end

    grad_alpha = - (1/m) * ( W_temp - q );
    grad_alpha = grad_alpha';
end