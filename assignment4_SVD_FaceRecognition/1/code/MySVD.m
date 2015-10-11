function [U, S, V] = MySVD( X )
%MYSVD
    [V, lambda] = eig(X.' * X);
    [lambda, indV] = sort(diag(lambda));
    V = V(:, indV);
    S = sqrt(diag(lambda)); 
    U = X * (V / S);
    %Upon Cross-checking, it gives the right answer
end

