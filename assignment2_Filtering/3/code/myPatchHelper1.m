function [ out_patch ] = myPatchHelper1( in_patch, gau_var )
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here
gau = fspecial('gaussian', size(in_patch), gau_var);
out_patch = gau.*in_patch;
end

