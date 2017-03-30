count = 0;
% Another accuracy test for fisher faces
tic
for i = 1:size(faces_test_easy,3)
    tf = FisherFaceComp(i,facemean, V, Q, projections);
    if tf == 1
        count = count+1;
    end
end
accuracy = count/i
toc