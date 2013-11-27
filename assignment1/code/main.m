%% Main file to run the code for assignment 1
clear all; close all; clc;

imfolder = '../images/';
I1 = imread([imfolder 'Img001_diffuse.ppm']);
I1 = im2double(rgb2gray(I1));
I2 = imread([imfolder 'Img002_diffuse.ppm']);
I2 = im2double(rgb2gray(I2));

p11  = blobDetect(I1, 'log');
p21  = blobDetect(I2, 'log');
p12  = blobDetect(I1, 'dog');
p22  = blobDetect(I2, 'dog');
p13 = harrisDetect(I1, 0.88, 5, 0.1, 0.5e-5);
p23 = harrisDetect(I2, 0.88, 5, 0.1, 0.5e-5);

%% Display results
disp([num2str(size(p11,1)) ' blobs found (log)']);
disp([num2str(size(p12,1)) ' blobs found (dog)']);
disp([num2str(size(p13,1)) ' corners found (harris)']);
disp([num2str(size(p21,1)) ' blobs found (log)']);
disp([num2str(size(p22,1)) ' blobs found (dog)']);
disp([num2str(size(p23,1)) ' corners found (harris)']);

displayPoints(I1,p11,'LoG I1','.r');
displayPoints(I2,p21,'LoG I2','.r');
displayPoints(I1,p12,'DoG I1','.b');
displayPoints(I2,p22,'DoG I2','.b');
displayPoints(I1,p13,'Harris I1','.y');
displayPoints(I2,p23,'Harris I2','.y');

%filter = gaussFilter(12*0.88, 0.88*2);
%matches = salientMatch(imfilter(I1,filter,'conv','replicate'),...
%imfilter(I2,filter,'conv','replicate'), corners1, corners2);
matches1 = salientMatch(I1,I2,p11,p21);
matches2 = salientMatch(I1,I2,p12,p22);
matches3 = salientMatch(I1,I2,p13,p23);
%I12 = [I1, I2];
%figure();
%imshow(I12);
%hold on;
%plot(p13(:,2,p13(:,1),'.b');
%plot(p23(:,2)+size(I1,2),p23(:,1),'.r');
%for i = 1:size(matches,1)
%    match = matches(i,:);
%    plot([p13(match(1),2) (p23(match(2),2)+size(I1,2))],[p13(match(1),1) p23(match(2),1)],'-y');
%end

displayMatches(I1,I2,p11,p21, matches1);
displayMatches(I1,I2,p12,p22, matches2);
displayMatches(I1,I2,p13,p23, matches3);
