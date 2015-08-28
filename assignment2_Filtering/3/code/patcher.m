function [ pix_intensity ] = patcher( in_image, pix, win_size, patch_size, h, iso_gau_var)
%Applied patch based filtering for a single pixel in a given window
%   Description
    %Create the window dynamically
    [rows, cols] = size(in_image);
    win_top_lim = min((win_size-1)/2 - 1, pix(2) - 1);
    win_bot_lim = min((win_size-1)/2 - 1, rows-pix(2));
    win_lef_lim = min((win_size-1)/2 - 1, pix(1) - 1);
    win_rig_lim = min((win_size-1)/2 - 1, cols-pix(1));
    dyn_win = in_image(pix(1)-win_lef_lim:pix(1)+win_rig_lim, pix(2)-win_top_lim:pix(2)+win_bot_lim);
    %This is the weight matrix wherein we store weights assigned on the
    %basis of spatial distance
    weight_mat = zeros(size(dyn_win));
    for i = pix(1)-win_lef_lim:pix(1)+win_rig_lim
        for j = pix(2)-win_top_lim:pix(2)+win_bot_lim
            %Dynamically create patches
            patch_top_lim = min(min((patch_size-1)/2 - 1, j - 1), win_top_lim);
            patch_bot_lim = min(min((patch_size-1)/2 - 1, rows-j), win_bot_lim);
            patch_lef_lim = min(min((patch_size-1)/2 - 1, i - 1), win_lef_lim);
            patch_rig_lim = min(min((patch_size-1)/2 - 1, cols-i), win_rig_lim);
            
            pix_patch = in_image((pix(1)-patch_lef_lim):(pix(1)+patch_rig_lim), (pix(2)-patch_top_lim):(pix(2)+patch_bot_lim));
            pix_patch = isotropize(pix_patch, pix(1)-patch_lef_lim, pix(1)+patch_rig_lim, pix(2)-patch_top_lim, pix(2)+patch_bot_lim, iso_gau_var, patch_size, pix);
            temp_patch = in_image((i-patch_lef_lim):(i+patch_rig_lim), (j-patch_top_lim):(j+patch_bot_lim));
            temp_patch = isotropize(temp_patch, i - patch_lef_lim, i + patch_rig_lim, j - patch_top_lim, j + patch_bot_lim, iso_gau_var, patch_size, [i j]);
            %TODO: Make patches isotropic!!!!
            weight_mat(i-pix(1)+win_lef_lim+1,j-pix(2)+win_top_lim+1) = exp((-norm(temp_patch - pix_patch))^2/h^2);
        end
    end
    %We normalize the weight matrix
    weight_mat = weight_mat/sum(weight_mat(:));
    %This is the weigted sum
    weighted_in = weight_mat .* dyn_win;
    pix_intensity = sum(weighted_in(:));
end

