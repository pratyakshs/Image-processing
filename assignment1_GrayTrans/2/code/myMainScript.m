%% MyMainScript
tic;

%% Setting global data
curDir = pwd;

%% Input files
inp_imgFil_1 = fullfile(curDir, '..', 'data', 'barbara.png');
inp_imgFil_2 = fullfile(curDir, '..', 'data', 'TEM.png');
inp_imgFil_3 = fullfile(curDir, '..', 'data', 'canyon.png');


%% Output files
out_imgFil_1_a = fullfile(curDir, '..', 'images', '2a', 'barbara_out.mat');
out_imgFil_2_a = fullfile(curDir, '..', 'images', '2a', 'TEM_out.mat');
out_imgFil_3_a = fullfile(curDir, '..', 'images', '2a', 'canyon_out.mat');

out_imgFil_1_b = fullfile(curDir, '..', 'images', '2b', 'barbara_out.mat');
out_imgFil_2_b = fullfile(curDir, '..', 'images', '2b', 'TEM_out.mat');
out_imgFil_3_b = fullfile(curDir, '..', 'images', '2b', 'canyon_out.mat');

out_imgFil_1_c = fullfile(curDir, '..', 'images', '2c', 'barbara_out.mat');
out_imgFil_2_c = fullfile(curDir, '..', 'images', '2c', 'TEM_out.mat');
out_imgFil_3_c = fullfile(curDir, '..', 'images', '2c', 'canyon_out.mat');

out_imgFil_1_d = fullfile(curDir, '..', 'images', '2d', 'barbara_out.mat');
out_imgFil_2_d = fullfile(curDir, '..', 'images', '2d', 'TEM_out.mat');
out_imgFil_3_d = fullfile(curDir, '..', 'images', '2d', 'canyon_out.mat');

%% Actual Input
[inp_im_1, map1] = imread(inp_imgFil_1);
figure('Name', 'Original barbara.png'), imshow(inp_im_1, map1), colorbar, truesize;

[inp_im_2, map2] = imread(inp_imgFil_2);
figure('Name', 'Original TEM.png'), imshow(inp_im_2, map2), colorbar, truesize;

[inp_im_3, map3] = imread(inp_imgFil_3);
figure('Name', 'Original canyon.png'), imshow(inp_im_3, map3), colorbar, truesize;

%image 3 has separate r, g and b channels (others being greyscale).
inp_im_3_r = inp_im_3(:,:,1);
inp_im_3_g = inp_im_3(:,:,2);
inp_im_3_b = inp_im_3(:,:,3);

%% 2(a): LinearContrastStretching
out_im_1_a = myLinearContrastStretching(inp_im_1);
figure('Name', 'Contrast-enhanced (Linear contrast stretching) barbara.png'), imshow(out_im_1_a, map1), colorbar, truesize;
%As we see, the boundaries (especially) are now more enhanced and we can
%see the facial features better

out_im_2_a = myLinearContrastStretching(inp_im_2);
figure('Name', 'Contrast-enhanced (Linear contrast stretching) TEM.png'), imshow(out_im_2_a, map2), colorbar, truesize;
%Contrast enhancement is even more pronounced in this case, the image is
%significantly darker at the boundaries as compared to the original

out_im_3_r_a = myLinearContrastStretching(inp_im_3_r);
out_im_3_g_a = myLinearContrastStretching(inp_im_3_g);
out_im_3_b_a = myLinearContrastStretching(inp_im_3_b);
out_im_3_a = cat(3, out_im_3_r_a, out_im_3_g_a, out_im_3_b_a);
figure('Name', 'Contrast-enhanced (Linear contrast stretching) canyon.png'), imshow(out_im_3_a, map3), colorbar, truesize;
%Here, the effects can be seen near the ground, where more rocks are
%visible. Since this is a colored image, r, g and b channels have been
%separately enhanced

%% 2(b): Histogram Equalization
out_im_1_b = myHE(inp_im_1);
figure('Name', 'Contrast-enhanced (Histogram Equalization) barbara.png'), imshow(out_im_1_b, map1), colorbar, truesize;

out_im_2_b = myHE(inp_im_2);
figure('Name', 'Contrast-enhanced (Histogram Equalization) TEM.png'), imshow(out_im_2_b, map2), colorbar, truesize;

