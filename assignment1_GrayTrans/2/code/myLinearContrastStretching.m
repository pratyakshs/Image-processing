function [out_img] = myLinearContrastStretching(in_img)
max_val = double(max(in_img));
min_val = double(min(in_img));
orig_range = max_val - min_val;
[row, col] = size(in_img);
out_img = zeros(row, col, 'like', in_img);

for i = 1:row;
    for j = 1:col;
        out_img(i,j) = ((double(in_img(i,j))-min_val)/orig_range)*255.0;
    end
end
end