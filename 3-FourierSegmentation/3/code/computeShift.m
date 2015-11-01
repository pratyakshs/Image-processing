function [ out, conv ] = computeShift( x, y, vecLi, row, col, n, hs, hc)
    sumNum = 0;
    sumDen = 0;
    
    Ind = ones(n, n); 
    Ind(1:2 * n) = 0 ; 
    Ind(randperm(numel(Ind))) = Ind;
    %Ind = uint8(Ind);
    %Ind = randi([0 1], n,n);
    %ceil(n/2.0)
    LimL = ceil(n/2.0) - y(1) + 1;
    LimR = ceil(n/2.0) + col - y(1);
    LimU = ceil(n/2.0) - y(2) + 1;
    LimD = ceil(n/2.0) + row - y(2);
    for i = max(1, LimL):min(n, LimR)
        for j = max(1, LimU):min(n, LimD)
            if (Ind(i,j) < 1)
                hoCo = i - ceil(n / 2.0) + y(1);
                veCo = j - ceil(n / 2.0) + y(2);
                temp = vecLi{veCo + (hoCo - 1) * col};
                wt1 = exp(-((temp(1:3) - x(1:3)) * (temp(1:3) - x(1:3)).') / hc^2);
                wt2 = exp(-((temp(4:5) - x(4:5)) * (temp(4:5) - x(4:5)).') / hs^2);
                wt = wt1 * wt2;
                sumNum = sumNum + temp * wt;
                sumDen = sumDen + wt;
            end
        end
    end
    conv = 0;
    if sumDen == 0
        %display('Here');
        out = x;
    else
        out = sumNum / sumDen;
        if (out - x) * (out - x).' < 1E-10
            conv = 1;
        end
    end
end

