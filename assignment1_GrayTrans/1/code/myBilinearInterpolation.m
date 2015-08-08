function [ Iex ] =  myBilinearInterpolation( Im, exRow, exCol )
    [row, col] = size(Im);
    rowF = (row*exRow) - exRow + 1;
    colF = (col*exCol) - exCol + 1;
    [X, Y] = meshgrid(1:exCol:colF, 1:exRow:rowF);
    [Xf, Yf] = meshgrid(1:colF, 1:rowF);
    Iex = interp2(X, Y, double(Im), Xf, Yf, 'bilinear'); 
end

