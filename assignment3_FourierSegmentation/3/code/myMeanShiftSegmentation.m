function [ Iout, count ] = myMeanShiftSegmentation( Im, n, hs, hc, t)
%Apply mean shift segmentation to an image (we restrict to n nearest
%neighbours ,hs, hc, as the bandwidth parameters for t iterations
    [row, col, ra] = size(Im);
    Im = double(Im);
    [X, Y] = meshgrid(1:row, 1:col);
    
    extdIm = cat(ra, cat(ra, Im, X), Y);

    h = waitbar(0,'Step 1: Progress on mean shift');
    half = floor(n/2);
    conve = zeros([row col]);
    for time = 1:t
        for i = 1:row
            for j = 1:col
                w_up = min([half, i-1]);
                w_down = min([half, row-i]);
                w_left = min([half, j-1]);
                w_right = min([half, col-j]);
 
                window = extdIm(i-w_up:i+w_down, j-w_left:j+w_right,:);
                diff = (window(:,:,1) - extdIm(i, j, 1)).^2 + (window(:,:,2) - extdIm(i, j, 2)).^2 + (window(:,:,3) - extdIm(i, j, 3)).^2;
                diff = diff(:,:)/hc^2 + ((window(:,:,4) - extdIm(i, j, 4)).^2 + (window(:,:,5) - extdIm(i, j, 5)).^2)/hs^2;
                mask = exp(-diff);
                den = sum(sum(mask));
                temp = extdIm(i,j,:);
                extdIm(i,j,1) = sum(sum(mask .* window(:,:,1)));
                extdIm(i,j,2) = sum(sum(mask .* window(:,:,2)));
                extdIm(i,j,3) = sum(sum(mask .* window(:,:,3)));
                extdIm(i,j,4) = sum(sum(mask .* window(:,:,4)));
                extdIm(i,j,5) = sum(sum(mask .* window(:,:,5)));
                extdIm(i,j,:) = extdIm(i,j,:) / den;
                
                if(sum((temp - extdIm(i, j, :)).^2) < 1)
                    conve(i, j) = 1;
                end
            end
            waitbar(double(time - 1)/t + double(i)/(t * row),h ,'Step 1: Progress on mean shift');
        end        
    end
    checked = zeros([row * col, 1]);
    vecLi = reshape(extdIm, row * col, ra + 2);
    ImCop = vecLi;
   
    close(h);
    conve = reshape(conve, row * col, 1);
    h = waitbar(0,'Step 2: Progress on clustering');
    count = 0;
    for i = 1:row*col
        if(conve(i) == 1 && checked(i) == 0)
            count = count + 1;
            IndS = rangesearch(vecLi(:, 4:5), vecLi(i, 4:5), hs * 1.1);
            IndS = IndS{1};
            IndF = rangesearch(vecLi(IndS, 1:3), vecLi(i, 1:3), hc * 2);
            IndF = IndF{1};
            temp = IndS(IndF);
            checked(temp) = 1;
            sz = max(size(temp));
            for idx = 1:sz
                ImCop(temp(idx), :) = ImCop(i, :);
            end
        end
        waitbar(double(i)/(row*col),h,'Step 2: Progress on clustering');
    end
    close(h);
    Iout = reshape(ImCop, row, col, ra + 2);
    Iout = Iout(:,:,1:ra);
end