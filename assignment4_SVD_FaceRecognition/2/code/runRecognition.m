<<<<<<< HEAD
function [ prinDir, train_set, test_set, k_list, inden_rate ] = runRecognition( dataPath, imageSize, noOfppl, trainImS, testImS, k_list, start_no )
=======
function [ prinDir, train_set, test_set, k_list, inden_rate ] = runRecognition( dataPath, imageSize, noOfppl, trainImS, testImS, k_list )
>>>>>>> origin/master
%RUNRECOGNITION Summary of this function goes here
%   Detailed explanation goes here
train_set = zeros([imageSize, noOfppl * trainImS]);
train_label = zeros([1, noOfppl * trainImS]);
test_set = zeros([imageSize, noOfppl * testImS]);
test_label = zeros([1, noOfppl * testImS]);
dirList = dir(dataPath);
ind = 0;
for person = dirList'
    if person.isdir && ~strcmp(person.name,'.') && ~strcmp(person.name,'..')
        personPath = strcat(dataPath,filesep,person.name);
        piclist = dir(personPath);
        no = 0;
        i = 0;
        while no < trainImS
            i = i + 1;
            if(piclist(i).isdir)
                continue;
            end
            Im = imread(strcat(personPath,filesep,piclist(i).name));
            train_set(:, no + 1 + ind * trainImS) = Im(:);
            train_label(no + 1 + ind * trainImS) = ind + 1;
            no = no + 1;
        end
        while no < trainImS + testImS
            i = i + 1;
            if(piclist(i).isdir)
                continue;
            end
            Im = imread(strcat(personPath,filesep,piclist(i).name));
            test_set(:, no + 1 - trainImS + ind * testImS) = Im(:);
            test_label(no + 1 - trainImS + ind * testImS) = ind + 1;
            no = no + 1;
        end
        ind = ind + 1;
    end
end
<<<<<<< HEAD
=======

>>>>>>> origin/master
inden_rate = zeros(size(k_list));
%% Your code here
train_set = double(train_set);
test_set = double(test_set);
[~, prinDir] = myPCA(train_set);
transTrain = prinDir.' * train_set;
transTest = prinDir.' * test_set;
for i = 1:max(size(k_list))
    k = k_list(i) + start_no - 1;
    ind = knnsearch(transTrain(start_no:k,:).', transTest(start_no:k,:).');
    inden_rate(i) = sum(bsxfun(@eq ,train_label(ind), test_label)) / (noOfppl * testImS); 
end
plot(k_list, inden_rate);
end

