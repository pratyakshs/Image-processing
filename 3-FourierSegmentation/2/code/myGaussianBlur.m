function [res] = myGaussianBlur(image, sigma, w)
% Performs gaussian blur on given image
%   w = window size, sigma = parameter of gaussian

h = fspecial('gaussian', w, sigma);
res = conv2(image, h, 'same');
end
