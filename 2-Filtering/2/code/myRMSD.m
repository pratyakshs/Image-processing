function [ rmsd ] = myRMSD(A, B)
%Function to calculate root mean squared difference (RMSD) 
% of the elements of two matrices A and B.
A = A - B;
A = A.*A;
sz = size(A);
rmsd = sqrt(sum(A(:))/(sz(1)*sz(2)));
end
