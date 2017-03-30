function [projections,Q] = FishFaceCDim(facemean, V)
%facemean is the mean face, V is the set of eigenvectors found in SVDCalc
%Projections are the means of each class projected onto the new eigenspace.
%Q is the set of new eigenvectors. 
tic
load face_detect_demo.mat
FaceData = [];
%projects each training image onto the eigenface space. 
for i = 1:240
Tstacked = fishfacefinder(i,faces_train, facemean, V);
FaceData(i,:) = Tstacked;
end
FaceData = FaceData';
%finds the mean of every class. 
Faces = [];
means = [];
for i = 6:6:240
    class = FaceData(:,i-5:i);
    Cmean = mean(class')';
    means(:,i-5*(i/6)) = Cmean;
end
%Mu is the mean of the means
Mu = mean(means');
S = 0;
%This finds Sw, or the within class scatter matrix. 
for i = 1:40
    class = FaceData(:,i:i+5);
    Adj = class-means(:,i)*ones(1,6);
    S1 = S;
    S= cov(Adj');
    Sw = S1 + S;
end
Ni = size(class,1);
Sbi = 0;
%Finds the between class scatter matrix. 
for i = 1:40
    Sb1 = Sbi;
    Sbi = Ni.*(means(:,i) - Mu')'*(means(:,i)-Mu');
    Sb = Sb1 + Sbi;
end
%Calculates the eigenvectors. 
invSw_Sb = inv(Sw)*Sb;
[Q,~] = eig(invSw_Sb);
projections = Q'*means;
toc


    