function [pathTtl, matTtlCor] = getBTF( img1, img2 )
% getBTF Extracting BTF from paired images
%   Input: paired images
%   Output: BTF - extracted BTF cov matrix
%           pathTTl - cell contains pathCordsR, pathCordsG, pathCordsB 
%                     shortest path coordinates

%% Split into RGB Channels for img1
Red1 = img1(:,:,1);
Green1 = img1(:,:,2);
Blue1 = img1(:,:,3);
%% Get histValues for each channel
[yRed1, x1] = imhist(Red1);
[yGreen1, x1] = imhist(Green1);
[yBlue1, x1] = imhist(Blue1);
%% Plot them together in one plot
%figure();
%plot(x, yRed, 'Red', x, yGreen, 'Green', x, yBlue, 'Blue');

%% Split into RGB Channels for img2
Red2 = img2(:,:,1);
Green2 = img2(:,:,2);
Blue2 = img2(:,:,3);
%% Get histValues for each channel
[yRed2, x2] = imhist(Red2);
[yGreen2, x2] = imhist(Green2);
[yBlue2, x2] = imhist(Blue2);

matHist1 = [yRed1, yGreen1, yBlue1];
matHist2 = [yRed2, yGreen2, yBlue2];

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
end

