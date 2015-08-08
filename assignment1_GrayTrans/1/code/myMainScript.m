%% MyMainScript
tic;
%% Your code here
curDir = pwd;

%% 1(a)
imgFile1 = fullfile(curDir, '..', 'data', 'circles_concentric.png');
outImgFile1 = fullfile(curDir, '..', 'images', 'circles_concentric_shrinked-d-2.mat');
outImgFile2 = fullfile(curDir, '..', 'images', 'circles_concentric_shrinked-d-3.mat');
[img, map] = imread(imgFile1);
iptsetpref('ImshowAxesVisible','on');
figure('Name', 'Original circles_concentric.png'), imshow(img, map), colorbar, truesize;
shrinked2 = myShrinkImageByFactorD(img, 2);
figure('Name', 'Shrinked d=2 circles_concentric.png'), imshow(shrinked2, map), colorbar, truesize;
save(outImgFile1, 'shrinked2');
shrinked3 = myShrinkImageByFactorD(img, 3);
figure('Name', 'Shrinked d=3 circles_concentric.png'), imshow(shrinked3, map), colorbar, truesize;
save(outImgFile2, 'shrinked3');


%% 1(b)

%% 1(c)

toc;