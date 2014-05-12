clear all
clc

train_dir = '../DownsamplingRandomfaces/TrainingFaces';
training_images = GetNames(train_dir);
len_train = length(training_images);
A_train = [];
H_train = [];

l = 6;
m = 5;

for i = 1 : 1 : len_train
    curr_train = training_images(i);
    train_img = imresize(imread([train_dir '/' curr_train{1}]), [l m]);
    train_img = double(reshape(train_img, l*m, 1));
    index = str2num(curr_train{1}(6:7));
    if index > 14
        index = index - 1;
    end
    disp([num2str(index) ' - ' num2str(i)]);
    A_train = [A_train train_img];
    h = zeros(38, 1);
    h(index, 1) = 1;
    H_train = [H_train h];
end


test_dir = '../DownsamplingRandomfaces/TestFaces';
test_images = GetNames(test_dir);
len_test = length(test_images);
A_test = [];
H_test = [];

for i = 1 : 1 : len_test
    curr_test = test_images(i);
    test_img = imresize(imread([test_dir '/' curr_test{1}]), [l m]);
    test_img = double(reshape(test_img, l*m, 1));
    index = str2num(curr_test{1}(6:7));
    if index > 14
        index = index - 1;
    end
    disp([num2str(index) ' - ' num2str(i)]);
    A_test = [A_test test_img];
    h = zeros(38, 1);
    h(index, 1) = 1;
    H_test = [H_test h];
end