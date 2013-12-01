%% Main file to run the code for assignment 1
% clear the workspace
clear all; close all; clc;

% Set default image folder for saving images to
imfolder = '../images/';

%% Load images
I1 = imread([imfolder 'Img001_diffuse_smallgray.png']);
%I1 = im2double(rgb2gray(I1));
I1 = im2double(I1);
I2 = imread([imfolder 'Img002_diffuse_smallgray.png']);
%I2 = im2double(rgb2gray(I2));
I2 = im2double(I2);
I3 = imread([imfolder 'Img009_diffuse_smallgray.png']);
I3 = im2double(I3);

%% Detect blobs
p11  = blobDetect(I1, 'log', 0.88*6, 0.008, 1, 50);
p21  = blobDetect(I2, 'log', 0.88*6, 0.008, 1, 50);
p31  = blobDetect(I3, 'log', 0.88*6, 0.008, 1, 50);
p12  = blobDetect(I1, 'dog', 2, 0.15, 8, 50);
p22  = blobDetect(I2, 'dog', 2, 0.15, 8, 50);
p32  = blobDetect(I3, 'dog', 2, 0.15, 8, 50);

%% Detect corners
p13 = harrisDetect(I1, 0.88, 5, 0.1, 0.5e-5, 50);
p23 = harrisDetect(I2, 0.88, 5, 0.1, 0.5e-5, 50);
p33 = harrisDetect(I3, 0.88, 5, 0.1, 0.5e-5, 50);

%% Display interest point results
disp('I1 results:');
disp([num2str(size(p11,1)) ' blobs found (log)']);
disp([num2str(size(p12,1)) ' blobs found (dog)']);
disp([num2str(size(p13,1)) ' corners found (harris)']);
disp('I2 results:');
disp([num2str(size(p21,1)) ' blobs found (log)']);
disp([num2str(size(p22,1)) ' blobs found (dog)']);
disp([num2str(size(p23,1)) ' corners found (harris)']);
disp('I3 results:');
disp([num2str(size(p31,1)) ' blobs found (log)']);
disp([num2str(size(p32,1)) ' blobs found (dog)']);
disp([num2str(size(p33,1)) ' corners found (harris)']);

% Show individual images
%displayPoints(I1,p11,'LoG I1','.r', [imfolder 'i1_log']);
%displayPoints(I2,p21,'LoG I2','.r', [imfolder 'i2_log']);
%displayPoints(I3,p31,'LoG I3','.r', [imfolder 'i3_log']);
%displayPoints(I1,p12,'DoG I1','.b', [imfolder 'i1_dog']);
%displayPoints(I2,p22,'DoG I2','.b', [imfolder 'i2_dog']);
%displayPoints(I3,p32,'DoG I3','.b', [imfolder 'i3_dog']);
%displayPoints(I1,p13,'Harris I1','.y', [imfolder 'i1_harris']);
%displayPoints(I2,p23,'Harris I2','.y', [imfolder 'i2_harris']);
%displayPoints(I3,p33,'Harris I3','.y', [imfolder 'i3_harris']);
displayAllPoints(I1,{p11,p12,p13}, {'LoG','DoG','Harris'}, {'xr','og','sy'}, [imfolder 'i1_points']);
displayAllPoints(I2,{p21,p22,p23}, {'LoG','DoG','Harris'}, {'xr','og','sy'}, [imfolder 'i2_points']);
displayAllPoints(I3,{p31,p32,p33}, {'LoG','DoG','Harris'}, {'xr','og','sy'}, [imfolder 'i3_points']);

%% Compute matching interest points
% I1 -> I2
matches1 = salientMatch(I1,I2,p11,p21, 0.8, [11 11]);
matches2 = salientMatch(I1,I2,p12,p22, 0.8, [11 11]);
matches3 = salientMatch(I1,I2,p13,p23, 0.8, [11 11]);

% I1 -> I3
matches4 = salientMatch(I1,I3,p11,p31, 0.8, [11 11]);
matches5 = salientMatch(I1,I3,p12,p32, 0.8, [11 11]);
matches6 = salientMatch(I1,I3,p13,p33, 0.8, [11 11]);

%% Display matching points
% I1 -> I2
displayMatches(I1,I2,p11,p21, matches1, 'LoG I1, I2', [imfolder 'match_i1_i2_log']);
displayMatches(I1,I2,p12,p22, matches2, 'DoG I1, I2', [imfolder 'match_i1_i2_dog']);
displayMatches(I1,I2,p13,p23, matches3, 'Harris I1, I2', [imfolder 'match_i1_i2_harris']);

% I1 -> I3
displayMatches(I1,I3,p11,p31, matches4, 'LoG I1, I3', [imfolder 'match_i1_i3_log']);
displayMatches(I1,I3,p12,p32, matches5, 'DoG I1, I3', [imfolder 'match_i1_i3_dog']);
displayMatches(I1,I3,p13,p33, matches6, 'Harris I1, I3', [imfolder 'match_i1_i3_harris']);
