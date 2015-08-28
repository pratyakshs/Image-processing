function [ out_image ] = myPatchBasedFiltering( in_image, win_size, patch_size )
%Implements Patch Based Filtering
%   Detailed explanation goes here
    [rows, cols] = size(in_image);
    fin_image = zeros(rows, cols);
    for i = 1:rows
        for j = 1:cols
            fin_image(i,j) = patcher(in_image, [i,j], win_size, patch_size, 1, 1);
        end
    end
    out_image = fin_image;
end

