%% MyMainScript

tic;
curDir = pwd;
imgFile = fullfile(curDir, '..', 'data', 'barbara256.png');

im = double(imread(imgFile));

im1 = im + randn(size(im))*20;
 
[im2] = myPCADenoising1(im1, 20);

figure, imshow(im2/max(imRes(:)));
figure, imshow(im/max(im(:)));

%TODO calculate mean squared error b/w im2 and im

toc;
