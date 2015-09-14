function [ Iout, conve, vecLi ] = myMeanShiftSegmentation( Im, n, hs, hc, t)
%Apply mean shift segmentation to an image (we restrict to n nearest
%neighbours ,hs, hc, as the bandwidth parameters for t iterations
    [row, col, ra] = size(Im);
    Im = double(Im);
    [X, Y] = meshgrid(1:row, 1:col);
    
    extdIm = cat(ra, cat(ra, Im, X), Y);
    %extdIm(7,2,4)
    %extdIm(7,2,5)
 
    %vecLi = reshape(extdIm, row * col, ra + 2);
    %initial = num2cell(vecLi(:,(ra+1):(ra+2)), 2);
    %vecLi = num2cell(vecLi, 2);
    %vecLi(1,4)
    %vecLi(1,5)
    %vecLi(2,4)
    %vecLi(2,5)
    h = waitbar(0,'Step 1: Progress on mean shift');
    half = floor(n/2);
    conve = zeros([row col]);
    for time = 1:t
        %[vecLi, conve] = cellfun(@(x, y) computeShift(x, y, vecLi, row, col, n, hs, hc), vecLi, initial, 'UniformOutput', false);
        for i = 1:row
            for j = 1:col
                w_up = min([half, i-1]);
                w_down = min([half, row-i]);
                w_left = min([half, j-1]);
                w_right = min([half, col-j]);
 
                window = extdIm(i-w_up:i+w_down, j-w_left:j+w_right,:);
                %diff = zeros(size(window));
                %diff = zeros([w_down + w_up + 1, w_left + w_right + 1, 1]);
                %(window(:,:,1) - extdIm(i, j, 1)).^2;
                diff = (window(:,:,1) - extdIm(i, j, 1)).^2 + (window(:,:,2) - extdIm(i, j, 2)).^2 + (window(:,:,3) - extdIm(i, j, 3)).^2;
                diff = diff(:,:)/hc^2 + ((window(:,:,4) - extdIm(i, j, 4)).^2 + (window(:,:,5) - extdIm(i, j, 5)).^2)/hs^2;
                %size(diff)
                %size(window)
                mask = exp(-diff);
                %size(mask)
                %size(window(:,:,1))
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
                
        %size(d{1})
        %vecLi = d;
        
    end
    checked = zeros([row * col, 1]);
    vecLi = reshape(extdIm, row * col, ra + 2);
    ImCop = num2cell(vecLi);
    %vecLi = cell2mat(vecLi);
    %Iout = reshape(vecLi, row, col, ra + 2);
    %Iout = Iout(:,:,1:ra);
    close(h);
    %Iout = 0;
    %return;
    conve = reshape(conve, row * col, 1);
    %conve = cell2mat(conve);
    %sum(conve)
    h = waitbar(0,'Step 2: Progress on clustering');
    for i = 1:row*col
        if(conve(i) == 1 && checked(i) == 0)
            IndS = rangesearch(vecLi(:, 4:5), vecLi(i, 4:5), hs);
            %display(IndS);
            IndS = IndS{1};
            IndF = rangesearch(vecLi(IndS, 1:3), vecLi(i, 1:3), hc);
            IndF = IndF{1};
            checked(IndS(IndF)) = 1;
            ImCop(IndS(IndF)) = ImCop(i);
        end
        waitbar(double(i)/(row*col),h,'Step 2: Progress on clustering');
    end
    close(h);
    Iout = reshape(cell2mat(ImCop), row, col, ra + 2);
    Iout = Iout(:,:,1:ra);
end