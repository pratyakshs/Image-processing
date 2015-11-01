%% MyMainScript

dataPath = uigetdir;
imageSize = 92 * 112;
noOfppl = 40;
data_set = 10;
k_list = [2, 10, 20, 50, 75, 100, 125, 150, 175];
test_image = double(imread(strcat(dataPath,filesep,'s1',filesep,'1.pgm')));
tic;
[ prinDir, ~, out_set, ~] = runReconstruction( dataPath, imageSize, noOfppl, data_set, test_image, k_list);
for i = 1:max(size(k_list))
    figure(3)
    subplot(3,3,i), subimage(reshape(out_set(:,i), [112, 92]), [0 255]);
    %Only by using a few number of eigenfaces, we get a very close
    %approximation to the actual face, more eigenfaces we use, the better
    %is the reconstruction
end
%The eigen-face images seem to contain more and more
   %high frequency information as the corresponding
   %eigen-values decrease
toc;