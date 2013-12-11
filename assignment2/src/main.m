clear all;
close all;
clc;

run '../vlfeat-0.9.17/toolbox/vl_setup'

%%
path = '../objects/';
trainPart = 10;
testPart = 10;
k = 2000;
[categories, objects, train, test] = getData(path, trainPart, testPart);
[Dtrain, DtrainCat] = getDescriptors(path, categories, objects, train, 'data/train10_10_2000Descriptors.mat');
[Dtest, DtestCat] = getDescriptors(path, categories, objects, test, 'data/test10_10_2000Descriptors.mat');

[C, I] = trainClusters(Dtrain, k, 'data/train10_10_2000Clusters.mat');

trainHist = bow(DtrainCat, I, k, path, categories, objects);

Ci  = pushClusters(Dtest, C, 'data/test10_10_2000Clusters.mat');

testHist = bow(DtestCat, Ci, k, path, categories, objects);

[testHist, accuracy] = retrieve(trainHist, testHist, 'bhattacharyya');
visualizeCorrect(trainHist, testHist);
