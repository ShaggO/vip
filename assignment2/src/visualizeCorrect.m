function visualizeCorrect(train, test)
    for i = 1:size(test,1)
        if test{i}.cat == train{test{i}.match}.cat
            I = imread(test{i}.imgPath);
            I2 = imread(train{test{i}.match}.imgPath);
            figure();
            subplot(2,1,1);
            imshow(I);
            hold on;
            title(test{i}.imgPath);
            subplot(2,1,2);
            imshow(I2);
            title(train{test{i}.match}.imgPath);
        end
    end
end
