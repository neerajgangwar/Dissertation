function [H_est, H_act, C, recognition_rate] = classification(D, A, H)

	% function classifies the test samples w.r.t. dictionary D
	% Input:
	%		D : discriminative dictionary
	%		A : N x M matrix with M test samples of dimension N.
	% 		H : Label information of all samples.
	% Output:
	%		H_est : A vector of size M x 1 with estimated classes of each test sample.
	%		H_act : A vector of size M x 1 with actual classes of each test sample.
	%		C : Confusion matrix
	%		recognition_rate : Recognition rate (%)

	H_act = [];
	H_est = [];

	atoms_per_class = ceil(size(D, 2)/size(H, 1));
	gamma = compute_sparse_codes(A, D);
	pos = 0;
	neg = 0;

	for u = 1 : size(gamma, 2)
	    a = gamma(:, u);
	    est_class = face_classification(D, A(:, u), a, atoms_per_class);
	    [C, actual_class] = max(H(:, u));
	    
	    H_est = [H_est est_class];
	    H_act = [H_act actual_class]

	    if actual_class == est_class
	        pos = pos + 1;
	    else
	        neg = neg + 1;
	    end
	    
	end

	C = confusionmat(H_act, H_est);
	recognition_rate = pos*100/(pos + neg);
end