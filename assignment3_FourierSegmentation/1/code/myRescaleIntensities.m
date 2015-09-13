function [ imageRes ] = myRescaleIntensities(image, minI, maxI)
%Function for linear contrast stretching
%Rescales the intensities of input image to range [minI, maxI]
minInp = min(image(:));  % Minimum intensity in input
Rinp = max(image(:)) - minInp;  % Range of intensities in input
Rout = maxI - minI;  % Range of intensitied in output
imageRes = minI + ((image - minInp) * (Rout / Rinp));
end