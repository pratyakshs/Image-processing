function [ out_patch ] = isotropize( in_patch, lef_lim, rig_lim, top_lim, bot_lim, gau_var )
%Function to make the patch isotropic
%  Done using a gaussian mask
    gau = fspecial('gaussian', size(in_patch), gau_var);
    iso_patch = zeros(size(in_patch));
    for i = lef_lim:rig_lim
        for j = top_lim:bot_lim
            iso_patch(i-lef_lim+1, j-top_lim+1) = gau(i, j)*in_patch(i-lef_lim+1, j-top_lim+1);
        end
    end
    out_patch = iso_patch;
end

