% Clear workspace
clear all;
close all;
clc;


% Load images
I = imread('images/cubic.jpg');
figure;
imshow(I);

if size(I,3) > 1
    % Convert to grayscale if multiple channels
    I = rgb2gray(I);
end

I = im2double(I);

% Get user input
but = 1;
xy = [];
if ~exist('points2.mat','file')

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
    save('points2.mat','xy');
else
    load('points2.mat');
end

% Append first point to close the circle
xy(end+1,:) = xy(1,:);

% Interpolation
ts = 1:0.1:size(xy,1);
xs = interp1(xy(:,1), ts,'linear');
ys = interp1(xy(:,2), ts,'linear');

% Perform snake iterations
% Gradient magnitude
alpha = 0.7;
beta  = 0.5;
gamma = 1500;
tau   = 0.4;
sigma = 2;

snake(I, [xs(1:end-1)', ys(1:end-1)'], alpha, beta, gamma, tau, sigma,...
        'gradient magnitude', 2e-3, 'images/cubic', 400);

% LoG
alpha = 0.2;
beta  = 0.2;
gamma = 3000;
tau   = 0.6;
sigma = 2;
snake(I, [xs(1:end-1)', ys(1:end-1)'], alpha, beta, gamma, tau, sigma,...
        'log', 2e-3, 'images/cubic_log', 400);
