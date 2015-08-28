function [ out_patch ] = myPatchHelper1( in_patch, gau_var )
%Function to make the patch isotropic
%  Done using a gaussian mask
gau = fspecial('gaussian', size(in_patch), gau_var);
out_patch = gau.*in_patch;
end

