im_rgb = imread('example1.jpg');


figure(1); imshow(im_rgb); title("Original Image");

im_lab = rgb2lab(im_rgb);
figure(2); imshow(im_lab); title("LAB Color Space Image")

L = im_lab(:,:,1)/100;
L = adapthisteq(L, 'NumTiles', [20 20], 'ClipLimit', 0.008);
im_lab(:,:,1) = L*100;

eq_im = lab2rgb(im_lab);
figure(3);
subplot(2,2,1)
imshow(im_rgb); title("Original Image");
subplot(2,2,2)
imshow(eq_im); title("Equalized Image");
subplot(2,2,3); imhist(im_rgb);
subplot(2,2,4); imhist(eq_im);
gray_im = rgb2gray(eq_im);
figure(4); imshow(gray_im); title("Grayscale Image");

sharpCoeff = [0 0 0; 0 1 0; 0 0 0]-fspecial('laplacian', 0.2);

f = @() imfilter(gray_im,sharpCoeff, 'symmetric');

imgSharp = imfilter(gray_im,sharpCoeff,'symmetric');
figure(7)
imshowpair(gray_im,imgSharp,'montage')
title('Blurred Image and Sharpened Image')

bw_edges = edge(imgSharp, 'sobel',0.09);
figure(5); imshow(imfill(bw_edges, 'holes')); title("Edge Detection");

radii = 40:1:300;
h = circle_hough(bw_edges, radii, 'same', 'normalise');

figure(6)
title("Identified Mushrooms Attempt #1")
peaks = circle_houghpeaks(h, radii, 'nhoodxy', 15, 'nhoodr', 21, 'npeaks', 15);
imshow(gray_im);
hold on;
for peak = peaks
    [x, y] = circlepoints(peak(3));
    plot(x+peak(1), y+peak(2), 'g-');
end
hold off