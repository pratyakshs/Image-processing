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
dopt = 83;
nval = 2;

%% Applying Butterworth
%Apply fast fourier transform
boatFreq = fft2(boatNois);
%move the zero-frequency component to the center
boatFreq = fftshift(boatFreq);
%Apply Butterworth Filter
[boatTranF, b_filter] = myButterworthFiltering(boatFreq, dopt, nval);
%reverse apply
boatTranFS = ifftshift(boatTranF);
boatTran = ifft2(boatTranFS);

%% RMSD Values
filtered_0 = myButterworthFiltering(boatFreq, dopt, nval);
rmsd_0 = abs(myRMSD(filtered_0, boatOrig))/1000;
disp(['RMSD for Dopt = Dopt is ' num2str(rmsd_0)]);

filtered_1 = myButterworthFiltering(boatFreq, dopt*0.95, nval);
rmsd_1 = abs(myRMSD(filtered_1, boatOrig))/1000;
disp(['RMSD for Dopt = Dopt*0.95 is ' num2str(rmsd_1)]);

filtered_2 = myButterworthFiltering(boatFreq, dopt*1.05, nval);
rmsd_2 = abs(myRMSD(filtered_2, boatOrig))/1000;
disp(['RMSD for Dopt = Dopt*1.05 is ' num2str(rmsd_2)]);

%As we see from the result, the optimal value of Dopt turns out to be 83.
%Here are the values for RMSD in each case:
%Optimal Dopt: 65.9422
%Dopt*0.95: 65.9422
%Dopt*1.05: 65.9423
%For Dopt, the image is considerably clear and filtered

%% Display Images
figure('Name', 'Boat Original'), 
imshow(boatOrig, []), colorbar, truesize;
title('Boat Original');

figure('Name', 'Boat Noised'), 
imshow(boatNois, []), colorbar, truesize;
title('Boat Noised');

figure('Name', 'Boat Transformed'), 
imshow(abs(boatTran), []), colorbar, truesize;
title('Boat Transformed');

figure('Name', 'Butterworth Filter'), 
imshow(b_filter, gray), colorbar, truesize;
title('Butterworth Filter');
%% Energy Filtering Analysis
%We already have boatFreq, the image in frequency domain from above
%Calculating the total energy
boatFreqTemp = fft2(boatOrig);
boatFreq = fftshift(boatFreqTemp);

energy100 = sum(sum(abs(boatFreq).^2));
%The radii calculated after tuning are as follows
%For ~88% energy, R = 1.5 | E = 90.5633
%For ~91% energy, R = 2.2 | E = 90.6931
%For ~94% energy, R = 4.5 | E = 94.1009
%For ~97% energy, R = 14.1 | E = 97.0273
%For ~99% energy, R = 59 | E = 99.0074

radii = [1.5 2.2 4.5 14.1 59];
energies = [88 91 94 97 99];
[rows, cols] = size(boatFreq);

for k=1:5
    in_radius = radii(k);
    filter_mask = zeros(rows, cols);
    for i = 1:cols
        for j = 1:rows
            dist = sqrt((i-cols/2)^2 + (j-rows/2)^2);
            if (dist < in_radius)
               filter_mask(i,j) = boatFreq(i,j);
            end
        end
    end
    boatInvFS = ifftshift(filter_mask);
    boatInv = ifft2(boatInvFS);
    boatInv = abs(boatInv);
    rmsd = myRMSD(boatOrig, boatInv);
    out_energy = sum(sum(abs(filter_mask).^2));
    disp(['for ' num2str(energies(k)) '%, radius = ' num2str(in_radius) ' calculated energy % = ' num2str(out_energy*100/energy100) ' and RMSD = ' num2str(rmsd)]);
end
toc;
