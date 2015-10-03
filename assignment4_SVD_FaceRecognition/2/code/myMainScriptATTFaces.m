%% MyMainScript

dataPath = uigetdir;
imageSize = 92 * 112;
noOfppl = 40;
trainImS = 5;
testImS = 5;
tic;
runRecognition(dataPath, imageSize, noOfppl, trainImS, testImS);
toc;
