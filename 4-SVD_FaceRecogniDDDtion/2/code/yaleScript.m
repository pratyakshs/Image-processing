%% MyMainScript
%runs recognition script on yale database recog rates ~ 62% taking all
%people
dataPath = uigetdir;
imageSize = 192 * 168;
noOfppl = 38;
trainImS = 30;
testImS = 30;
k_list = [1, 2, 3, 5, 10, 20, 30, 50, 60, 65, 75, 100, 200, 300, 500, 1000];
tic;
runRecognition(dataPath, imageSize, noOfppl, trainImS, testImS, k_list, 4);
toc;
