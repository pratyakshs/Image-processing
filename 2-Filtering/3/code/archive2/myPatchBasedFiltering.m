function [ out_image ] = myPatchBasedFiltering( in_image, win_size, patch_size )
%Implements Patch Based Filtering
%   Detailed explanation goes here
    [rows, cols] = size(in_image);
    fin_image = zeros(rows, cols);
    waitbar(0, 'Applying patch-based filtering.');
    wb = waitbar(0);
    for i = 1:rows
        for j = 1:cols
            fin_image(i,j) = patcher(in_image, [i,j], win_size, patch_size, 1, 1);
        end
        waitbar(i/rows);
    end
    waitbar(1);
    close(wb);
    out_image = fin_image;
end

