function [topforty,V,facemean, loadings] = SVDCalc(faces)
%Faces is the training data set, topforty is the top 40 eigenvectors. 
%V is the set of eigenvectors returned by SVD, facemean is the mean face, 
%and loadings are the projected training images onto the eigenspace. 
FaceData = [];
%Reshaping faces into column vectors
for i = 1:240
T = faces(:, :, i);
Tstacked = reshape(T, 65536, 1);
FaceData(:,i) = Tstacked;
end
%Finding the mean face and subtracting it from
%the faces matrix.
FaceData = FaceData';
facemean = mean(FaceData);
meanmatrix = ones(240, 1)*facemean;
FaceDataMean = FaceData - meanmatrix;
%Normalizing by dividing by the number of entries
MeanFaceNorm = FaceDataMean/240;
%Singular value decomposition to get 240 eigenvectors of length 65536
[~,~,V] = svd(MeanFaceNorm, 'econ');
%projecting our normalized data onto the eigenvectors
loadings = V'*MeanFaceNorm';
%choosing the top forty eigenvectors to use. 
topforty = loadings(1:40,:);
end
