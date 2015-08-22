function [out_im] = myNoisify(in_im)
% Adds noise to image
%   Corrupts the image with independent and identically-distributed additive zero-mean Gaussian
%   noise with standard deviation set to 5% of the intensity range.
[rows, cols] = size(in_im);
range = double(max(in_im(:))) - double(min(in_im(:)));
stdev = (5*range)/100;
dis = randn(rows, cols);
noise = stdev*dis;
size(noise)
out_im = in_im + noise;
end

