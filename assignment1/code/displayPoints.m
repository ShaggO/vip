function displayPoints(I, p, fTitle, pColor, save)
    if nargin < 5
        save = false;
    end
    fi = figure();
    imshow(I);
    hold on;
    title(fTitle);
    plot(p(:,2),p(:,1),pColor);

    if save
        set(fi, 'PaperPosition', [-0.45 -0.41 6 4.5]);
        set(fi, 'PaperSize', [5.12 3.85]);
        saveas(fi, save,'pdf');
    end
end
