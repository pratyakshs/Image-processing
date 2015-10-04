%% MyMainScript

dataPath = uigetdir;
imageSize = 92 * 112;
noOfppl = 40;
trainImS = 5;
testImS = 5;
k_list = [1, 2, 3, 5, 10, 20, 30, 50, 75, 100, 125, 150, 170];
tic;
runRecognition(dataPath, imageSize, noOfppl, trainImS, testImS, k_list);
toc;
