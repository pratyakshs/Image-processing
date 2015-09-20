%% MyMainScript
unfilteredimage = imread('../data/baboonColor.png');
myfilter = fspecial('gaussian',[3 3], 0.5);
myfilteredimage = imfilter(unfilteredimage, myfilter, 'replicate');
myfilteredimage = myfilteredimage(1:2:end, 1:2:end, :);
tic;
%% The code

[Iout, count] = myMeanShiftSegmentation(myfilteredimage, 91, 32, 16, 21);
%Parameters:
%Window Size: 91 
%Gaussian kernel bandwidth for the spatial feature: 32 
%Color gaussian: 16 
%Iterations: 21

figure('Name', 'Original'), 
imshow(unfilteredimage, hsv(255)), colorbar, truesize;
title('Original');

figure('Name', 'Filtered'), 
imshow(Iout/255, hsv(255)), colorbar, truesize;
title('Filtered');

toc;
