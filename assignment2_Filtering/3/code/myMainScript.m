%% MyMainScript

tic;

%% Setting global data
curDir = pwd;

%% Input files
inp_imgFil = fullfile(curDir, '..', 'data', 'barbara.mat');

%% Taking inputs
load(inp_imgFil);

%% Subsampling
imageOrig = imageOrig(1:2:end, 1:2:end);
filt = fspecial('gaussian', [5 5], 0.66);
imageOrig = imfilter(imageOrig, filt, 'same');

%% Noisifying
imshow(myNoisify(imageOrig), gray(100));
figure, imshow(imageOrig, gray(100));
im_out = myPatchBasedFiltering(imageOrig, 25, 9, 1);
figure, imshow(im_out, gray(100));
toc;