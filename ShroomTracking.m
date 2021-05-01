img1 = imread('bw_frame35.jpeg');
img2 = imread('bw_frame83.jpeg');
img3 = imread('bw_frame131.jpeg');
img4 = imread('bw_frame179.jpeg');
img5 = imread('bw_frame227.jpeg');
img6 = imread('bw_frame275.jpeg');

[L1, n1] = bwlabel(imbinarize(img1),8);
figure;
coloredLabelsImage = label2rgb(L1, 'hsv', 'k', 'shuffle'); 
imshow(coloredLabelsImage);

[L2, n2] = bwlabel(imbinarize(img2),8);
figure;
coloredLabelsImage = label2rgb(L2, 'hsv', 'k', 'shuffle'); 
imshow(coloredLabelsImage);

[L3, n3] = bwlabel(imbinarize(img3),8);
figure;
coloredLabelsImage = label2rgb(L3, 'hsv', 'k', 'shuffle'); 
imshow(coloredLabelsImage);

[L4, n4] = bwlabel(imbinarize(img4),8);
figure;
coloredLabelsImage = label2rgb(L4, 'hsv', 'k', 'shuffle'); 
imshow(coloredLabelsImage);

[L5, n5] = bwlabel(imbinarize(img5),8);
figure;
coloredLabelsImage = label2rgb(L5, 'hsv', 'k', 'shuffle'); 
imshow(coloredLabelsImage);

[L6, n6] = bwlabel(imbinarize(img6),8);
figure;
coloredLabelsImage = label2rgb(L6, 'hsv', 'k', 'shuffle'); 
imshow(coloredLabelsImage);