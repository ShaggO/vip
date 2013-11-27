function displayMatches(I1, I2, p1, p2, matches)
    I12 = [I1, I2];

    fi = figure();
    imshow(I12);
    hold on;
    plot(p1(:,2),p1(:,1),'.b');
    plot(p2(:,2)+size(I1,2),p2(:,1),'.r');

    for i = 1:size(matches,1)
        match = matches(i,:);
        plot([p1(match(1),2) (p2(match(2),2)+size(I1,2))],[p1(match(1),1) p2(match(2),1)],'-y');
    end
end
