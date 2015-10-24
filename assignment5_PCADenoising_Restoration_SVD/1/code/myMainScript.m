%% MyMainScript

tic;

%% Setup
curDir = pwd;
imgFile = fullfile(curDir, '..', 'data', 'barbara256.png');
imgFile_part = fullfile(curDir, '..', 'data', 'barbara256-part.png');

im = double(imread(imgFile));
im_part = double(imread(imgFile_part));

im1 = im + randn(size(im))*20;
im1_part =  im_part + randn(size(im_part))*20;

figure('Name', 'Original barbara256.png'), imshow(im/max(im(:))), colorbar, truesize;

figure('Name', 'Noisy barbara256.png'), imshow(im1/max(im1(:))), colorbar, truesize;

%% Part 1(a)
im2 = myPCADenoising1(im1, 20);

figure('Name', 'Output of myPCADenoising1'), imshow(im2/max(im2(:))), colorbar, truesize;

% RMSD for this case
rmsd_a = rms(rms(im2 - im))

%% Part 1(b)
im3 = myPCADenoising2(im1, 20, 200);

figure('Name', 'Output of myPCADenoising2'), imshow(im3/max(im3(:))), colorbar, truesize;

% RMSD for this case
rmsd_b = rms(rms(im3 - im))

toc;
