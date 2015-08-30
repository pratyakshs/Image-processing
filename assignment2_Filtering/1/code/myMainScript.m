%% MyMainScript
tic;

%% Setting global data
curDir = pwd;

%% Input files
superMoonCrop_file = fullfile(curDir, '..', 'data', 'superMoonCrop.mat');
lionCrop_file = fullfile(curDir, '..', 'data', 'lionCrop.mat');

%% Loading inputs
load(superMoonCrop_file);
smcOrig = imageOrig;

load(lionCrop_file);
lcOrig = imageOrig;

% Linear contrast stretch the original images
smcRes = myRescaleIntensities(smcOrig, 0, 1);
lcRes = myRescaleIntensities(lcOrig, 0, 1);

%% Display input images
% Display their linear contrast-stretched version
figure('Name', 'SuperMoonCrop Original (contrast-stretched)'), 
imshow(smcRes*250, gray(250)), colorbar, truesize;

figure('Name', 'LionCrop Original (contrast-stretched)'), 
imshow(lcRes*250, gray(250)), colorbar, truesize;

%% Unsharp masking
smcSharp = myUnsharpMasking(smcOrig, ??, ??, ??, ??);
lcSharp = myUnsharpMasking(lcOrig, ??, ??, ??, ??);

% Linear contrast stretch the sharpened images
smcSharpRes = myRescaleIntensities(smcSharp, 0, 1);
lcSharpRes = myRescaleIntensities(lcSharp, 0, 1);

%% Display the sharpened images
figure('Name', 'SuperMoonCrop Sharpened (contrast-stretched)'), 
imshow(smcSharpRes*250, gray(250)), colorbar, truesize;

figure('Name', 'LionCrop Sharpened (contrast-stretched)'), 
imshow(lcSharpRes*250, gray(250)), colorbar, truesize;

%% Save the images
out_mat_smc = fullfile(curDir, '..', 'data', 'superMoonCropSharpened.mat');
save(out_mat_smc, 'smcSharpRes');

out_mat_lc = fullfile(curDir, '..', 'data', 'lionCropSharpened.mat');
save(out_mat_lc, 'lcSharpRes');

out_png_smc = fullfile(curDir, '..', 'images', 'superMoonCropSharpened.png');
imwrite(smcSharpRes*250, gray(250), out_png_smc);

out_png_lc = fullfile(curDir, '..', 'images', 'lionCropSharpened.png');
imwrite(lcSharpRes*250, gray(250), out_png_lc);

toc;
