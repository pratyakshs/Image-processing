function [ out_image ] = myPatchBasedFiltering( in_image, win_size, patch_size, h )
%Does Patch Based Filtering to remove noise from an image
%   Detailed explanation goes here
    [rows, cols] = size(in_image);
    fin_image = zeros(rows, cols);
    wb = waitbar(0);
    gau = fspecial('gaussian', [patch_size patch_size], 1);
    for i = 1:cols
        for j = 1:rows
            win_lef_lim = i - min(floor(win_size/2), i - 1);
            win_rig_lim = i + min(floor(win_size/2), cols-i);
            win_top_lim = j - min(floor(win_size/2), j - 1);
            win_bot_lim = j + min(floor(win_size/2), rows-j);
            
            dyn_win = in_image(win_top_lim:win_bot_lim, win_lef_lim:win_rig_lim);
            
            weight_mat = zeros(size(dyn_win));
            
            for k = win_lef_lim:win_rig_lim
                for l = win_top_lim:win_bot_lim
                    patch_top_lim = min([l - 1, floor(patch_size/2), j-win_top_lim]);
                    patch_bot_lim = min([rows-l, floor(patch_size/2), win_bot_lim-j]);
                    patch_lef_lim = min([k - 1, floor(patch_size/2), i-win_lef_lim]);
                    patch_rig_lim = min([cols-k, floor(patch_size/2), win_rig_lim-i]);
                    
                    pix_patch_l = i - patch_lef_lim;
                    pix_patch_r = i + patch_rig_lim;
                    pix_patch_t = j - patch_top_lim;
                    pix_patch_b = j + patch_bot_lim;
                    
                    temp_patch_l = k - patch_lef_lim;
                    temp_patch_r = k + patch_rig_lim;
                    temp_patch_t = l - patch_top_lim;
                    temp_patch_b = l + patch_bot_lim;
                    
                    pix_patch = in_image(pix_patch_t:pix_patch_b, pix_patch_l:pix_patch_r);
                    temp_patch = in_image(temp_patch_t:temp_patch_b, temp_patch_l:temp_patch_r);
                    
                    diff_patch = temp_patch - pix_patch;
                    hw = floor(patch_size/2) + 1;
                    diff_patch = diff_patch.*gau(hw-patch_top_lim:hw+patch_bot_lim, hw-patch_lef_lim:hw+patch_rig_lim);

                    weight_mat(l-win_top_lim+1, k-win_lef_lim+1) = exp(-1 * (norm(diff_patch))^2/h^2);
                end
            end
            
            %We normalize the weight matrix
            weight_mat = weight_mat/sum(weight_mat(:));
            %This is the weigted sum
            weighted_in = weight_mat .* dyn_win;
            fin_image(j,i) = sum(weighted_in(:));
        end
        waitbar(i/rows);
    end
    waitbar(1);
    close(wb);
    out_image = fin_image;

end

