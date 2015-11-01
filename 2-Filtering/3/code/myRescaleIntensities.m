function [ imageRes ] = myRescaleIntensities(image, minI, maxI)
%Rescales the intensities of input image to range [minI, maxI]
minInp = min(image(:));
Rinp = max(image(:)) - minInp;
Rout = maxI - minI;
imageRes = minI + ((image - minInp) * (Rout / Rinp));
end
