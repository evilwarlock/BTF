%%% test script for testing BTF by comparing color correlations
clc;clear all;
close all;
%% load calculated BTFs

load('codeBookViper_cumHist50.mat');     % rho = 0.05
% load('codeBookViper_cumHist50rho1.mat'); % rho = 0.1
% load codeBookR.mat;
% load codeBookG.mat;
% load codeBookB.mat;
% load('imgCBTF_VIPER.mat');

% use CBTF transfer 
if 0
    imgTest1 = imread('083_a.bmp');
    imgTest2 = imread('083_b.bmp');
%     scoreR = zeros(1,size(codeBookR,2));
%     scoreG = zeros(1,size(codeBookG,2));
%     scoreB = zeros(1,size(codeBookB,2));
    scoreTest = zeros(1,3);

    
    %% Red channel
  
                %     for i = 1 : size(codeBookR,2)
                matBTFR = imgBTF(:,:,1);
                [scoreR(1), outputImgR] = useBTF(matBTFR, imgTest1, imgTest2,1);
                %         fprintf('scoreR = %d\n',scoreR(i));
                transImg(:,:,1) = uint8(outputImgR(:,:,1));
                %     end
                
                %% Green channel
                %     for i = 1 : size(codeBookG,2)
                matBTFG = imgBTF(:,:,2);
                [scoreG(2), outputImgG] = useBTF(matBTFG, imgTest1, imgTest2,2);
                %         fprintf('scoreG = %d\n',scoreG(i));
                transImg(:,:,2) = uint8(outputImgG(:,:,2));
                
                %     end
                
                %% Blue channel
                %     for i = 1 : size(codeBookB,2)
                matBTFB = imgBTF(:,:,3);
                [scoreB(3), outputImgB] = useBTF(matBTFB, imgTest1, imgTest2,3);
                %         fprintf('scoreB = %d\n',scoreB(i));
                transImg(:,:,3) = uint8(outputImgB(:,:,3));
                %     end
                figure();
                imshow(uint8(transImg));

    % load BTF from image pair 1
    %     load('imgTestBTF1.mat');
    %     for i = 1 : 3
    %         matTestBTF = imgBTF(:,:,i);
    %         [scoreTest(i), outputImg] = useBTF(matTestBTF, imgTest1, imgTest2,i);
    %         fprintf('scoreTest = %d\n',scoreTest(i));
    %     end
    %     fprintf('RscoreTest = %.2d\n',(max(scoreR)-scoreTest(1))/scoreTest(1));
    %     fprintf('GscoreTest = %.2d\n',(max(scoreG)-scoreTest(2))/scoreTest(2));
    %     fprintf('BscoreTest = %.2d\n',(max(scoreB)-scoreTest(3))/scoreTest(3));
    %
end





% load one pair of test images
if 0
    imgTest1 = imread('069_a.bmp');
    imgTest2 = imread('069_b.bmp');
    scoreR = zeros(1,size(codeBookR,2));
    scoreG = zeros(1,size(codeBookG,2));
    scoreB = zeros(1,size(codeBookB,2));
    scoreTest = zeros(1,3);
    %% Red channel
    for i = 1:2
        for j = 1:2
            for k = 1:2
                %     for i = 1 : size(codeBookR,2)
                matBTFR = codeBookR{i}{1};
                [scoreR(i), outputImgR] = useBTF(matBTFR, imgTest1, imgTest2,1);
                %         fprintf('scoreR = %d\n',scoreR(i));
                transImg(:,:,1) = uint8(outputImgR(:,:,1));
                %     end
                
                %% Green channel
                %     for i = 1 : size(codeBookG,2)
                matBTFG = codeBookG{j}{1};
                [scoreG(i), outputImgG] = useBTF(matBTFG, imgTest1, imgTest2,2);
                %         fprintf('scoreG = %d\n',scoreG(i));
                transImg(:,:,2) = uint8(outputImgG(:,:,2));
                
                %     end
                
                %% Blue channel
                %     for i = 1 : size(codeBookB,2)
                matBTFB = codeBookB{k}{1};
                [scoreB(i), outputImgB] = useBTF(matBTFB, imgTest1, imgTest2,3);
                %         fprintf('scoreB = %d\n',scoreB(i));
                transImg(:,:,3) = uint8(outputImgB(:,:,3));
                %     end
                figure();
                imshow(uint8(transImg));
            end
        end
    end
    % load BTF from image pair 1
    %     load('imgTestBTF1.mat');
    %     for i = 1 : 3
    %         matTestBTF = imgBTF(:,:,i);
    %         [scoreTest(i), outputImg] = useBTF(matTestBTF, imgTest1, imgTest2,i);
    %         fprintf('scoreTest = %d\n',scoreTest(i));
    %     end
    %     fprintf('RscoreTest = %.2d\n',(max(scoreR)-scoreTest(1))/scoreTest(1));
    %     fprintf('GscoreTest = %.2d\n',(max(scoreG)-scoreTest(2))/scoreTest(2));
    %     fprintf('BscoreTest = %.2d\n',(max(scoreB)-scoreTest(3))/scoreTest(3));
    %
