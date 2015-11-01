function [ out_energy ] = myCalcEnergyFromRad( in_img, in_radius )
%Makes a mask and calculates energy
%   Detailed explanation goes here
    [rows, cols] = size(in_img);
    filter_mask = zeros(rows, cols);
    for i = 1:cols
        for j = 1:rows
            dist = sqrt((i-cols/2)^2 + (j-rows/2)^2);
            if (dist < in_radius)
               filter_mask(i,j) = in_img(i,j);
            end
        end
    end
    out_energy = sum(sum(abs(filter_mask).^2));
end