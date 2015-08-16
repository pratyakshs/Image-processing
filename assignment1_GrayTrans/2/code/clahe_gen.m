function [ out ] = clahe_gen( X, epsil )
    [row, col] = size(X);
    area = row * col;
    freq = (hist(X(:).',0:255)) / area;
    excess = 0;
    for k = 0:255
        if freq(k + 1) > epsil
            excess = excess + freq(k + 1) - epsil;
            freq(k + 1) = epsil;
        end
    end

    freq = freq + excess * ones(size(freq)) / 256;
    cdf = cumsum(freq);
    out = cdf(X(ceil(row / 2), ceil(col / 2)) + 1) ;
end
