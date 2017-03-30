function [compressed] = fishfacefinder(test_image, trainfaces,facemean, V)
% This is just a function to project the train faces onto the eigenface
% space
clf
load face_detect.mat
face = trainfaces(:,:,test_image);
test_face_reshape = reshape(face, 65536, 1);
test_face_norm = test_face_reshape - facemean';
test_face_norm = test_face_norm/256;
weighted = V' * test_face_norm;
compressed = weighted(1:40);
end