end

%% Test phase: load multiple pairs of images
% codes for multiple paired images
if 1
    
    % out put path Z:\LCS\Smart-Vision-Systems-Lab\Yu\BTF
    outPath = 'Z:\LCS\Smart-Vision-Systems-Lab\Yu\BTF\results';
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
    
    
    %     scoreR = zeros(length(imageNamesA)-2,size(codeBookR,2));
    %     scoreG = zeros(length(imageNamesA)-2,size(codeBookG,2));
    %     scoreB = zeros(length(imageNamesA)-2,size(codeBookB,2));
    scoreR = zeros(length(imageNamesA)-2,1); % for test purpose, delete afterwards
    scoreG = zeros(length(imageNamesA)-2,1);
    scoreB = zeros(length(imageNamesA)-2,1);
    for imgCount = 1 : length(imageNamesA)-2
        %     for imgCount = 1 : 30  % test code for only 3 pics
        fprintf('Processing Img %d \n',imgCount);
        
        
        imgTest1 = imread(strcat(pathNameA,'\',imageNamesA{imgCount+2,1}));
        imgTest2 = imread(strcat(pathNameB,'\',imageNamesB{imgCount+2,1}));
        
        for i = 1 : size(codeBookR,2)
            matBTFR = codeBookR{i}{1}; % change from i to 4 to test
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
            matBTFG = codeBookG{i}{1}; % change from i to 4 to test
            [scoreG(imgCount,i), outputImgG{i}] = useBTF(matBTFG, imgTest1, imgTest2,2);
            %             fprintf('scoreG = %d\n',scoreG(imgCount,i));
        end
        [maxG, indexG] = max(scoreG(imgCount,:));
        transImg(:,:,2) = uint8(outputImgG{indexG}(:,:,2));
        %         figure();
        %         imshow(transImg);
        
        %% Blue channel
        for i = 1 : size(codeBookB,2)
            matBTFB = codeBookB{i}{1}; % change from i to 4 to test
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
    %     load('imgBTF_viper67.mat');
    load('imgCBTF_CUHK02.mat');
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
    textR = ['R improves ',num2str(100*mean(finalScoreR)),'%'];
    textG = ['G improves ',num2str(100*mean(finalScoreG)),'%'];
    textB = ['B improves ',num2str(100*mean(finalScoreB)),'%'];
    %     fprintf('R improves %d %%\n',mean(finalScoreR));
    %     fprintf('G improves %d %%\n',mean(finalScoreG));
    %     fprintf('B improves %d %%\n',mean(finalScoreB));
    disp(textR);
    disp(textG);
    disp(textB);
    
    
end

%% rank triplets
disp('sorting the triplets..............')
for i = 1 : 321
    [ maxRR(i) , indexRR(i)] = max(scoreR(i,:));
    [ maxGG(i) , indexGG(i)] = max(scoreG(i,:));
    [ maxBB(i) , indexBB(i)] = max(scoreB(i,:));

end

clear cellResults;
matTriplets = [indexRR' indexGG' indexBB' ];

for i = 1 : 321
 f =  find(ismember(matTriplets,matTriplets(i,:),'rows'));
 cellResults{i,1} = f';
 cellResults{i,2} = length(f);
 cellResults{i,3} = matTriplets(i,:);
end
% disp('start printing new result........')
% for i = 1 : length(codeBookB)
%     codeBookB{i}(3);
% end

%% sort results by frequency
unsortedResults = sortrows(cellResults,2);
sortedResults = flip(unsortedResults);

%% remove duplicates
% tableResults = cell2table(sortedResults);
% C = unique(tableResults);
wd = sortedResults(:,2:3);
wdd = cell2table(wd);
[~,idx]=unique(wdd,'rows','stable');
newResults=wd(idx,:);

%% set stop threshold
sumOfFreq = 0;
stopThr = .75;
stopCnt = round(.75 * length(matTriplets));

for i = 1 : length(newResults)
    sumOfFreq = sumOfFreq + newResults{i};
    if(sumOfFreq > stopCnt)
        cellTrimed = newResults(1:i,:);
        break
    end
end