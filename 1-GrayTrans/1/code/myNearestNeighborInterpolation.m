function [B] = myNearestNeighborInterpolation(A)
%% Resizes a (M, N) image matrix to a (3*M-2, 2*N-1) image.
waitbar(0, 'Resizing using Nearest-Neighbor Interpolation');
[M, N] = size(A);   % Dimension of input image
B = zeros(3*M-2, 2*N-1);    % Empty output image
B(1, :) = nearestNeighborX(A(1, :));    % First row of output image
B(2, :) = B(1, :);  % Second row of output image
wb = waitbar(1/M);  % Create a waitbar
for i = 2:M-1   % For the rest of the input image rows
    B(3*(i-1), :) = nearestNeighborX(A(i, :));  % Resize to 3 rows
    B(3*(i-1)+1, :) = B(3*(i-1), :);
    B(3*(i-1)+2, :) = B(3*(i-1), :);
    waitbar(i/M);   % Update the waitbar
end
B(3*M-2, :) = nearestNeighborX(A(M, :));    % Last two rows of the output
B(3*M-3, :) = B(3*M-2, :);
waitbar(1);
close(wb);  % Close the waitbar
end