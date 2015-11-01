function [X2] = nearestNeighborX(X)
[M, N] = size(X);
if rem(N, 2) == 1
    l = X(1, 1:floor(N/2))';
    lr = repmat(l, 1, 2)';
    lr = lr(:)';
    r = X(1, floor(N/2)+2:N)';
    rr = repmat(r, 1, 2)';
    rr = rr(:)';
    X2 = [lr X(1, floor(N/2)+1) rr];
else
    l = X(1, 1:floor(N/2)-1)';
    lr = repmat(l, 1, 2)';
    lr = lr(:)';
    r = X(1, floor(N/2)+1:N)';
    rr = repmat(r, 1, 2)';
    rr = rr(:)';
    X2 = [lr X(floor(N/2)) rr];
end