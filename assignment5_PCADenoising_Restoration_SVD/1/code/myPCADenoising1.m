function [imRes ] = myPCADenoising1( im, sigma )
%MYPCADENOISING1 Summary of this function goes here
%   Detailed explanation goes here

P_x = size(im, 1) - 6;
P_y = size(im, 2) - 6;
N = P_x * P_y;

P = zeros([49, N]);

% Populate the matrix P using patches of size 7x7
for i = 1:P_x
    for j = 1:P_y
        col_index = (i - 1) * P_y + j;
        % Extract patch of size 7x7
        patch = im(i:i+6, j:j+6);
        % Reshape it and store in the correct column of P
        P(:, col_index) = patch(:);
    end
end

% Get eigenvectors of P*P'
Q = P * P.';
[V, ~] = eig(Q);

%Sort eigenvectors?
%[lambda, ind] = sort(diag(lambda), 'descend');
%lambda = diag(lambda);
%V = V(:, ind);

% And the eigen-coefficients
A = V.' * P;

% normalize?
%for i=1:N
%    A(:, i) = A(:, i)/norm(A(:, i));
%end

% Compute the estimates of the average squared eigen-coefficients 
% of the original (clean) patches
A_2 = A .* A;
est = zeros([1 49]);
for j = 1:49
    est(j) = max(0, (sum(A_2(j, :))/N) - sigma^2);
end

% Compute the denoised coefficients
denom = arrayfun(@(v) 1 + sigma^2/v, est);
A_denoised = zeros(size(A));
for j = 1:49
    A_denoised(j, :) = A(j, :) / denom(j);
end

% Compute the denoised patches
P_denoised = V * A_denoised;

% Reconstruct the output image
patch_add = zeros(size(im));

% Keep counts for averaging
patch_add_count = zeros(size(im));

for i=1:P_x
    for j=1:P_y
        col_index = (i - 1) * P_y + j;
        patch_add(i:i+6, j:j+6) = patch_add(i:i+6, j:j+6) + reshape(P_denoised(:, col_index), 7, 7);
        patch_add_count(i:i+6, j:j+6) = patch_add_count(i:i+6, j:j+6) + 1;
    end
end

% Averaging on the accumulated patches
imRes = patch_add ./ patch_add_count;

end
