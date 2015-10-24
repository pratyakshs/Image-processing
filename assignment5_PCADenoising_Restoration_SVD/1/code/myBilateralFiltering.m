function Bf_Img = myBilateralFiltering(Img,sigma_s,sigma_i)
 % Bilateral filtering
sz = size(Img);
Bf_Img = zeros(sz);

%h = waitbar(0,'Applying bilateral filter...');
% Mask for spatial Gaussian
[X, Y] = meshgrid(-sz(1)/2:sz(1)/2,-sz(2)/2:sz(2)/2);
Dist = X.^2 + Y.^2;
G_spatial = exp(-Dist/(2*sigma_s^2));  % Spatial gaussian mask

% Apply bilateral filter.
for i = 1:sz(1)
   for j = 1:sz(2)
       % Find the window size (max window size = 15)
       w_up = min([7, i-1]);
       w_down = min([7, sz(1)-i]);
       w_left = min([7, j-1]);
       w_right = min([7, sz(2)-j]);
       
       % Extract the window from the original image
       window = Img(i-w_up:i+w_down, j-w_left:j+w_right);
       
       diff_i = window - Img(i, j);   % Difference of intensity from Img(i, j)
       mask_i = exp(-(diff_i.^2) / (2 * sigma_i^2));  % Gaussian intensity mask
       
       % Extract the spatial mask
       mask_s = G_spatial(1+sz(1)/2-w_up:1+sz(1)/2+w_down, 1+sz(2)/2-w_left:1+sz(2)/2+w_right);
       
       den = mask_s.*mask_i;  % Compute the denominator
       num = den.*window;  % Compute the numerator
       Bf_Img(i, j) = sum(num(:))/sum(den(:));  % Value at output pixel
   end
 % waitbar(i/sz(1));  % Update the waitbar
end
%close(h);  % Close the waitbar
