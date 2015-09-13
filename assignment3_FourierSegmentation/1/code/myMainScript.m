%% MyMainScript

tic;


%% Setting global data
curDir = pwd;

%% Input files
boat_file = fullfile(curDir, '..', 'data', 'boat.mat');

%% Loading inputs
load(boat_file);
boatOrig = imageOrig;

%% Noisifying
boatNois = myNoisify(boatOrig);

%% Contrast Stretch Params (If required)
minOrigI = min(boatOrig(:)); 
maxOrigI = max(boatOrig(:));

%% Applying Butterworth
%Apply fast fourier transform
boatFreq = fft2(boatNois);
%move the zero-frequency component to the center
boatFreq = fftshift(boatFreq);
%Apply Butterworth Filter
boatTranF = myButterworthFiltering(boatFreq, 50, 2);
%reverse apply
boatTranF = ifftshift(boatTranF);
boatTran = ifft2(boatTranF);

%% Display Images
figure('Name', 'Boat Original'), 
imshow(boatOrig, gray), colorbar, truesize;
title('Boat Original');

figure('Name', 'Boat Noised'), 
imshow(boatNois, gray), colorbar, truesize;
title('Boat Noised');

figure('Name', 'Boat Transformed'), 
imshow(boatTran, gray), colorbar, truesize;
title('Boat Transformed');

toc;
