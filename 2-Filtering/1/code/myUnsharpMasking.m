function [ Iout ] = myUnsharpMasking( Im, filter_size, sigma, lim, str )
% Unsharp masking: mask created using fspecial
    filt = fspecial('gaussian', filter_size, sigma);
    Ifilt = imfilter(Im, filt); % apply low pass gaussian on Im
    %subtract out the filter difference if the magnitude exceeds a
    %threshold
    Iout = nlfilter(Im - Ifilt, [1 1], @(x) ((abs(x) > lim) * x)) + Im;
    if(str == 1) %do contrast stretching
        Iout = imadjust(Iout,stretchlim(Iout),[]);
    end
end

