function [score] = useBTF(inputBTF, inputImg1, comImg2, channel)
%% Compensate image by using BTF
% since row direction is H1 and col direction is H2
% H2(n)=f(H1(m)) mapping from H1 to H2
% assuming given path
% Input : inputImg1 -- image to transfer by BTF 
%       : inputBTF  -- the BTF for each channel
%       : comImg2   -- the image to compare with transfered result
%       : channel   -- 1 is R, 2 is G, and 3 is B
% Output: correlaion score

%% generate look up table from BTFs
% clc;
% clear all;
% load('codeBookViper.mat');

% tempBTF = codeBookR{1}{1}; % for test
tempBTF = inputBTF;
pathCords = [0, 0];
for i = 1 : 256
    for j = 1 : 256
        if tempBTF(i,j) == 1
            pathCords = [pathCords ; [i j]];
        end
    end
end
path = pathCords(2:length(pathCords),:); % path(:,1) is value in h2
% path(:,2) is value in h1
% clear A,B;
% clear sums;
% newPath = flipud(path);
[binCnt, binIdx]=hist(path(:,2),unique(path(:,2)));
lut = zeros(256,1);
A   = path(:,1)';

% % A    = 2 3 4  5  6  7
% % B    = 1 8 10 11 12 13
% % sums = 2 42 21
%
B = cumsum(binCnt); % B provides end index for sum
% to do: reinitialize B to a 256 vector, and set 0 for all missing index

lut(1) = sum(A(1:B(1)));
for ii = 2 : length(lut)
    lut(ii) = sum(A((B(ii-1)+1):B(ii))); % B(ii-1)+1 is start index
    disp(ii);
end
lut = round(lut./binCnt')-1;

% lut index is value in h1
% lut value is value in h2
%% mapping by using sums

% imgTest = imread('010_a.bmp'); % for test
imgTest = inputImg1;
[rowT, colT, cT] = size(imgTest);
imgCali = zeros([rowT, colT, cT]);
for i = 1 : rowT
    for j = 1 : colT
        imgCali(i,j,channel) = lut(imgTest(i,j,channel));
    end
end
figure();
imshow(uint8(imgCali(:,:,1)));
% imgTest2= imread('010_b.bmp'); % for test
imgTest2 = comImg2;
score = corr2(imgCali(:,:,channel),imgTest2(:,:,channel));
% matRGBt = reshape(sums, [256, 3]);
% matRGBt(:,2) = matRGBt(:,2) - 256;
% matRGBt(:,3) = matRGBt(:,3) - 512;
% %% 1 8 10 11 12 13
% % B = cumsum(binCnt);
% %
% % sums(1) = cumsum(A(1:1));
% % sums(2) = cumsum(A(2:8))
%
end