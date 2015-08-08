%% MyMainScript
tic;
%% Your code here
curDir = pwd;

%% 1(a)
imgFil = fullfile(curDir, '..', 'data', 'circles_concentric.png');
out_imgfil = fullfile(curDir, '..', 'images', 'circles_concentric_out.png');
im = imread(imgFil);
imwrite(imageShrink(im, 2), out_imgfil);

%% 1(b)

toc;