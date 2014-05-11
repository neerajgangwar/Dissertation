clear all
clc

trainDir = '../DownsamplingRandomfaces/TrainingFaces';
trainingImages = GetNames(trainDir);
len_train = length(trainingImages);
A_train = [];
H_train = [];

l = 6;
m = 5;

for i = 1 : 1 : len_train
    curr_train = trainingImages(i);
    train_img = imresize(imread([trainDir '/' curr_train{1}]), [l m]);
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


testDir = '../DownsamplingRandomfaces/TestFaces';
testImages = GetNames(testDir);
len_test = length(testImages);
A_test = [];
H_test = [];

for i = 1 : 1 : len_test
    curr_test = testImages(i);
    test_img = imresize(imread([testDir '/' curr_test{1}]), [l m]);
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