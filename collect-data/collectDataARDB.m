clear all
clc
dir = 'ImagesCropped';

subdirList = GetNames(dir);
numClasses = length(subdirList);

l = 6;
m = 5;

% data matrices
A_train = [];
A_test = [];
H_train = [];
H_test = [];

for i = 1 : 1 : numClasses
    fprintf('%dth iteration\n', i);
    subdir = subdirList(i);
    subdir = [dir '/' subdir{1}];
    fileList = GetNames(subdir);

    for j = 1 : 1 : length(fileList)
        file = fileList(j);
        file = [subdir '/' file{1}];
        
        a = imread(file);
        a = imresize(a, [l m]);
        a = reshape(a, l*m, 1);
        
        if mod(j, 2) == 1
            A_train = [A_train a];
            h = zeros(numClasses, 1);
            h(i, :) = 1;
            H_train = [H_train h];
        else
            A_test = [A_test a];
            h = zeros(numClasses, 1);
            h(i, :) = 1;
            H_test = [H_test h];
        end
        
    end
end


% dir = '/media/neeraj/Media/Study/5-1/Dissertation/AR Face Database/Images/m/';
% 
% subdirList = GetNames(dir);
% numClasses = length(subdirList);
% 
% % height and width of .raw files
% l = 768;
% w = 576;
% 
% % data matrices
% A_train = [];
% A_test = [];
% H_train = [];
% H_test = [];
% 
% for i = 1 : 1 : numClasses
%     fprintf('%dth iteration\n', i);
%     subdir1 = subdirList(i);
%     subdir = [dir subdir1{1}];
%     fileList = GetNames(subdir);
% 
%     for j = 1 : 1 : length(fileList)
%         file1 = fileList(j);
%         file = [subdir '/' file1{1}];
%         
%         fin = fopen(file);
%         a = fread(fin, l*w, 'uint8=>uint8');
%         a = reshape(a, l, w);
%         a = a';
%         a = imresize(a, [17 13]);
%         a = reshape(a, 17*13, 1);
%         
%         if mod(j, 2) == 1
%             A_train = [A_train a];
%             h = zeros(numClasses, 1);
%             h(i, :) = 1;
%             H_train = [H_train h];
%         else
%             A_test = [A_test a];
%             h = zeros(numClasses, 1);
%             h(i, :) = 1;
%             H_test = [H_test h];
%         end
%         
%     end
% end