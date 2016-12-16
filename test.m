%% test script
clc;clear all;;

% load calculated BTFs
load('codeBookViper.mat');

% load test images
imgTest1 = imread('010_a.bmp');
imgTest2 = imread('010_b.bmp');

%% Red channel
for i = 1 : size(codeBookR,2)
    matBTFR = codeBookR{i}{1};
    scoreR = useBTF(matBTFR, imgTest1, imgTest2,1);
    fprintf('scoreR = %d\n',scoreR);
end

%% Green channel
for i = 1 : size(codeBookG,2)
    matBTFG = codeBookG{i}{1};
    scoreG = useBTF(matBTFG, imgTest1, imgTest2,2);
    fprintf('scoreG = %d\n',scoreG);
end

%% Blue channel
for i = 1 : size(codeBookB,2)
    matBTFB = codeBookB{i}{1};
    scoreB = useBTF(matBTFB, imgTest1, imgTest2,3);
    fprintf('scoreB = %d\n',scoreB);
end

% load BTF from image pair 1
load('imgTestBTF1.mat');
for i = 1 : 3
    matTestBTF = imgBTF(:,:,i);
    scoreTest = useBTF(matTestBTF, imgTest1, imgTest2,i);
    fprintf('scoreTest = %d\n',scoreTest);
end
