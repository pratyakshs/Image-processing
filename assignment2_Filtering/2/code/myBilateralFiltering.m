function Bf_Img = myBilateralFiltering(Img,sigma_s,sigma_i)
 % Bilateral filtering
sz = size(Img);
Bf_Img = zeros(sz);

% h = waitbar(0,'Applying bilateral filter...');
% Mask for spatial Gaussian
[X, Y] = meshgrid(-sz(1)/2:sz(1)/2,-sz(2)/2:sz(2)/2);
Dist = X.^2 + Y.^2;
G_spatial = exp(-Dist/(2*sigma_s^2));

% Apply bilateral filter.
for i = 1:sz(1)
   for j = 1:sz(2)
       w = min([i-1, j-1, sz(1)-i, sz(2)-j, 12]);  % Find the window size
       window = Img(i-w:i+w, j-w:j+w);  % Extract the window from the original image
       diff_i = window - Img(i, j);   % Difference of intensity from Img(i, j)
       mask_i = exp(-(diff_i.^2) / (2 * sigma_i^2));  % Gaussian intensity mask
       mask_s = G_spatial(1+sz(1)/2-w:1+sz(1)/2+w, 1+sz(2)/2-w:1+sz(2)/2+w);  % Extract the spatial mask
       den = mask_s.*mask_i;  % Compute the denominator
       num = den.*window;  % Compute the numerator
       Bf_Img(i, j) = sum(num(:))/sum(den(:));  % Value at output pixel
   end
  % waitbar(i/sz(1));
end
% close(h);
