clear all;
close all;
clc;

run '../vlfeat-0.9.17/toolbox/vl_setup'

%%
path = '../objects/';
trainPart = 5;
testPart = 10;
k = 1000;
[categories, objects, train, test] = getData(path, trainPart, testPart);
[Dtrain, DtrainCat] = getDescriptors(path, categories, objects, train, 'data/train5_10_1000Descriptors.mat');
[Dtest, DtestCat] = getDescriptors(path, categories, objects, test, 'data/test5_10_1000Descriptors.mat');

[C, I] = trainClusters(Dtrain, k, 'data/train5_10_1000Clusters.mat');

trainHist = bow(DtrainCat, I, k, path, categories, objects);

Ci  = pushClusters(Dtest, C, 'data/test5_10_1000Clusters.mat');

testHist = bow(DtestCat, Ci, k, path, categories, objects);

[testHist, accuracy] = retrieve(trainHist, testHist, 'bhattacharyya');
visualizeCorrect(trainHist, testHist);
