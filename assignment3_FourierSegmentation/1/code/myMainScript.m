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

%% Other Params
dopt = 50;
nval = 2;

%% Applying Butterworth
%Apply fast fourier transform
boatFreq = fft2(boatNois);
%move the zero-frequency component to the center
boatFreq = fftshift(boatFreq);
%Apply Butterworth Filter
boatTranF = myButterworthFiltering(boatFreq, dopt, nval);
%reverse apply
boatTranF = ifftshift(boatTranF);
boatTran = ifft2(boatTranF);

%% RMSD Values
filtered_0 = myButterworthFiltering(boatFreq, dopt, nval);
rmsd_0 = myRMSD(filtered_0, boatOrig)

filtered_1 = myButterworthFiltering(boatFreq, dopt*0.95, nval);
rmsd_1 = myRMSD(filtered_1, boatOrig)

filtered_2 = myButterworthFiltering(boatFreq, dopt*1.05, nval);
rmsd_2 = myRMSD(filtered_2, boatOrig)

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
