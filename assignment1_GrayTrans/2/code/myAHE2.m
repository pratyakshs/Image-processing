function [ Iout ] = myAHE2( Im, wHalf ) 
% Function to perform Adaptive Histogram Equalization
   len = wHalf * 2 + 1;
   Iout = nlfilter(Im, [len, len], @(X) ahe_gen(X));
end
