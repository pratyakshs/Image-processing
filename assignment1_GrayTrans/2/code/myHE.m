function [ out_img ] = myHE( in_img )
% Function to perform Histogram Equalization
range = 255;

img_vec = in_img(:);
img_vec = double(img_vec);
freq_dist = hist(img_vec, 0:range);
pmf = freq_dist/numel(in_img);
cdf = cumsum(pmf);

heq = cdf(in_img+1);
out_img = uint8(heq*255);

end

