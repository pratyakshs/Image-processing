function [ imRes ] = myPCADenoising2( im, sigma, K )
%MYPCADENOISING2 Summary of this function goes here
%   Detailed explanation goes here
tic;

P_x = size(im, 1) - 6;
P_y = size(im, 2) - 6;

patch_add = zeros(size(im));
patch_add_count = zeros(size(im));

for i = 1:P_x
    for j = 1:P_y
        % Extract the 7x7 patch
        patch = im(i:i+6, j:j+6);
        patch = patch(:);
        
        % Get size of the neighborhood to search in
        Nx = [max([1, i-15]), min([P_x, i+15-6])];
        Ny = [max([1, j-15]), min([P_y, j+15-6])];
        Nsize = (Nx(2)-Nx(1)+1)*(Ny(2)-Ny(1)+1);
        B = 0;
        
        % Range of indices
        Rx = (Nx(2)-Nx(1)+1);
        Ry = (Ny(2)-Ny(1)+1);
        
        % Get 7x7 patches in the neighborhood
        P = zeros([49, Nsize]);
        for x=1:Rx
            for y=1:Ry
                N_patch = im(x+Nx(1)-1:x+Nx(1)+5, y+Ny(1)-1:y+Ny(1)+5);
                N_patch = N_patch(:);
                col_index = (x-1)*Ry+y;
                P(:, col_index) = N_patch;                  
            end
        end
        
        % Select 200 nearest patches
        Q_idx = knnsearch(P.', patch.', 'k', min([K, Nsize]));
        Q = P(:, Q_idx);
        
        % Compute eigenvectors and eigencoefficients
        R = Q * Q.';
        [V, ~] = eig(R);
        A = V.' * Q;
        
        % Compute the estimates of the average squared eigen-coefficients 
        % of the original (clean) patches
        A_2 = A .* A;
        est = zeros([1 49]);
        for k = 1:49
            est(k) = max(0, (sum(A_2(k, :))/min([K, Nsize])) - sigma^2);
        end
        
        % Compute the denoised coefficients
        denom = arrayfun(@(v) 1 + sigma^2/v, est);
        A_denoised = zeros(size(A));
        
        for k = 1:49
            A_denoised(k, :) = A(k, :) / denom(k);
        end
        
        % Compute the denoised patch
        P_denoised = V * A_denoised(:, 1);
        patch_add(i:i+6, j:j+6) = patch_add(i:i+6, j:j+6) + reshape(P_denoised, 7, 7);
        patch_add_count(i:i+6, j:j+6) = patch_add_count(i:i+6, j:j+6) + 1;
        
    end
end

imRes = patch_add ./ patch_add_count;

toc;
%end

