%Alessandro De La Garza
%This code is focused on a smaller area. Code is tha same as
%FrameProcessing4.

close all; clear all;

rgb_img = imcrop(imread('frame399.jpg'), [440 270 299 299]);
figure('Name', 'Original RGB Image'); imshow(rgb_img);
title('Original RGB Image');
gray_img = rgb2gray(rgb_img);
figure('Name', 'Gray Image'); imshow(gray_img);
title('Gray Image');

LAB_im = rgb2lab(rgb_img);
L = LAB_im(:,:,1)/100;
L = adapthisteq(L, 'NumTiles', [5 5], 'ClipLimit', 0.5);
LAB_im(:,:,1) = L*100;
gray_img = rgb2gray(lab2rgb(LAB_im));
figure('Name', 'Adaptive Histogram Equalization');
imshow(gray_img);
figure; imhist(gray_img)

%Binarize Image
thresh = graythresh(gray_img);
bw_img = imbinarize(gray_img, thresh);
figure('Name', 'Binarized Image'); imshow(bw_img);

%Closing Small Objects
SE1 = strel('disk',2 ,0);
bw_img = imerode(bw_img,SE1);
figure('Name','Morphological Operations');
subplot(1,2,1); imshow(bw_img); title('Erode Noise');
SE2 = strel('disk',5,0);
bw_img = imopen(bw_img,SE2);
subplot(1,2,2); imshow(bw_img); title('Open Eroded Edges');

%Counting Objects
[L,n] = bwlabel(bw_img);
rgb = label2rgb(L);
stats1 = regionprops(bw_img, 'BoundingBox', 'Area');
figure('Name', 'Bounding boxes')
imshow(gray_img); hold on;
for k =1 : length(stats1)
    BB = stats1(k).BoundingBox;
    rectangle('Position', [BB(1), BB(2), BB(3), BB(4)], 'EdgeColor', 'g', 'LineWidth', 1);
end 

stats = regionprops(bw_img, 'Centroid', 'MajorAxisLength', 'MinorAxisLength', 'Orientation', 'Area');
t = linspace(0,2*pi,50);
figure('Name', 'Bounding Circles')
imshow(gray_img);
hold on
for k = 1:length(stats)
    a = (stats(k).MajorAxisLength/2)+5;
    b = a;%stats(k).MinorAxisLength/2;
    Xc = stats(k).Centroid(1);
    Yc = stats(k).Centroid(2);
    phi = deg2rad(-stats(k).Orientation);
    x = Xc + a*cos(t)*cos(phi) - b*sin(t)*sin(phi);
    y = Yc + a*cos(t)*sin(phi) + b*sin(t)*cos(phi);
    plot(x,y,'r','Linewidth',1)
end
hold off

figure
hold on
for k = 1:length(stats)
    scatter(k,stats(k).MajorAxisLength);
end
xlabel('Index')
ylabel('Circular Boundary Diameter')
hold off
