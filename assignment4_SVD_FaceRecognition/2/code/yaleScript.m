%% MyMainScript
dataPath = uigetdir;
imageSize = 192 * 168;
noOfppl = 38;
trainImS = 30;
testImS = 30;
tic;
runRecognition(dataPath, imageSize, noOfppl, trainImS, testImS);
toc;
