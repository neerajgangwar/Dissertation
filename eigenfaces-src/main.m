clear all
clc

feature_extraction    

%% Classification process
pos = 0;
neg = 0;
errorImg = [];

num_classes = size(H_train, 1);
atoms_per_class = size(D, 2)/num_classes;

fprintf('Atoms per class = %f\n', atoms_per_class);

fprintf('Computing sparse representation...\n');
alpha = compute_sparse_codes(A_test, D);

fprintf('Classification...\n');

for i = 1 : 1 : size(alpha, 2)
    alp = alpha(:, i);
    
    try
        face_class = face_classification(D, A_test(:, i), alp, atoms_per_class);
        [C, I] = max(H_test(:, i));
        actual_class = I;
        
        if face_class == actual_class
            pos = pos + 1;
        else
            neg = neg + 1;
        end
    catch err
        errorImg = [errorImg i];
    end
end

fprintf('Recognition rate = %f\n', pos/(pos+neg));