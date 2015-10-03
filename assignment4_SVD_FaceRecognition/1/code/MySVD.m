function [U, S, V] = MySVD( X )
%MYSVD
    [V, lambda] = eig(X.' * X);
    %size(lambda)
    %size(V)
    [lambda, indV] = sort(diag(lambda));
    V = V(:, indV);
    S = sqrt(diag(lambda)); 
    U = X * (V / S);
end

