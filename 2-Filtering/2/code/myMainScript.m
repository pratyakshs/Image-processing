%% MyMainScript
tic;

%% Setting global data
curDir = pwd;

%% Input files
inp_imgFil = fullfile(curDir, '..', 'data', 'barbara.mat');

%% Loading inputs
load(inp_imgFil);
minOrigI = min(imageOrig(:));  % 0 for barbara
maxOrigI = max(imageOrig(:));  % 100 for barbara

figure('Name', 'Original Barbara'), imshow(imageOrig, [minOrigI maxOrigI]), 
colorbar, truesize;  % Display the original image
title('Original Barbara');

%% Noisifying
imageNoisy = myNoisify(imageOrig);

% Linear contrast stretching to intensity range [0, 100]. If not done,
% intensities could be < 0 or > 100. 
imageNoisyRes = myRescaleIntensities(imageNoisy, minOrigI, maxOrigI);

figure('Name', 'Noisy Barbara'), imshow(imageNoisyRes, [minOrigI maxOrigI]), 
colorbar, truesize;  % display the noisy image
title('Noisy Barbara');

%% Bilateral filtering

imageFiltered = myBilateralFiltering(imageNoisy, 1.4, 10.1);

% Optimal parameters are: Sigma_space = 1.4, Sigma_intensity = 10.1
% Window size = 15 was used.

% Apply linear contrast stretching before displaying
imageFilteredRes = myRescaleIntensities(imageFiltered, minOrigI, maxOrigI);

figure('Name', 'Filtered Barbara'), imshow(imageFilteredRes, [minOrigI maxOrigI]), 
colorbar, truesize;  % display the filtered image
title('Filtered Barbara');

%% Mask for spatial Gaussian as an image
sz = size(imageOrig);
[X, Y] = meshgrid(-sz(1)/2:sz(1)/2,-sz(2)/2:sz(2)/2);
Dist = double(X.^2 + Y.^2);
sigma_s = 10;  % Taken larger for effect
G_spatial = exp(-Dist/(2*sigma_s^2));

% Do contrast stretching
G_spatial = myRescaleIntensities(G_spatial, minOrigI, maxOrigI);

figure('Name', 'Spatial Gaussian Mask'), imshow(G_spatial, [minOrigI maxOrigI]), 
colorbar, truesize;  % display the noisy image
title('Spatial Gaussian Mask');

%% Optimal parameter values
sigmaSpaceOpt = 1.4
sigmaIntensityOpt = 10.1 
imageFilteredOpt = myBilateralFiltering(imageNoisy, sigmaSpaceOpt, sigmaIntensityOpt);
RMSD_opt = myRMSD(imageFilteredOpt, imageOrig)

imageFiltered_1 = myBilateralFiltering(imageNoisy, 0.9 * sigmaSpaceOpt, sigmaIntensityOpt);
RMSD_1 = myRMSD(imageFiltered_1, imageOrig)

imageFiltered_2 = myBilateralFiltering(imageNoisy, 1.1 * sigmaSpaceOpt, sigmaIntensityOpt);
RMSD_2 = myRMSD(imageFiltered_2, imageOrig)

imageFiltered_3 = myBilateralFiltering(imageNoisy, sigmaSpaceOpt, 0.9 * sigmaIntensityOpt);
RMSD_3 = myRMSD(imageFiltered_3, imageOrig)

imageFiltered_4 = myBilateralFiltering(imageNoisy, sigmaSpaceOpt, 1.1 * sigmaIntensityOpt);
RMSD_4 = myRMSD(imageFiltered_4, imageOrig)

%% Save output file
out_mat = fullfile(curDir, '..', 'data', 'barbaraFiltered.mat');
save(out_mat, 'imageFilteredOpt');

out_png_noisy = fullfile(curDir, '..', 'images', 'barbaraNoisy.png');
imwrite(imageNoisyRes, gray(100), out_png_noisy);

out_png = fullfile(curDir, '..', 'images', 'barbaraFiltered.png');
imwrite(imageFilteredOpt, gray(100), out_png);

toc;
