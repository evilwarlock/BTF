function [pathTtl, matTtlCor] = getCBTF( img1, img2, isFirstFlag, totalImgCount)
% getCBTF Extracting MBTF from paired images
%   Input : paired images
%         : isFirstFlag   - check if it is the first image pair
%         : totalImgCount - total number of image pairs
%   Output: CBTF          - extracted MBTF
%           pathTtl       - cell contains pathCordsR, pathCordsG, pathCordsB
%                           shortest path coordinates
% BTFtype = 'CBTF';

%% Split into RGB Channels for img1
Red1 = img1(:,:,1);
Green1 = img1(:,:,2);
Blue1 = img1(:,:,3);

%% Split into RGB Channels for img2
Red2 = img2(:,:,1);
Green2 = img2(:,:,2);
Blue2 = img2(:,:,3);

%% Plot them together in one plot
%figure();
%plot(x, yRed, 'Red', x, yGreen, 'Green', x, yBlue, 'Blue');

%% Get histValues for each channel
[yRed1, x1] = imhist(Red1);
[yGreen1, x1] = imhist(Green1);
[yBlue1, x1] = imhist(Blue1);

%% Get histValues for each channel
[yRed2, x2] = imhist(Red2);
[yGreen2, x2] = imhist(Green2);
[yBlue2, x2] = imhist(Blue2);

%% Calculate cumulative hist
cumHistRed1   = cumsum(yRed1);
cumHistGreen1 = cumsum(yGreen1);
cumHistBlue1  = cumsum(yBlue1);

cumHistRed2   = cumsum(yRed2);
cumHistGreen2 = cumsum(yGreen2);
cumHistBlue2  = cumsum(yBlue2);

if isFirstFlag == 1
    currentHist = horzcat(cumHistRed1, cumHistGreen1, cumHistBlue1, cumHistRed2, cumHistGreen2, cumHistBlue2);
    save ('currentHist.mat', 'currentHist');
else
    load('currentHist.mat');
    currentHist(:,1) = currentHist(:,1) + cumHistRed1;
    currentHist(:,2) = currentHist(:,2) + cumHistGreen1;
    currentHist(:,3) = currentHist(:,3) + cumHistBlue1;
    currentHist(:,4) = currentHist(:,4) + cumHistRed2;
    currentHist(:,5) = currentHist(:,5) + cumHistGreen2;
    currentHist(:,6) = currentHist(:,6) + cumHistBlue2;
    save ('currentHist.mat', 'currentHist');
end



%% Normalize histogram using total pixel numbers and total training images
[row, col, ch] = size(img1);
ttlPixel = row*col;
[row2, col2, ch2] = size(img2);
ttlPixel2 = row2*col2;
%% Normalized cumulative hist
cumHistRed1   = currentHist(:,1);
cumHistGreen1 = currentHist(:,2);
cumHistBlue1  = currentHist(:,3);
cumHistRed2   = currentHist(:,4);
cumHistGreen2 = currentHist(:,5);
cumHistBlue2  = currentHist(:,6);

yRed1   = cumHistRed1./ttlPixel./totalImgCount;
yGreen1 = cumHistGreen1./ttlPixel./totalImgCount;
yBlue1  = cumHistBlue1./ttlPixel./totalImgCount;

yRed2   = cumHistRed2./ttlPixel2./totalImgCount;
yGreen2 = cumHistGreen2./ttlPixel2./totalImgCount;
yBlue2  = cumHistBlue2./ttlPixel2./totalImgCount;

matHist1 = [yRed1, yGreen1, yBlue1];
matHist2 = [yRed2, yGreen2, yBlue2];
if isFirstFlag == totalImgCount
    save ('matHist1.mat', 'matHist1');
    save ('matHist2.mat', 'matHist2');
end


%% Save as current Hist
%     currentHist = horzcat(matHist1,matHist2)

%     save currentHist.mat currentHist;

matTtlCor = zeros(256,256,3);

%% Calculate correlation mat
for ch = 1 : 3
    h1 = matHist1(:,ch);
    h2 = matHist2(:,ch);
    matH1 = repmat(h1, [1, size(h2)]); % row direction is bin of h1
    matH2 = repmat(h2', [size(h1), 1]);% col direction is bin of h2
    
    matTtlCor(:,:,ch) = abs(matH1-matH2); % correlation matrix
    
    matCor = matTtlCor(:,:,ch);
    %% Calculate minimum cost path
    
    [row , col] = size(matCor);
    [m , n] = size(matCor);
    tc = zeros(size(matCor));
    tc(1,1) = matCor(1,1);
    % Initialize first column of total cost(tc) array */
    for i = 1 : m-1
        tc(i+1,1) = tc(i,1)+ matCor(i+1,1);
    end
    
    % Initialize first row of tc array */
    for j = 1 : n-1
        tc(1,j+1) = tc(1,j) + matCor(1,j+1);
    end
    
    % Construct rest of the tc array */
    for i = 2 : m
        for j = 2 : n
            tc(i,j) = min([tc(i-1,j-1),...
                tc(i-1,j),...
                tc(i,j-1)])...
                + matCor(i,j);
        end
    end
    
    %  tc(m,n) % total cost
    %  tc % total cost matrix
    pathCords = [row,col];
    while((row-1)&&(col-1)~=0)
        [~, index] = min([tc(row-1,col-1),...
            tc(row-1,col),...
            tc(row,col-1)]);
        switch index
            case 1
                row = row - 1;
                col = col - 1;
            case 2
                row = row - 1;
            case 3
                col = col - 1;
        end
        pathCords = vertcat(pathCords,[row,col]);
    end
    if ch == 1
        pathCordsR = pathCords;
    elseif ch == 2
        pathCordsG = pathCords;
    elseif ch == 3
        pathCordsB = pathCords;
    end
end
pathTtl = {pathCordsR,pathCordsG,pathCordsB};
% end
end

