function numgrad = compute_numerical_gradient(J, theta)
    % numgrad = computeNumericalGradient(J, theta)
    % theta: a vector of parameters
    % J: a function that outputs a real-number. Calling y = J(theta) will return the
    % function value at theta. 

    % Initialize numgrad with zeros
    numgrad = zeros(size(theta));

    eps = 1e-4;
    n = size(numgrad);
    for i = 1 : n
        fprintf([num2str(i) '\n']);
        I = zeros(size(theta));
        I(i, :) = 1;
        eps_vec = I * eps;
        numgrad(i) = (J(theta + eps_vec) - J(theta - eps_vec)) / (2 * eps);
    end
end
