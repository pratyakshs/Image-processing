function [ pix_intensity ] = patcher( in_image, pix, win_size, patch_size, h, iso_gau_var)
%Definition
%   Description
    %Create the window dynamically
    [rows, cols] = size(in_image);
    win_top_lim = min((win_size-1)/2, pix(2));
    win_bot_lim = min((win_size-1)/2, rows-pix(2));
    win_lef_lim = min((win_size-1)/2, pix(1));
    win_rig_lim = min((win_size-1)/2, cols-pix(1));
    dyn_win = in_image(win_lef_lim:win_rig_lim, win_top_lim:win_bot_lim);
    %This is the weight matrix wherein we store weights assigned on the
    %basis of spatial distance
    weight_mat = zeros(size(dyn_win));
    for i = win_lef_lim:win_rig_lim
        for j = win_top_lim:win_bot_lim
            %Dynamically create patches
            patch_top_lim = min((patch_size-1)/2, j-win_top_lim);
            patch_bot_lim = min((patch_size-1)/2, win_bot_lim-j);
            patch_lef_lim = min((patch_size-1)/2, i-win_lef_lim);
            patch_rig_lim = min((patch_size-1)/2, win_rig_lim-i);
            pix_patch = in_image((pix(1)-patch_lef_lim):(pix(1)+patch_rig_lim), (pix(2)-patch_top_lim):(pix(2)+patch_bot_lim));
            pix_patch = isotropize(pix_patch, patch_lef_lim, patch_rig_lim, patch_top_lim, patch_bot_lim, iso_gau_var);
            temp_patch = in_image((i-patch_lef_lim):(i+patch_rig_lim), (j-patch_top_lim):(j+patch_bot_lim));
            temp_patch = isotropize(temp_patch, patch_lef_lim, patch_rig_lim, patch_top_lim, patch_bot_lim, iso_gau_var);
            %TODO: Make patches isotropic!!!!
            weight_mat(i-win_lef_lim+1,j-win_top_lim+1) = exp((-norm2(temp_patch - pix_patch))^2/h^2);
        end
    end
    %We normalize the weight matrix
    weight_mat = weight_mat/sum(weight_mat(:));
    %This is the weigted sum
    weight_sum = 0;
    for i = win_lef_lim:win_rig_lim
        for j = win_top_lim:win_bot_lim
            weight_sum = weight_sum + in_image(i,j)*weight_mat(i-win_lef_lim+1, j-win_top_lim+1);
        end
    end
    pix_intensity = weight_sum;
end

