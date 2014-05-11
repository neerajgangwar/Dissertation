clear all
clc

dir = 'Images';
subdirList = GetNames(dir);
outdir = 'ImagesCropped';

for i = 8 : 1 : length(subdirList)
    subdir = subdirList(i);
    subdirPath = [dir '/' subdir{1}];
    
    fileList = GetNames(subdirPath);
    
    outsubdir = [outdir '/' subdir{1}];
    mkdir(outsubdir);
    
    for j = 1 : 1 : length(fileList)
        % fprintf('%dth Subject, %dth Image\n', i, j);
        file = fileList(j);
        filePath = [subdirPath '/' file{1}];
        
        a = imread(filePath);
        FDetect = vision.CascadeObjectDetector;
        BB = step(FDetect, a);
        try
            BB(1) = BB(1) + 25;
            BB(3:4) = [290 330];
            b = imcrop(a, BB);
            outfile = [outsubdir '/' file{1}];
            imwrite(b, outfile, 'JPEG');
        catch err
            fprintf([filePath '\n']);
        end
    end
end