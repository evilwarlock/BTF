function [averagedBTF] = avgBTF(BTF1 , BTF2)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%% this function is to average the BTF function
%%% input : 2 BTFs
%%% output: averaged BTF
%% plot 2 BTFs
% figure();
% spy(codeBookR{2}{1});
% hold on;
% spy(codeBookR{3}{1});

% avg = (codeBookR{2}{1}+codeBookR{3}{1})/2;
% hold off;
% figure();
% spy(avg);

%% extract coordinates
% [x1 , y1] = find(codeBookR{2}{1}==1);
% [x2 , y2] = find(codeBookR{3}{1}==1);

%% interpolation 1
% if length(x1) > length(x2)
%     xi = x1;
%     y2i = interp1(x2(:), y2(:), xi(:)); % Interploate Or Extrapolate To New ‘x’ Values
% else
%     xi = x2;
%     y1i = interp1(x1(:), y1(:), xi(:)); % Interploate Or Extrapolate To New ‘x’ Values
% end
% y_mean = mean([y1i y2i], 2);
%
% figure();
% plot(x1,y1,'ob');
% hold on;
% plot(x2,y2,'og');
% % plot
% plot(xi, y_mean, '-r', 'LineWidth',2);

%% interpolation 2

[r , c] = size(BTF1);
avg = zeros(r , c);
% calculate avg BTF

for i = 1 : c
    if nnz(BTF1(:,i)) && nnz(BTF2(:,i))
        j = (sum(find(BTF1(:,i)==1))/nnz(BTF1(:,i)) + sum(find(BTF2(:,i)==1))/nnz(BTF2(:,i)))/2;
        avg(round(j),i) = 1;
    elseif nnz(BTF1(:,i)) || nnz(BTF2(:,i))
        if nnz(BTF1(:,i)) > nnz(BTF2(:,i))
            j = sum(find(BTF1(:,i)==1))/nnz(BTF1(:,i));
            avg(round(j),i) = 1;
        else
            j = sum(find(BTF1(:,i)==1))/nnz(BTF2(:,i));
            avg(round(j),i) = 1;
        end
    end
end

%%% plot results
figure();
spy(BTF1);
hold on;
spy(BTF2);
spy(avg);
hold off;
figure();
spy(BTF1);
hold on;
spy(BTF2);
end
