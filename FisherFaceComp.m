function [tf] = FisherFaceComp(testimage, facemean, V, Q, projections)
%This is a function of tf which stands for true or false. Returns a 1 or a
%0
load face_detect_demo.mat
%loading in the test face
face = faces_test_hard(:,:,testimage);
test_face_reshape = reshape(face, 65536, 1);
test_face_norm = test_face_reshape - facemean';
test_face_norm = test_face_norm/240;
%projecting our previous eigenvectors onto our new eigenspace 
space = V(:,1:40) * Q;
%projecting our test face onto the new eigenspace
testproj = space'*test_face_norm;
%This is our solution for subtracting the projected test image from the
%mean of every training class
compressedcalc = testproj*ones(1,40);
difference = projections - compressedcalc;
%nearest neighbor
D = sqrt(sum(difference.^2));
Min = min(D);
[~,Col] = find(D == Min);

%Uncomment the code below to display the images
%otherwise, compares the names and returns a 1 of they match or a 0 if they
%don't. 

% imagesc(reshape(testproj'*space',256,256))
% colormap('gray')
% figure, imagesc(face)
% colormap('gray')
name1 = names_train(1:10,(Col*6)-2)';

% figure, imagesc(faces_train(:,:,(Col*6)-2))
name2 = names_test_easy(1:10,testimage)';
% colormap('gray')
tf = strcmp(name1, name2);