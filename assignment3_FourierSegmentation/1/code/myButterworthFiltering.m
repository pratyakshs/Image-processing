function [ out_img ] = myButterworthFiltering( in_img, d0, n )
%Does Butterworth Filtering
%   Detailed explanation goes here
    [rows, cols] = size(in_img);
    h_matrix = zeros(rows, cols, 'like', in_img);
    for i = 1:cols
        for j = 1:rows
            dist = sqrt((i-floor(cols/2)+1)^2 + (j-floor(rows/2)+1)^2);
            h_matrix(i,j) = 1/(1 + (dist/d0)^(2*n));
        end
    end
    out_img = in_img.*h_matrix;
end

