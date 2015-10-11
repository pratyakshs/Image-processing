function [ prinDir, train_set, out_set, k_list] = runReconstruction( dataPath, imageSize, noOfppl, data_set, test_image, k_list)
%Function to reconstruct faces
%   Uses PCA to reconstruct faces
train_set = zeros([imageSize, noOfppl * data_set]);
train_label = zeros([1, noOfppl * data_set]);
dirList = dir(dataPath);

ind = 0;
for person = dirList'
    if person.isdir && ~strcmp(person.name,'.') && ~strcmp(person.name,'..')
        personPath = strcat(dataPath,filesep,person.name);
        piclist = dir(personPath);
        no = 0;
        i = 0;
        while no < data_set
            i = i + 1;
            if(piclist(i).isdir)
                continue;
            end
            Im = imread(strcat(personPath,filesep,piclist(i).name));
            train_set(:, no + 1 + ind * data_set) = Im(:);
            train_label(no + 1 + ind * data_set) = ind + 1;
            no = no + 1;
        end
        ind = ind + 1;
    end
end
out_set = zeros([imageSize, max(size(k_list))]);
mean_train = mean(double(train_set), 2);
train_set = double(train_set) - mean_train(:, ones([1, noOfppl * data_set]));
[~, prinDir] = myPCA(train_set);
test_image = test_image(:);
curr_acc = zeros(size(test_image));
transTest = prinDir.' * (test_image - mean_train);
ind = 1;
for i = 1:max(k_list)
    curr_acc = curr_acc + prinDir(:, i) * transTest(i);
    if i == k_list(ind)
        out_set(:, ind) = mean_train + curr_acc; 
        ind = ind + 1;
    end
end
min_val = min(prinDir(:));
max_val = max(prinDir(:));
topTF = prinDir(:,1:25);
for i = 1:25
   img = reshape(topTF(:,i), [112, 92]);
   figure(1)
   subplot(5,5,i), subimage(img * 200, [min_val * 200, max_val * 200]);
   %These are the top 25 eigenfaces, they get more pronounced as the value of k
   %increases
end
for i = 1:25
   img = reshape(topTF(:,i), [112, 92]);
   ft_img = fft2(img);
   ft_img = fftshift(ft_img);
   ft_img = abs(ft_img);
   ft_img = 1 + ft_img;
   ft_img = log(ft_img);
   figure(2)
   subplot(5,5,i), subimage(ft_img * 255, [0, 255]);
   %The eigen-face images seem to contain more and more
   %high frequency information as the corresponding
   %eigen-values decrease
end
end

