load imgArrayBTF_VIPER_cumHist.mat
[s1,s2]= size(imgArray);

codeBookR = {};
codeBookG = {};
codeBookB = {};

rflag = [];
gflag = [];
bflag = [];

histThr=0.05;
trainPerc = 0.5;
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
    %hold on
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
   rflag(k) = 1;
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
            rflag(k) = t;
       end
   end
   if index ==0
       codeBookR{end+1}={btf,hist1,1};   
       rflag(k) = p2 + 1;
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
    %hold on
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
   gflag(k) = 1;
   
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
            gflag(k) = t;

       end
   end
   if index ==0
       codeBookG{end+1}={btf,hist1,1};  
       gflag(k) = p2 + 1;

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
    %hold on
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
   bflag(k) = 1;

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
            bflag(k) = t;
       end
   end
   if index ==0
       codeBookB{end+1}={btf,hist1,1};   
       bflag(k) = p2 + 1;
   end
end

end

%Calculate Percentage for r channel
[r1,r2]= size(codeBookR);

codeBookRSorted={};
sumOfVisit=0;
rToSort=zeros(1,r2);
for p=1:r2    
    sumOfVisit=sumOfVisit+cell2mat(codeBookR{p}(3));
    rToSort(p)=cell2mat(codeBookR{p}(3));
end
[sortedR,indexR]=sort(rToSort,'descend');
for p=1:r2    
    codeBookR{p}(3)={cell2mat(codeBookR{p}(3))/sumOfVisit};  
end
for k=1:r2    
    codeBookRSorted{k}(1)=codeBookR{indexR(k)}(1);
    codeBookRSorted{k}(2)=codeBookR{indexR(k)}(2);
    codeBookRSorted{k}(3)=codeBookR{indexR(k)}(3);    
end

%Calculate Percentage for G channel
[r1,r2]= size(codeBookG);
codeBookGSorted={};
sumOfVisit=0;
gToSort=zeros(1,r2);

for p=1:r2    
    sumOfVisit=sumOfVisit+cell2mat(codeBookG{p}(3));
    gToSort(p)=cell2mat(codeBookG{p}(3));
end
[sortedG,indexG]=sort(gToSort,'descend');
for p=1:r2    
    codeBookG{p}(3)={cell2mat(codeBookG{p}(3))/sumOfVisit};
end
for p=1:r2    
    codeBookGSorted{p}(1)=codeBookG{indexG(p)}(1);
    codeBookGSorted{p}(2)=codeBookG{indexG(p)}(2);
    codeBookGSorted{p}(3)=codeBookG{indexG(p)}(3);    
end

%Calculate Percentage for B channel an sort Arrays
[r1,r2] = size(codeBookB);
codeBookBSorted = {};
sumOfVisit=0;
bToSort=zeros(1,r2);

for p=1:r2    
    sumOfVisit=sumOfVisit+cell2mat(codeBookB{p}(3));
    bToSort(p)=cell2mat(codeBookB{p}(3));
end
[sortedB,indexB]=sort(bToSort,'descend');
for p=1:r2    
    codeBookB{p}(3)={cell2mat(codeBookB{p}(3))/sumOfVisit};
end
for p=1:r2    
    codeBookBSorted{p}(1)=codeBookB{indexB(p)}(1);
    codeBookBSorted{p}(2)=codeBookB{indexB(p)}(2);
    codeBookBSorted{p}(3)=codeBookB{indexB(p)}(3);    
end

% save('codeBookViper_cumHist50rho1.mat','codeBookR','codeBookG','codeBookB');
% save('codeBookViper_cumHist50.mat','codeBookR','codeBookG','codeBookB');
