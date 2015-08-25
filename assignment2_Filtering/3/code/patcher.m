function [ pix ] = patcher( ext_win, patch_size, win_size, h, gau_var )
%UNTITLED4 Summary of this function goes here
%   Detailed explanation goes here
    [rows, cols] = size(ext_win);
    pix_pos_row = ceil(rows/2);
    pix_pos_col = ceil(cols/2);
    pix_patch = myPatchHelper1(ext_win(pix_pos_row-patch_size/2:pix_pos_row+patch_size/2,pix_pos_col-patch_size/2:pix_pos_col+patch_size/2), gau_var);
    i_init = floor((rows-win_size)/2 +1);
    i_final = floor((rows-win_size)/2 + 1 + win_size);
    j_init = floor((cols-win_size)/2 +1);
    j_final = floor((cols-win_size)/2 + 1 + win_size);
    weight_mat = zeros([win_size, win_size]);
    for i = i_init:i_final
        for j = j_init:j_final
            temp_patch = myPatchHelper1(ext_win(i-patch_size/2:i+patch_size/2,j-patch_size/2:j+patch_size/2), gau_var);
            weight_mat(i-i_init+1,j-j_init+1) = exp((-norm2(temp_patch - pix_patch))^2/h^2);
        end
    end
    weight_mat = weight_mat/sum(weight_mat(:));
    weight_sum = 0;
    for i = i_init:i_final
        for j = j_init:j_final
            weight_sum = weight_sum + ext_win(i,j)*weight_mat(i-i_init, j-j_init);
        end
    end
    pix = weight_sum;
end

