clear all
clc

A_train = [];
H_train = [];

dim = 54;

fprintf('Loading data...\n');
load data/ARdb.mat
load data/eigenfaces_ARdb.mat

fprintf('Computing D and A_test...\n');
s = S(:, (size(S, 2) - (dim - 1)) : size(S, 2));
p = inv(s'*s)*s';
D = p * double(A_train);
A_test = p * double(A_test);

% for i = 1 : 1 : len
%     temp = subdir_names(i);
%     subdir = [dir '/' temp{1}];
%     files = GetNames(subdir);
%     len1 = length(files);
%     
%     
%     for j = 1 : 1 : len1
%         temp = files(j);
%         img = imread([subdir '/' temp{1}]);
%         [l, m] = size(img);
%         if l ~= 192 || m ~= 168
%             img = imresize(img, [192 168]);
%             l = 192;
%             m = 168;
%         end
%         img = double(reshape(img, l*m, 1));
%         A_train(:, k) = img;
%         avg = avg + img;
%         k = k + 1;
%         h = zeros(len, 1);
%         h(i, 1) = 1;
%         H_train = [H_train h];
%     end
% end
% 
% avg = avg/(k-1);
% 
% for i = 1 : 1 : (k-1)
%     A_train(:, i) = A_train(:, i) - avg;
% end
% 
% covMat = A_train'*A_train;
% [S1 D] = eig(covMat);
% S2 = A_train*S1;
% 
% S = S2(:, size(S2, 2) - (s*t - 1) : size(S2, 2));
% 
% B = [];
% t = inv(S'*S)*S';
% for i = 1 : 1 : len
%     temp = subdir_names(i);
%     subdir = [dir '/' temp{1}];
%     files = GetNames(subdir);
%     len1 = length(files);
%     
%     
%     for j = 1 : 1 : len1
%         temp = files(j);
%         img = imread([subdir '/' temp{1}]);
%         [l, m] = size(img);
%         if l ~= 192 || m ~= 168
%             img = imresize(img, [192 168]);
%             l = 192;
%             m = 168;
%         end
%         img = double(reshape(img, l*m, 1));
%         w = t*img;
%         B = [B w];
%     end
% end
% 
% B = normalize(B);
% save(datafile, 'B', 'S', 'H_train');