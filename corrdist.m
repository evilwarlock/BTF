function [ DRS ] = corrdist( A , B)
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here
    %N = length(A);    
    Am = mean(A);
    Bm = mean(B);
    varA = var(A,1);
    varB = var(B,1);
    varSample = 1e-10;
    
    if (varA < 0.001 || varB < 0.001) 
        DRS = 1 - dot(A-Am,B-Bm)/(varSample);
    else
        DRS = 1 - dot(A-Am,B-Bm)/(sqrt(dot(A-Am,A-Am))*sqrt(dot(B-Bm,B-Bm)));
    end
end

