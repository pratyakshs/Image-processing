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
imshow(myNoisify(imageOrig), colormap(gray));
figure, imshow(imageOrig, colormap(gray));
figure, imshow(myPatchBasedFiltering(imageOrig, 25, 9), colormap(gray));
toc;
