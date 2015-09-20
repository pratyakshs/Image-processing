%% MyMainScript
tic;

%% Setting global data
curDir = pwd;

%% Input file
inp_imgFil = fullfile(curDir, '..', 'data', 'boat.mat');

%% Loading input
load(inp_imgFil);

%% Shift and rescale intensities to range [0, 1]
resImage = myRescaleIntensities(imageOrig);

%% Corner detection
[E1, E2] = myHarrisCornerDetector(resImage, 1, 2, 0.01);
% optimal values are:
% sigma1 = 1
% sigma2 = 2
% k = 0.01

toc;
