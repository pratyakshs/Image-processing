%% MyMainScript

tic;
%% Your code here
curDir = pwd;

%% 2(a)
imgFil = fullfile(curDir, '..', 'data', 'barbara.png');
out_imgfil = fullfile(curDir, '..', 'images', '2a', 'barbara_out.png');
im = imread(imgFil);
imwrite(myLinearContrastStretching(im), out_imgfil);

toc;
