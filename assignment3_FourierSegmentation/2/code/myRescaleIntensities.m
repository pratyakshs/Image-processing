function [res] = myRescaleIntensities(image)
% Rescale intensities to range [0, 1]

minI = double(min(image(:)));
maxI = double(max(image(:)));
res = (image - minI) / (maxI - minI);
end
