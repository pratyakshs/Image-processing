function [lambda,  V ] = myPCA( X )
%MYPCA
   [V, lambda] = eig(X' * X);
   [lambda, ind] = sort(diag(lambda), 'descend');
   lambda = diag(lambda);
   V = V(:, ind);
   %V(:, end).' * X' * (X * V(:, end))
   V = X * V;
   [~, col] = size(V);
   for i = 1:col
       V(:, i) = V(:, i)/norm(V(:, i));
   end
end

