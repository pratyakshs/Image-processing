%% MyMainScript

tic;

%% Setting global data
curDir = pwd;

%% Input files
inp_imgFil = fullfile(curDir, '..', 'data', 'barbara.mat');

%% Taking inputs
load(inp_imgFil);

%% Noisifying
imshow(myNoisify(imageOrig), colormap(gray));
figure, imshow(imageOrig, colormap(gray));
figure, imshow(myPatchBasedFiltering(imageOrig, 25, 9), colormap(gray));
toc;
