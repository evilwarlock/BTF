clc;
clear all;
close all;

%% demo for extract 1 BTF from paired image

if 0
    %% plot 4 curves in one figure
    figure();
    for cc = 0 : 4
        imgaName = strcat('00',num2str(cc),'_a_black.jpg');
        imgbName = strcat('00',num2str(cc),'_b_black.jpg');
        % imga = imread('003_a_black.jpg');
        % imgb = imread('003_b_black.jpg');
        imga = imread(imgaName);
        imgb = imread(imgbName);
        
        % extract BTF
        [path,BTF0] = getBTF( imga, imgb);
        % visualize image
        imgBTF = zeros(size(BTF0));
        for i = 1 : length(path)
            imgBTF(path(i,1),path(i,2)) = 1;
        end
        
        subplot(5,1,cc+1), imshow(imgBTF);
    end
end

if 0 %% plot individual BTF model function curve
    imga = imread('001_a.bmp');
    imgb = imread('001_b.bmp');
    
    % extract BTF
    [path,BTF0] = getBTF(imga, imgb);
    % visualize image
    imgBTF = zeros(size(BTF0));
    for i = 1 : length(path)
        imgBTF(path(i,1),path(i,2)) = 1;
    end
    
    figure();
    imshow(imgBTF);
end

%% calculate offset from diagonal axis
% vertSum = sum(imgBTF,1);
% orizSum = sum(imgBTF,2);
% orizSum = orizSum';
%
% featureVertDist = vertSum/norm(vertSum,2);
% featureOrizDist = orizSum/norm(orizSum,2);

%% codes for multiple paired images
if 0
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
    
    for imgCount = 1 : length(imageNamesA)-2
        imga = imread(strcat(pathNameA,'\',imageNamesA{imgCount+2,1}));
        imgb = imread(strcat(pathNameB,'\',imageNamesB{imgCount+2,1}));
        % extract BTF
        [path,BTF0] = getBTF( imga, imgb);
        % visualize image
        imgBTF = zeros(size(BTF0));
        for i = 1 : length(path)
            imgBTF(path(i,1),path(i,2)) = 1;
        end
        % figure();
        % imshow(imgBTF);
        
        if imgCount == 1
            imgArray = imgBTF;
        else
            imgArray = cat(3,imgArray,imgBTF);
        end
        % vertSum = sum(imgBTF,1);
        % orizSum = sum(imgBTF,2);
        % orizSum = orizSum';
        %
        % featureVertDist = vertSum/norm(vertSum,2);
        % featureOrizDist = orizSum/norm(orizSum,2);
        %
        
        
        
    end
    
    save ('imgArrayBTF.mat', 'imgArray');
    
end

%% Compensate image by using BTF
% from H2 to H1, looping down through 2nd column
% find cords in 1st column
% assuming given path
clear sums;
newPath = flipud(path);
[binCnt, binIdx]=hist(path(:,2),unique(path(:,2)));
sums = zeros(768,1);
for ii = 1 : 10
    % for ii = 1 : length(newPath)
    if newPath(ii+1,2) == newPath(ii,2)
        if sums(newPath(ii,2)) == 0
            sums(newPath(ii,2)) = newPath(ii,1);
        else
            sums(newPath(ii,2)) = sums(newPath(ii,2)) + newPath(ii+1,1);
        end
    else
        sums(newPath(ii,2)) = newPath(ii,1);
    end
    
end




















% pcolor(imgBTF0);
% colormap(gray);
% h = colorbar;
% % ylabel(h,'shortest path');
% axis ij
% axis square











% image = img0a;
% %figure();
% %imshow(image);
% %% Split into RGB Channels
% Red = image(:,:,1);
% Green = image(:,:,2);
% Blue = image(:,:,3);
% %% Get histValues for each channel
% [yRed, x] = imhist(Red);
% [yGreen, x] = imhist(Green);
% [yBlue, x] = imhist(Blue);
% %% Plot them together in one plot
% %figure();
% %plot(x, yRed, 'Red', x, yGreen, 'Green', x, yBlue, 'Blue');
%
% h0a = cat(1, yRed, yGreen, yBlue);
%
% image = img0b;
% %figure();
% %imshow(image);
% %% Split into RGB Channels
% Red = image(:,:,1);
% Green = image(:,:,2);
% Blue = image(:,:,3);
% %% Get histValues for each channel
% [yRed, x] = imhist(Red);
% [yGreen, x] = imhist(Green);
% [yBlue, x] = imhist(Blue);
% %% Plot them together in one plot
% %figure();
% %plot(x, yRed, 'Red', x, yGreen, 'Green', x, yBlue, 'Blue');
%
% h0b = cat(1, yRed, yGreen, yBlue);
% matH0a = repmat(h0a, 1, size(h0b));
% matH0b = repmat(h0b', size(h0a), 1);
% matCorrelation = abs(matH0a-matH0b);
