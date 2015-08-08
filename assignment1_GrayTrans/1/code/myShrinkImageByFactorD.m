function [out_im] = imageShrink(im, d)
%Shrinks an image
%   A rudimentary function to shrink an image
[row, col] = size(im);
%An image of size row/d, col/d
out_im = cast(zeros([floor(row/d), floor(col/d)]),'like', im);
[nrow, ncol] = size(out_im);
%Subsampling via for loop
for i = 1:nrow;
    for j = 1:ncol;
        out_im(i,j) = im((i-1)*d+1, (j-1)*d+1);
    end
end
end

