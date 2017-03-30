count = 0;
% This is just a for loop to test accuracy. 
for i = 1:40
    names = facefinder(i, faces_train, faces_test_hard, toptwenty, facemean, V, names_test_easy, names_train);
    if names == 1
        count = count + 1;
    end
end
count
