function displayMatches(I1, I2, p1, p2, matches, fTitle, save)
% Display matches matching points from p1, p2 in images I1, I2
    if nargin < 7
        save = false;
    end

    % Plot images concatenated and points p1, p2
    fi = figure();
    imshow([I1, I2]);
    hold on;
    title(fTitle);
    plot(p1(:,2),p1(:,1),'.r');
    plot(p2(:,2)+size(I1,2),p2(:,1),'.r');

    % Plot matching points
    for i = 1:size(matches,1)
        match = matches(i,:);
        plot([p1(match(1),2) (p2(match(2),2)+size(I1,2))],[p1(match(1),1) p2(match(2),1)],'-y');
    end

    % Save image to specified output
    if save
        set(fi, 'PaperPosition', [-0.64 -0.31 12 4.5]);
        set(fi, 'PaperSize', [10.74 4.05]);
        saveas(fi, save, 'pdf');
    end
end
