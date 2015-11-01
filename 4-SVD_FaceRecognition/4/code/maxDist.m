function [ max_dist, train_set, mean_train, test_set, test_set2, transTrain, transTest, transTest2, train_label, test_label  ] = maxDist( dataPath, imageSize, noOfppl, trainImS, testSize2, testImS, start_no )
%RUNRECOGNITION Summary of this function goes here
%   Detailed explanation goes here

train_set = zeros([imageSize, noOfppl * trainImS]);
train_label = zeros([1, noOfppl * trainImS]);
test_set = zeros([imageSize, noOfppl * testImS]);
test_set2 = zeros([imageSize, testSize2 * (testImS + trainImS)]);
test_label = zeros([1, noOfppl * testImS]);
dirList = dir(dataPath);
ind = 0;
for person = dirList'
    if ind < noOfppl
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
    else
        if person.isdir && ~strcmp(person.name,'.') && ~strcmp(person.name,'..')
            personPath = strcat(dataPath,filesep,person.name);
            piclist = dir(personPath);
            no = 0;
            i = 0;
            while no < (testImS + trainImS)
                i = i + 1;
                if(piclist(i).isdir)
                 continue;
                end
                Im = imread(strcat(personPath,filesep,piclist(i).name));
                test_set2(:, no + 1 + (ind - noOfppl) * (trainImS + testImS)) = Im(:);
                no = no + 1;
            end
            ind = ind + 1;
        end
    end
end


%% Your code here
mean_train = mean(double(train_set), 2);
% size(train_set)
% size(mean_train(:, ones([1, noOfppl * trainImS])))
train_set = double(train_set) - mean_train(:, ones([1, noOfppl * trainImS]));
test_set = double(test_set) - mean_train(:, ones([1, noOfppl * testImS]));
% size(test_set2)
% size(mean_train(:, ones([1, testSize2 * (trainImS + testImS)])))
test_set2 = double(test_set2) - mean_train(:, ones([1, testSize2 * (trainImS + testImS)]));
[~, prinDir] = myPCA(train_set);
transTrain = prinDir.' * train_set;
transTest = prinDir.' * test_set;
transTest2 = prinDir.' * test_set2;
k = 150;

[ind, distances] = knnsearch(transTrain(start_no:k,:).', transTest(start_no:k,:).');

max_dist = max(distances.' .* bsxfun(@eq ,train_label(ind), test_label));
end
