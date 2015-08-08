function [B] = myNearestNeighborInterpolation(A)
[M, N] = size(A);
B = zeros(3*M-2, 2*N-1);
B(1, :) = nearestNeighborX(A(1, :));
B(2, :) = B(1, :);
for i = 2:M-1
    B(3*(i-1), :) = nearestNeighborX(A(i, :));
    B(3*(i-1)+1, :) = B(3*(i-1), :);
    B(3*(i-1)+2, :) = B(3*(i-1), :);
end
B(3*M-2, :) = nearestNeighborX(A(M, :));
B(3*M-3, :) = B(3*M-2, :);
end