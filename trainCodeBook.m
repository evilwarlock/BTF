load imgArrayBTF_VIPER_cumHist.mat
[s1,s2]= size(imgArray);

codeBookR = {};
codeBookG = {};
codeBookB = {};
histThr=0.05;
trainPerc = 0.66;
newSet=floor(s2*trainPerc);
%r-Image
for k =1:newSet
   
   rImg=imgArray{k}; 
   btf = rImg(:,:,1);
   [B,~]=bwboundaries(btf,'noholes');
   %Get the boundary that gives the longest boundary
   [maxSize, maxIdx] = max(cellfun('size', B, 1));
   
    hist1=zeros(8,1);
    %se = strel('disk',4);
 
 if numel(B) >=1
    boundary=B{maxIdx};
    %boundary=B{1};
    hold on
    %plot(boundary(:,2), boundary(:,1), 'g', 'LineWidth', 1);
    [cc] = chaincode(boundary);
    hist1(1) = numel(find(cc.code ==0));
    hist1(2) = numel(find(cc.code ==1));
    hist1(3) = numel(find(cc.code ==2));
    hist1(4) = numel(find(cc.code ==3));
    hist1(5) = numel(find(cc.code ==4));
    hist1(6) = numel(find(cc.code ==5));
    hist1(7) = numel(find(cc.code ==6));
    hist1(8) = numel(find(cc.code ==7));
    
    hist1=hist1/numel(cc.code);
 else
    hist1=zeros(8,1);
    disp('!sad!')
 end
    
    
if (k==1)
    
   CCH =hist1; 
   codeBookR{1}={btf,hist1,1};
   %codeBookR{1,1}=1;
else
   rImg=imgArray{k}; 
   btf = rImg(:,:,1);
   dist = 10;
   index = 0;
   [p1,p2] = size(codeBookR);
   for t=1:p2
       hist2=cell2mat(codeBookR{t}(2));
       if corrdist(hist1,hist2) < histThr
            index=t;
            codeBookR{t}(3)={cell2mat(codeBookR{t}(3))+1};
       end
   end
   if index ==0
       codeBookR{end+1}={btf,hist1,1};   
   end
end

end
k=0;

%g-Image
for k =1:newSet
   
   gImg=imgArray{k}; 
   btf = gImg(:,:,2);
   [B,~]=bwboundaries(btf,'noholes');
   %Get the boundary that gives the longest boundary
   [maxSize, maxIdx] = max(cellfun('size', B, 1));
   
    hist1=zeros(8,1);
    %se = strel('disk',4);
 
 if numel(B) >=1
    boundary=B{maxIdx};
    %boundary=B{1};
    hold on
    %plot(boundary(:,2), boundary(:,1), 'g', 'LineWidth', 1);
    [cc] = chaincode(boundary);
    hist1(1) = numel(find(cc.code ==0));
    hist1(2) = numel(find(cc.code ==1));
    hist1(3) = numel(find(cc.code ==2));
    hist1(4) = numel(find(cc.code ==3));
    hist1(5) = numel(find(cc.code ==4));
    hist1(6) = numel(find(cc.code ==5));
    hist1(7) = numel(find(cc.code ==6));
    hist1(8) = numel(find(cc.code ==7));
    
    hist1=hist1/numel(cc.code);
 else
    hist1=zeros(8,1);
    disp('!sad!')
 end
    
    
if (k==1)
    
   CCH =hist1; 
   codeBookG{1}={btf,hist1,1};

else
   gImg=imgArray{k}; 
   btf = gImg(:,:,2);
   dist = 10;
   index = 0;
   [p1,p2] = size(codeBookG);
   for t=1:p2
       hist2=cell2mat(codeBookG{t}(2));
       if corrdist(hist1,hist2) < histThr
            index=t;
            codeBookG{t}(3)={cell2mat(codeBookG{t}(3))+1};
       end
   end
   if index ==0
       codeBookG{end+1}={btf,hist1,1};   
   end
end

end
k=0;


%b-Image
for k =1:newSet
   
   bImg=imgArray{k}; 
   btf = bImg(:,:,3);
   [B,~]=bwboundaries(btf,'noholes');
   %Get the boundary that gives the longest boundary
   [maxSize, maxIdx] = max(cellfun('size', B, 1));
   
    hist1=zeros(8,1);
    %se = strel('disk',4);
 
 if numel(B) >= 1
    boundary=B{maxIdx};
    %boundary=B{1};
    hold on
    %plot(boundary(:,2), boundary(:,1), 'g', 'LineWidth', 1);
    [cc] = chaincode(boundary);
    hist1(1) = numel(find(cc.code ==0));
    hist1(2) = numel(find(cc.code ==1));
    hist1(3) = numel(find(cc.code ==2));
    hist1(4) = numel(find(cc.code ==3));
    hist1(5) = numel(find(cc.code ==4));
    hist1(6) = numel(find(cc.code ==5));
    hist1(7) = numel(find(cc.code ==6));
    hist1(8) = numel(find(cc.code ==7));
    
    hist1=hist1/numel(cc.code);
 else
    hist1=zeros(8,1);
    disp('!sad!')
 end
    
    
if (k==1)
    
   CCH =hist1; 
   codeBookB{1}={btf,hist1,1};

else
   bImg=imgArray{k}; 
   btf = bImg(:,:,3);
   dist = 10;
   index = 0;
   [p1,p2] = size(codeBookB);
   for t=1:p2
       hist2=cell2mat(codeBookB{t}(2));
       if corrdist(hist1,hist2) < histThr
            index=t;
            codeBookB{t}(3)={cell2mat(codeBookB{t}(3))+1};
       end
   end
   if index ==0
       codeBookB{end+1}={btf,hist1,1};   
   end
end

end

%Calculate Percentage for r channel
[r1,r2]= size(codeBookR);
sumOfVisit=0;
for p=1:r2    
    sumOfVisit=sumOfVisit+cell2mat(codeBookR{p}(3));
end
for p=1:r2    
    codeBookR{p}(3)={cell2mat(codeBookR{p}(3))/sumOfVisit};
end

%Calculate Percentage for G channel
[r1,r2]= size(codeBookG);
sumOfVisit=0;
for p=1:r2    
    sumOfVisit=sumOfVisit+cell2mat(codeBookG{p}(3));
end
for p=1:r2    
    codeBookG{p}(3)={cell2mat(codeBookG{p}(3))/sumOfVisit};
end

%Calculate Percentage for B channel
[r1,r2]= size(codeBookB);
sumOfVisit=0;
for p=1:r2    
    sumOfVisit=sumOfVisit+cell2mat(codeBookB{p}(3));
end
for p=1:r2    
    codeBookB{p}(3)={cell2mat(codeBookB{p}(3))/sumOfVisit};
end
