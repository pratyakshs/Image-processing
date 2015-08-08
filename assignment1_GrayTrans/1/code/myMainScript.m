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
imgFile2 = fullfile(curDir, '..', 'data', 'barbaraSmall.png');
outImgFile3 = fullfile(curDir, '..', 'images', 'barbaraSmall-bilinear.mat');
[img2, map2] = imread(imgFile2);
figure('Name', 'Original barbaraSmall.png'), imshow(img2, map2), colorbar, truesize;
enlarged1 = myBilinearInterpolation(img2, 3, 2);
figure('Name', 'Enlarged (bilinear) barbaraSmall.png'), imshow(enlarged1, map), colorbar, truesize;
save(outImgFile3, 'enlarged1');

%% 1(c)
outImgFile4 = fullfile(curDir, '..', 'images', 'barbaraSmall-nearest-neighbor.mat');
figure('Name', 'Original barbaraSmall.png'), imshow(img2, map2), colorbar, truesize;
enlarged2 = myNearestNeighborInterpolation(img2);
figure('Name', 'Enlarged (nearest-neighbor) barbaraSmall.png'), imshow(enlarged2, map), colorbar, truesize;
save(outImgFile4, 'enlarged2');

toc;