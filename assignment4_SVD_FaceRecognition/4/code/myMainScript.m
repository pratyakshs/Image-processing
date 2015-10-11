
%%
% If the probe image is not in the training set, the algorithm used in Q2 will identify the image to be the one which has the closest
% eigen-coefficients - and we will get a match (a false positive). 

% A simple solution to overcome this problem will be to use a threshold -
% d, such that if the RMSD of the projected probe image with the eigen
% coefficients of the images in the gallery is greater than d, then the
% image is not said to be recognized. Otherwise, the usual algorithm is
% followed.

% The threshold is adjusted in order to get a balance between false
% positives recognition rate on the test set (35 * 5 images). 
% Consider D_max_gallery = maximum RMSD (actually RMSD * image_size) of 
% probe image with the eigen coefficients, over all probe images in the
% gallery that are recognized correctly.

% If we set d := D_max_gallery, then there will be no false negatives (all
% images in the gallery will be identified). 
% We set d := D_max_gallery - epsilon, in order to get a balance between
% false positives and recognition rate (and also the number of false
% negatives)

%% MyMainScript
dataPath = uigetdir;
imageSize = 92 * 112;
noOfppl = 35;
trainImS = 5;
testImS = 5;
testSize2 = 5;

[ D_max_gallery, train_set, mean_train, test_set, test_set2, transTrain, transTest, transTest2, train_label, test_label  ] = maxDist(dataPath, imageSize, noOfppl, trainImS, testSize2, testImS, 1);

% We adjust the threshold to 85% of the 
D_max_gallery = D_max_gallery * 0.85;

% k is chosen to be 150 because we got highest recognition rate at k = 150
% (see Q2)
k = 150;

% calculate distances (from the eigen coefficients) and identified labels 
% of the training set images (projected)
[ind, distances] = knnsearch(transTrain(1:150,:).', transTest(1:k,:).');

% calculate distances (from eigen coefficients) of the remaining 5 * 10
% images. 
[~, distances2] = knnsearch(transTrain(1:150,:).', transTest2(1:k,:).');

% change train_label = 0 (image is not identified) for all images whose 
% distance is greater than threshold
modLabel = (arrayfun(@(x) (x <= D_max_gallery), distances)).' .* train_label(ind);

% calculate number of false positives
falsePositives = sum(arrayfun(@(x) x < D_max_gallery, distances2))

% calculate number of false negatives
falseNegatives = sum(arrayfun(@(x) x > D_max_gallery, distances))

% calculate recognition rate
recogRate = sum(bsxfun(@eq ,modLabel, test_label)) / (noOfppl * testImS)

tic;