%% Compensate image by using BTF
% since row direction is H1 and col direction is H2
% H2(n)=f(H1(m) mapping from H1 to H2
% assuming given path

% clear A,B;
% clear sums;
newPath = flipud(path);
[binCnt, binIdx]=hist(path(:,2),unique(path(:,2)));
sums = zeros(1,768);
A = newPath(:,1)';
% A    = 2 3 4  5  6  7
% B    = 1 8 10 11 12 13
% sums = 2 42 21

B = cumsum(binCnt); % B provides end index for sum
sums(1) = sum(A(1:B(1)));
for ii = 2 : 768
    sums(ii) = sum(A((B(ii-1)+1):B(ii))); % B(ii-1)+1 is start index
end
sums = round(sums./binCnt)-1;
matRGBt = reshape(sums, [256, 3]);
matRGBt(:,2) = matRGBt(:,2) - 256;
matRGBt(:,3) = matRGBt(:,3) - 512;
%% 1 8 10 11 12 13
% B = cumsum(binCnt);
%
% sums(1) = cumsum(A(1:1));
% sums(2) = cumsum(A(2:8))

%% mapping by using sums
imgTest = imread('010_a.bmp');
imgCali = zeros(size(imgTest));
[rowTest,colTest,cTest] = size(imgTest);

for i = 1 : rowTest
    for j = 1 : colTest
        for k = 1 : cTest
            imgCali(i,j,k) = matRGBt(imgTest(i,j,k)+1,k);
        end
    end
end