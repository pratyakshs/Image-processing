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

%% Gaussian smoothing
smoothImage = myGaussianBlur(resImage, 9, 1);

%% Corner detection
[E1, E2] = myHarrisCornerDetector(smoothImage, 1);

toc;
