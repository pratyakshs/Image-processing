function [ Iout ] = myCLAHE2( Im, wHalf, eps ) 
% Function to perform Contrast Limited Adaptive Histogram Equalization
   [row, col] = size(Im);
   Iout = zeros([row, col]);
   
   for i = 1:row
       i_l = max(1, i - wHalf);
       i_u = min(row, i + wHalf);
       for j = 1:col
           j_l = max(1, j - wHalf);
           j_u = min(col, j + wHalf);
           block = Im(i_l:i_u, j_l:j_u);
           block = block(:);
           freq = (hist(block.',0:255))/((i_u - i_l + 1)*(j_u - j_l + 1));
           sum = 0;
           for k = 0:255
               if freq(k + 1) > eps
                  sum = sum + freq(k + 1) - eps;
                  freq(k + 1) = eps;
               end
           end
           freq = freq + sum * ones(size(freq)) / 256;
           cdf = cumsum(freq);
           Iout(i, j) = cdf(Im(i,j) + 1) * 255;
       end
   end
   display(size(freq));
end
