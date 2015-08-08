%% MyMainScript

tic;
%% Your code here
curDir = pwd;

%1a%
imgFil = fullfile(curDir, '..', 'data', 'circles_concentric.png');
im = imread(imgFil);
imshow(imageShrink(im, 5))

%1b%
toc;
