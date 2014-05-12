clear all
clc
dir = '/media/neeraj/Media/Study/5-1/Dissertation/AR Face Database/Cropped/Images';

file_list = get_names(dir);
num_classes = 100;

% l = 27;
% m = 20;

train_indices = [1 4 7 9 12 15 17 19 22 24];

% data matrices
A_train = [];
A_test = [];
H_train = [];
H_test = [];


for i = 1 : 1 : length(file_list)
    
    file = file_list(i);
    file = file{1};
    file_path = [dir '/' file];
    
    a = imread(file_path);
    a = rgb2gray(a);
    % a = imresize(a, [l m]);
    [l m] = size(a);
    a = reshape(a, l*m, 1);
    
    class = str2num(file(3:5));
    j = str2num(file(7:8));
    
    if i > 1300
        class = 50 + class;
    end
    
    fprintf('%dth image, class = %d\n', i, class);
    
    h = zeros(num_classes, 1);
    
    isTrain = find(train_indices == j);
    
    if ~isempty(isTrain)
        A_train = [A_train a];
        h(class, :) = 1;
        H_train = [H_train h];
    else
        A_test = [A_test a];
        h(class, :) = 1;
        H_test = [H_test h];
    end 
end