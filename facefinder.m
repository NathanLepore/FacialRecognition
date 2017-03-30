function [] = facefinder(test_image, testfaces,toptwenty, facemean, V)
clf
load face_detect.mat
face = testfaces(:,:,test_image);
test_face_reshape = reshape(face, 65536, 1);
test_face_norm = test_face_reshape - facemean';
test_face_norm = test_face_norm/256;
weighted = V' * test_face_norm;
compressed = weighted(1:40);

compressedcalc = compressed*ones(1,240);
difference = toptwenty - compressedcalc;
size(difference)
size(sum(difference))
D = sqrt(sum(difference.^2));
Min = min(D);
[~,Col] = find(D == Min)

imagesc(reshape(compressed'*V(:,1:40)', 256, 256))
colormap('gray')
figure, imagesc(face)
colormap('gray')
% name1 = names_train(1:10,Col)'
% colormap('gray')
% figure, imagesc(faces_train(:,:,Col))
% name2 = names_test_easy(1:10,test_image)'
% colormap('gray')
tf = strcmp(name1, name2);