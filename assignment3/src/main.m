% Clear workspace
clear all;
close all;
clc;


% Load images
I = imread('coins.png');

if size(I,3) > 1
    % Convert to grayscale if multiple channels
    I = rgb2gray(I);
end

I = im2double(I);

% Get user input
but = 1;
xy = [];
if ~exist('points.mat','file')

    fi1 = figure();
    imshow(I);
    hold on;

    while true
        [x, y, but] = ginput(1);
        if but ~= 1
            if size(xy,1) < 2
                continue;
            else
                break;
            end
        end
        plot(x,y,'xr');
        xy(end+1,:) = [x, y];
    end
    close(fi1);
    save('points.mat','xy');
else
    load('points.mat');
end

% Append first point to close the circle
xy(end+1,:) = xy(1,:);

% Interpolation
ts = 1:0.1:size(xy,1);
xs = interp1(xy(:,1), ts,'linear');
ys = interp1(xy(:,2), ts,'linear');

% Perform snake iterations
% Gradient magnitude
alpha = 0.5;
beta  = 1;
gamma = 300;
tau   = 1;
sigma = 3;

snake(I, [xs(1:end-1)', ys(1:end-1)'], alpha, beta, gamma, tau, sigma,...
        'gradient magnitude', 2.1e-2,'images/coins_gradient', 60);
% LoG
alpha = 12.5;
beta  = 0.5;
gamma = 8000;
tau   = 0.1;
sigma = 3;
snake(I, [xs(1:end-1)', ys(1:end-1)'], alpha, beta, gamma, tau, sigma,...
        'log', 2.1e-2,'images/coins_log', 60);
