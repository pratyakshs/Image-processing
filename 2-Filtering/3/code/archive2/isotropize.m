function [ out_patch ] = isotropize( in_patch, lef_lim, rig_lim, top_lim, bot_lim, gau_var, patch_size, pix )
%Function to make the patch isotropic
%  Done using a gaussian mask
    gau = fspecial('gaussian', [patch_size patch_size], gau_var);
    hw = (patch_size - 1)/2;
    gau = gau(hw - (pix(1) - lef_lim):hw - (pix(1) - rig_lim), (hw - (pix(2) - top_lim)):hw - (pix(2) - bot_lim));  
    %iso_patch = zeros(size(in_patch));
    iso_patch = gau.*in_patch;
    %for i = lef_lim:rig_lim
    %    for j = top_lim:bot_lim
    %        iso_patch(i-lef_lim+1, j-top_lim+1) = gau(i - lef_lim + 1, j - top_lim + 1)*in_patch(i-lef_lim+1, j-top_lim+1);
    %    end
    %end
    out_patch = iso_patch;
end

