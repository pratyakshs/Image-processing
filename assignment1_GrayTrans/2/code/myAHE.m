function [ Iout ] = myAHE( Im, wHalf ) 
% Function to perform Adaptive Histogram Equalization
   [row, col] = size(Im);
   Iout = zeros([row, col]);
   wb = waitbar(0, 'Performing Adaptive Histogram Equalization');
   for i = 1:row
       i_l = max(1, i - wHalf);
       i_u = min(row, i + wHalf);
       for j = 1:col
           j_l = max(1, j - wHalf);
           j_u = min(col, j + wHalf);
           block = Im(i_l:i_u, j_l:j_u);
           block = block(:);
           freq = (hist(block.',0:255))/((i_u - i_l + 1)*(j_u - j_l + 1));
           cdf = cumsum(freq);
           Iout(i, j) = cdf(Im(i,j) + 1) * 255;
       end
       waitbar(i/row);
   end
   close(wb);
end
