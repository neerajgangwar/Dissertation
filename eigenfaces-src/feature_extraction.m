clear all
clc

A_train = [];
H_train = [];

db = input('Please enter DB name [yale/ardb]= ', 's');
dim = input('Please enter feature dimension = ');

fprintf('Loading data...\n');
if strcmp(db, 'ardb') == 1
	load data/ARdb.mat
	load data/eigenfaces_ARdb.mat
elseif strcmp(db, 'yale') == 1
	load data/YaleExtendedBDatabase.mat
	load data/eigenfaces_yale.mat
else
	fprintf('DB name is not valid.\n');
	return;
end 		

fprintf('Computing D and A_test...\n');
s = S(:, (size(S, 2) - (dim - 1)) : size(S, 2));
p = inv(s'*s)*s';
D = p * double(A_train);
A_test = p * double(A_test);