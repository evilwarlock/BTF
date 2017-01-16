%%% Generating feature matrix %%%
%% this script is to generate feature matrix for a dataset
%% by concatenate RGB+HOG+LBP
pathNameA = uigetdir(pwd);

%Find all images and list them in a cell array
imageNamesA = dir(fullfile(pathNameA));
imageNamesA = {imageNamesA.name}';

% for imgCount = 1 : length(imageNamesA)-2
imgCount = 1;
    image1 = imread(strcat(pathNameA,'\',imageNamesA{imgCount+2,1}));
    % image1   = imread('001_b.bmp');
    grayImg1 = rgb2gray(image1);
    
    %Split into RGB Channels
    Red = image1(:,:,1);
    Green = image1(:,:,2);
    Blue = image1(:,:,3);
    
    %Get histValues for each channel
    [yRed, x] = imhist(Red);
    [yGreen, x] = imhist(Green);
    [yBlue, x] = imhist(Blue);
    redImg1  = yRed;
    greenImg1= yGreen;
    blueImg1 = yBlue;
    hogImg1  = extractHOGFeatures(image1);
    hogImg1  = hogImg1';
    lbpImg1  = extractLBPFeatures(grayImg1);
    lbpImg1  = lbpImg1';
    %% each column is a feature vec of an image
    vecFeature(:,imgCount) = vertcat(redImg1, greenImg1, blueImg1, hogImg1, lbpImg1);
% end
