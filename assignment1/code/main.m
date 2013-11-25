%% Main file to run the code for assignment 1
clear all; close all; clc;

imfolder = '../images/';
I1 = imread([imfolder 'Img001_diffuse.ppm']);
I1 = im2double(rgb2gray(I1));
I2 = imread([imfolder 'Img002_diffuse.ppm']);
I2 = im2double(rgb2gray(I2));

blobs11  = blobDetect(I1, 'log');
blobs21  = blobDetect(I2, 'log');
blobs12  = blobDetect(I1, 'dog');
blobs22  = blobDetect(I2, 'dog');
corners1 = harrisDetect(I1, 0.88*2, 2, 0.3, 1e-6);
corners2 = harrisDetect(I2, 0.88*2, 2, 0.3, 1e-6);

[y11,x11] = find(blobs11);
[y12,x12] = find(blobs12);
[y13,x13] = find(corners1);

[y21,x21] = find(blobs21);
[y22,x22] = find(blobs22);
[y23,x23] = find(corners2);

%% Display results
disp([num2str(length(y11)) ' blobs found (log)']);
disp([num2str(length(y12)) ' blobs found (dog)']);
disp([num2str(length(y13)) ' corners found (harris)']);
disp([num2str(length(y21)) ' blobs found (log)']);
disp([num2str(length(y22)) ' blobs found (dog)']);
disp([num2str(length(y23)) ' corners found (harris)']);

figure();
imshow(I1);
hold on;
plot(x11,y11,'.r');
figure();
imshow(I1);
hold on;
plot(x12,y12,'.b');
figure();
imshow(I1);
hold on;
plot(x13,y13,'.y');
figure();
imshow(I2);
hold on;
plot(x21,y21,'.r');
figure();
imshow(I2);
hold on;
plot(x22,y22,'.b');
figure();
imshow(I2);
hold on;
plot(x23,y23,'.y');

salientMatch(I1, I2, blobs11, blobs21)
