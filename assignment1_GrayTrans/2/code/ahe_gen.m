function [ out ] = ahe_gen( X )
    [row, col] = size(X);
    area = row * col;
    freq = (hist(X(:).',0:255)) / area;
    cdf = cumsum(freq);
    out = cdf(X(ceil(row / 2), ceil(col / 2)) + 1);
end
