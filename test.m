%%% test script for testing BTF by comparing color correlations
clc;clear all;
close all;
%% load calculated BTFs
% load('codeBookViper.mat');
load('codeBookViper_cumHist66.mat');

% load one pair of test images
if 0
    imgTest1 = imread('010_a.bmp');
    imgTest2 = imread('010_b.bmp');
    scoreR = zeros(1,size(codeBookR,2));
    scoreG = zeros(1,size(codeBookG,2));
    scoreB = zeros(1,size(codeBookB,2));
    scoreTest = zeros(1,3);
    %% Red channel
    for i = 1 : size(codeBookR,2)
        matBTFR = codeBookR{i}{1};
        [scoreR(i), outputImg] = useBTF(matBTFR, imgTest1, imgTest2,1);
        fprintf('scoreR = %d\n',scoreR(i));
    end
    
    %% Green channel
    for i = 1 : size(codeBookG,2)
        matBTFG = codeBookG{i}{1};
        [scoreG(i), outputImg] = useBTF(matBTFG, imgTest1, imgTest2,2);
        fprintf('scoreG = %d\n',scoreG(i));
    end
    
    %% Blue channel
    for i = 1 : size(codeBookB,2)
        matBTFB = codeBookB{i}{1};
        [scoreB(i), outputImg] = useBTF(matBTFB, imgTest1, imgTest2,3);
        fprintf('scoreB = %d\n',scoreB(i));
    end
    
    % load BTF from image pair 1
    load('imgTestBTF1.mat');
    for i = 1 : 3
        matTestBTF = imgBTF(:,:,i);
        [scoreTest(i), outputImg] = useBTF(matTestBTF, imgTest1, imgTest2,i);
        fprintf('scoreTest = %d\n',scoreTest(i));
    end
    fprintf('RscoreTest = %.2d\n',(max(scoreR)-scoreTest(1))/scoreTest(1));
    fprintf('GscoreTest = %.2d\n',(max(scoreG)-scoreTest(2))/scoreTest(2));
    fprintf('BscoreTest = %.2d\n',(max(scoreB)-scoreTest(3))/scoreTest(3));
    
end
%% load multiple pairs of images
% codes for multiple paired images
if 1
    
    % out put path Z:\LCS\Smart-Vision-Systems-Lab\Yu\BTF
    outPath = 'G:\LCS\Smart-Vision-Systems-Lab\Yu\BTF\results';
    % for imageA
    pathNameA = uigetdir(pwd);
    
    %Find all images and list them in a cell array
    imageNamesA = dir(fullfile(pathNameA));
    imageNamesA = {imageNamesA.name}';
    
    % for imageB
    pathNameB = uigetdir(pwd);
    
    %Find all images and list them in a cell array
    imageNamesB = dir(fullfile(pathNameB));
    imageNamesB = {imageNamesB.name}';
    
    
    scoreR = zeros(length(imageNamesA)-2,size(codeBookR,2));
    scoreG = zeros(length(imageNamesA)-2,size(codeBookG,2));
    scoreB = zeros(length(imageNamesA)-2,size(codeBookB,2));
    
        for imgCount = 1 : length(imageNamesA)-2
%     for imgCount = 1 : 30  % test code for only 3 pics
        
        imgTest1 = imread(strcat(pathNameA,'\',imageNamesA{imgCount+2,1}));
        imgTest2 = imread(strcat(pathNameB,'\',imageNamesB{imgCount+2,1}));
        
        for i = 1 : size(codeBookR,2)
            matBTFR = codeBookR{i}{1};
            [scoreR(imgCount,i), outputImgR{i}] = useBTF(matBTFR, imgTest1, imgTest2,1);
            %             fprintf('scoreR = %d\n',scoreR(imgCount,i));
        end
        % getting the best BTF and save image R layer
        [maxR, indexR] = max(scoreR(imgCount,:));
        transImg(:,:,1) = uint8(outputImgR{indexR}(:,:,1));
%         figure();
%         imshow(transImg);
        %% Green channel
        for i = 1 : size(codeBookG,2)
            matBTFG = codeBookG{i}{1};
            [scoreG(imgCount,i), outputImgG{i}] = useBTF(matBTFG, imgTest1, imgTest2,2);
            %             fprintf('scoreG = %d\n',scoreG(imgCount,i));
        end
        [maxG, indexG] = max(scoreG(imgCount,:));
        transImg(:,:,2) = uint8(outputImgG{indexG}(:,:,2));
%         figure();
%         imshow(transImg);
        
        %% Blue channel
        for i = 1 : size(codeBookB,2)
            matBTFB = codeBookB{i}{1};
            [scoreB(imgCount,i), outputImgB{i}] = useBTF(matBTFB, imgTest1, imgTest2,3);
            %             fprintf('scoreB = %d\n',scoreB(imgCount,i));
        end
        [maxB, indexB] = max(scoreB(imgCount,:));
        transImg(:,:,3) = uint8(outputImgB{indexB}(:,:,3));
%         figure();
%         imshow(transImg(:,:,1));
%         figure();
%         imshow(transImg(:,:,2));
%         figure();
%         imshow(transImg(:,:,3));
        % write image to file
        imwrite(transImg,strcat(outPath,'\',imageNamesA{imgCount+2,1}));
        
    end
    
    %% compare with other BTFs
    % load BTF from image pair 1
    load('imgBTF_viper67.mat');
    for i = 1 : 3
        matTestBTF = imgBTF(:,:,i);
        [scoreTest(i), outputImg] = useBTF(matTestBTF, imgTest1, imgTest2,i);
        %             fprintf('scoreTest = %d\n',scoreTest(i));
    end
%         fprintf('RscoreTest = %.2d\n',(max(scoreR(imgCount,:))-scoreTest(1))/scoreTest(1));
%         fprintf('GscoreTest = %.2d\n',(max(scoreG(imgCount,:))-scoreTest(2))/scoreTest(2));
%         fprintf('BscoreTest = %.2d\n',(max(scoreB(imgCount,:))-scoreTest(3))/scoreTest(3));
    
    %% print results
    finalScoreR = (max(scoreR(imgCount,:))-scoreTest(1))/scoreTest(1);
    finalScoreG = (max(scoreG(imgCount,:))-scoreTest(2))/scoreTest(2);
    finalScoreB = (max(scoreB(imgCount,:))-scoreTest(3))/scoreTest(3);
    fprintf('R improves %2.2d %%\n',100*mean(finalScoreR));
    fprintf('G improves %2.2d %%\n',100*mean(finalScoreG));
    fprintf('B improves %2.2d %%\n',100*mean(finalScoreB));
    
    
end