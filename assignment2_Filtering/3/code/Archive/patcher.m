function [ pix ] = patcher( ext_win, patch_size, win_size, h, gau_var )
%This does the patch based filtering for one pixel with a window size
%win_size around it
%   ext_win is the extended window of size win_size+patch. This is because
%   the boundary patches can go outside the original window size; h is the
%   parameter to be tuned; gau_var is the gaussian variance used to make
%   the patch isotropic; win_size is the original window size
    [rows, cols] = size(ext_win);
    pix_pos_row = ceil(rows/2);
    pix_pos_col = ceil(cols/2);
    %pix_patch is the isotropic patch around the pixel for which the new
    %intensity is to be calculated
    pix_patch = myPatchHelper1(ext_win(pix_pos_row-patch_size/2:pix_pos_row+patch_size/2,pix_pos_col-patch_size/2:pix_pos_col+patch_size/2), gau_var);
    %Following are the limits for the loops
    i_init = floor((rows-win_size)/2 +1);
    i_final = floor((rows-win_size)/2 + 1 + win_size);
    j_init = floor((cols-win_size)/2 +1);
    j_final = floor((cols-win_size)/2 + 1 + win_size);
    %This is the weight matrix wherein we store weights assigned on the
    %basis of spatial distance
    weight_mat = zeros([win_size, win_size]);
    %Iterating over every pixel in the window
    for i = i_init:i_final
        for j = j_init:j_final
            temp_patch = myPatchHelper1(ext_win(i-patch_size/2:i+patch_size/2,j-patch_size/2:j+patch_size/2), gau_var);
            weight_mat(i-i_init+1,j-j_init+1) = exp((-norm2(temp_patch - pix_patch))^2/h^2);
        end
    end
    %We normalize the weight matrix
    weight_mat = weight_mat/sum(weight_mat(:));
    %This is the weigted sum
    weight_sum = 0;
    for i = i_init:i_final
        for j = j_init:j_final
            weight_sum = weight_sum + ext_win(i,j)*weight_mat(i-i_init, j-j_init);
        end
    end
    pix = weight_sum;
end

