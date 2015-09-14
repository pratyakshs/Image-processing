%% MyMainScript
unfilteredimage = imread('/data/baboonColor.png');
myfilter = fspecial('gaussian',[3 3], 0.5);
myfilteredimage = imfilter(unfilteredimage, myfilter, 'replicate');
myfilteredimage = myfilteredimage(1:2:end, 1:2:end, :);
tic;
%% Your code here

[Iout] = myMeanShiftSegmentation(myfilteredimage, 91, 32, 16, 20);
toc;
imshow(Iout/255, hsv(255));