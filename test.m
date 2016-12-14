%% test script
clc;clear all;;

% load calculated BTFs
load('codeBookViper.mat');

% Red channel
imgTest1 = imread('010_a.bmp');
imgTest2 = imread('010_b.bmp');
for i = 4 : size(codeBookR,2)
    matBTFR = codeBookR{i}{1};
    score = useBTF(matBTFR, imgTest1, imgTest2,1)
end