out_im_3_r_b = myHE(inp_im_3_r);
out_im_3_g_b = myHE(inp_im_3_g);
out_im_3_b_b = myHE(inp_im_3_b);
out_im_3_b = cat(3, out_im_3_r_b, out_im_3_g_b, out_im_3_b_b);
figure('Name', 'Contrast-enhanced (Histogram Equalization) canyon.png'), imshow(out_im_3_b, map3), colorbar, truesize;
%As apparent from the three images, Histogram Equalisation performs
%significantly better than Linear Contrast Stretching. In image 3, for
%example, the boulder on the bottom right has more features as visible now

%% 2(c): Adaptive Histogram Equalization
out_im_1_c_20 = myAHE(inp_im_1, 20);
figure('Name', 'Contrast-enhanced (AHE w=41) barbara.png'), imshow(out_im_1_c_20, map1), colorbar, truesize;
out_im_1_c_5 = myAHE(inp_im_1, 5);
figure('Name', 'Contrast-enhanced (AHE w=11) barbara.png'), imshow(out_im_1_c_5, map1), colorbar, truesize;
out_im_1_c_100 = myAHE(inp_im_2, 100);
figure('Name', 'Contrast-enhanced (AHE w=100) TEM.png'), imshow(out_im_1_c_100, map2), colorbar, truesize;

out_im_2_c_20 = myAHE(inp_im_2, 20);
figure('Name', 'Contrast-enhanced (AHE w=41) TEM.png'), imshow(out_im_2_c_20, map2), colorbar, truesize;
out_im_2_c_5 = myAHE(inp_im_2, 5);
figure('Name', 'Contrast-enhanced (AHE w=11) TEM.png'), imshow(out_im_2_c_5, map2), colorbar, truesize;
out_im_2_c_100 = myAHE(inp_im_2, 100);
figure('Name', 'Contrast-enhanced (AHE w=100) TEM.png'), imshow(out_im_2_c_100, map2), colorbar, truesize;

out_im_3_r_c = myAHE(inp_im_3_r, 20);
out_im_3_g_c = myAHE(inp_im_3_g, 20);
out_im_3_b_c = myAHE(inp_im_3_b, 20);
out_im_3_c = cat(3, out_im_3_r_c, out_im_3_g_c, out_im_3_b_c);
figure('Name', 'Contrast-enhanced (AHE w=41) canyon.png'), imshow(out_im_3_c, map3), colorbar, truesize;

% As we can see in the output images, AHE with small window size amplifies
% effect of noise in the image, but increases the contrast

%% 2(d): Contrast-Limited Adaptive Histogram Equalization
out_im_1_d = myCLAHE(inp_im_1, 20, 0.007);
figure('Name', 'Contrast-enhanced (CLAHE threshold=0.007) barbara.png'), imshow(out_im_1_d, map1), colorbar, truesize;
out_im_1_d = myCLAHE(inp_im_1, 20, 0.0035);
figure('Name', 'Contrast-enhanced (CLAHE threshold=0.005) barbara.png'), imshow(out_im_1_d, map1), colorbar, truesize;

out_im_2_d = myCLAHE(inp_im_2, 20, 0.007);
figure('Name', 'Contrast-enhanced (CLAHE threshold=0.007) TEM.png'), imshow(out_im_2_d, map2), colorbar, truesize;
out_im_2_d = myCLAHE(inp_im_2, 20, 0.0035);
figure('Name', 'Contrast-enhanced (CLAHE threshold=0.0035) TEM.png'), imshow(out_im_2_d, map2), colorbar, truesize;

out_im_3_r_d = myCLAHE(inp_im_3_r);
out_im_3_g_d = myCLAHE(inp_im_3_g);
out_im_3_b_d = myCLAHE(inp_im_3_b);
out_im_3_d = cat(3, out_im_3_r_d, out_im_3_g_d, out_im_3_b_d);
figure('Name', 'Contrast-enhanced (CLAHE threshold=0.007) canyon.png'), imshow(out_im_2_d, map3), colorbar, truesize;
%This method produces the best results as expected, and yet again, a
%smaller window means more contrast and more noise

%% Output
save(out_imgFil_1_a, 'out_im_1_a');
save(out_imgFil_2_a, 'out_im_2_a');
save(out_imgFil_3_a, 'out_im_3_a');

save(out_imgFil_1_b, 'out_im_1_b');
save(out_imgFil_2_b, 'out_im_2_b');
save(out_imgFil_3_b, 'out_im_3_b');

save(out_imgFil_1_c, 'out_im_1_c_20');
save(out_imgFil_2_c, 'out_im_2_c_20');
save(out_imgFil_3_c, 'out_im_3_c_20');

save(out_imgFil_1_d, 'out_im_1_d');
save(out_imgFil_2_d, 'out_im_2_d');
save(out_imgFil_3_d, 'out_im_3_d');

toc;