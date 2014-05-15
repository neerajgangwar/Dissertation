function [D, W] = learn_dictionary(A, H, param)

	num_classes = size(H, 1);
	iterations = param.iter;
	dictsize = param.dictsize;
	sparsity = param.sparsity;
	reg1 = param.reg1;
	reg2 = param.reg2;
	rho = param.rho;
	nu = param.nu;

	t0 = iterations/10;

	[Dinit, Winit] = initialization(A, H, dictsize, sparsity);

	Di = normcols(Dinit);
	Wi = normcols(Winit);
	D = Di;
	W = Wi;

	%% Stochastic Gradient Descent
	% for i = 1 : 1 : iterations
	%     fprintf(['Computing Sparse Code for iteration ' num2str(i) '...\n']);
	%     Di = normcols(Di);
	%     alpha = computeSparseCodes(A, Di);
	%     
	%     
	%     % Stochastic gradient descent
	%     fprintf(['SGD for iteration ' num2str(i) '...\n']);
	%     for j = 1 : 1 : size(alpha, 2)
	%         alp = alpha(:, j);
	%         lambda = find(alp);
	%         [cost, grad_alpha, grad_W] = softmaxCost(Wi(:), numClasses, dictsize, alp(:), H(:, j));
	%         
	%         D_lambda = Di(:, lambda);
	%         grad_alpha_delta = grad_alpha(lambda);
	%         beta_star = zeros(size(alp));
	%         
	%         beta_lambda = ((D_lambda'*D_lambda) + reg2 * eye(size(D_lambda'*D_lambda))) \ grad_alpha_delta;
	%         beta_star(lambda) = beta_lambda;
	%         
	%         % Choosing learning rate
	%         rho = min([rho1 rho1*(t0/i)]);
	%         
	%         Wi = Wi - rho * (grad_W + nu * Wi);
	%         Di = Di - rho * ( (-Di*beta_star*alp') + ((A(:, j) - Di*alp)*beta_star'));
	%     end
	%     Di = normcols(Di);
	%     test
	% end
	% 
	% D = Di;
	% W = Wi;	                            

	%% Gradient Descent
	for i = 1 : 1 : iterations
	    
	    fprintf(['Computing Sparse Code for iteration ' num2str(i) '...\n']);
	    alpha = compute_sparse_codes(A, Di, reg1, reg2);
	    
	    fprintf(['Gradient descent for iteration ' num2str(i) '...\n']);
	    [cost, grad_alpha, grad_W] = softmax_cost(Wi(:), num_classes, dictsize, alpha(:), H);
	    
	    beta_star = [];
	    
	    for j = 1 : 1 : size(alpha, 2)
	        alp = alpha(:, j);
	        lambda = find(alp);
	        D_lambda = Di(:, lambda);
	        grad_alpha_delta = grad_alpha(lambda, j);
	        beta = zeros(size(alp));
	        
	        beta_lambda = ((D_lambda'*D_lambda) + reg2 * eye(size(D_lambda'*D_lambda))) \ grad_alpha_delta;
	        beta(lambda) = beta_lambda;
	        beta_star = [beta_star beta];
	    end
	    
	    rho = min([rho rho*(t0/i)]);
	    
	    Wi = Wi - rho * (grad_W + nu * Wi);
	    delta_D = ( -(Di*beta_star*alpha') + ((A - Di*alpha)*beta_star'));
	    Di = Di - delta_D;
	    Di = normcols(Di);
	    Wi = normcols(Wi);
	    D = Di;
	    W = Wi;
        [H_est, H_act, C, recognition_rate] = classification(D, A, H);
	    fprintf('Recognition rate = %f\n\n', recognition_rate);
	end

end