%% MyMainScript

tic;


%% Setting global data
curDir = pwd;

%% Input files
boat_file = fullfile(curDir, '..', 'data', 'boat.mat');

%% Loading inputs
load(boat_file);
boatOrig = imageOrig;

%% Display Images
figure('Name', 'Boat Original'), 
imshow(boatOrig, gray), colorbar, truesize;
title('Boat Original');

toc;
