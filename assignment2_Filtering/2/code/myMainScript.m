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

%% Noisifying
imageNoisy = myNoisify(imageOrig);

% Linear contrast stretching to intensity range [0, 100]. If not done,
% intensities could be < 0 or > 100. 
imageNoisyRes = myRescaleIntensities(imageNoisy, minOrigI, maxOrigI);

figure('Name', 'Noisy Barbara'), imshow(imageNoisyRes, [minOrigI maxOrigI]), 
colorbar, truesize;  % display the noisy image

%% Bilateral filtering

imageFiltered = myBilateralFiltering(imageNoisyRes, 1.1, 6.8);

% Optimal parameters are: Sigma_space = 1.1, Sigma_intensity = 6.8
% Window size = 25 was used.

figure('Name', 'Filtered Barbara'), imshow(imageFiltered, [minOrigI maxOrigI]), 
colorbar, truesize;  % display the filtered image

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


%% Optimal parameter values
sigmaSpaceOpt = 1.1
sigmaIntensityOpt = 6.8 
imageFilteredOpt = myBilateralFiltering(imageNoisyRes, sigmaSpaceOpt, sigmaIntensityOpt);
RMSD_opt = myRMSD(imageFilteredOpt, imageOrig)

imageFiltered_1 = myBilateralFiltering(imageNoisyRes, 0.9 * sigmaSpaceOpt, sigmaIntensityOpt);
RMSD_1 = myRMSD(imageFiltered_1, imageOrig)

imageFiltered_2 = myBilateralFiltering(imageNoisyRes, 1.1 * sigmaSpaceOpt, sigmaIntensityOpt);
RMSD_2 = myRMSD(imageFiltered_2, imageOrig)

imageFiltered_3 = myBilateralFiltering(imageNoisyRes, sigmaSpaceOpt, 0.9 * sigmaIntensityOpt);
RMSD_3 = myRMSD(imageFiltered_3, imageOrig)

imageFiltered_4 = myBilateralFiltering(imageNoisyRes, sigmaSpaceOpt, 1.1 * sigmaIntensityOpt);
RMSD_4 = myRMSD(imageFiltered_4, imageOrig)

%% Save output file
out_mat = fullfile(curDir, '..', 'data', 'barbaraFiltered.mat');
save(out_mat, 'imageFilteredOpt');
out_png = fullfile(curDir, '..', 'images', 'barbaraFiltered.png');
imwrite(imageFilteredOpt, gray(100), out_png);

toc;
