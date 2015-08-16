function [ Iout ] = myCLAHE( Im, wHalf, epsil ) 
% Function to perform Contrast Limited Adaptive Histogram Equalization
   len = wHalf * 2 + 1;
   Iout = nlfilter(Im, [len, len], @(X) clahe_gen(X, epsil));
end
