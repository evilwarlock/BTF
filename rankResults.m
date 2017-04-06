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