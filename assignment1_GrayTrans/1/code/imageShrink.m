function [out_im] = imageShrink(im, d)
%Shrinks an image
%   A rudimentary function to shrink an image
[row, col] = size(im);
out_im = zeros([uint8(row/d), uint8(col/d)]);
[nrow, ncol] = size(out_im);

for i = 1:nrow;
    for j = 1:ncol;
        out_im(i,j) = im(uint8(i*d), uint8(j*d));
    end
end

end

