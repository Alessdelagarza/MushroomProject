close all;
load('CircleData.mat');
iteration = 1;


for img = 1:1960
    
    bw_img = uint8(255*zeros(400,400));
    
    figure; imshow(bw_img);
    x = xcoor(:,img);
    y = ycoor(:,img);
    r = radii(:,img);
    
    x = x(any(~isnan(x),2),:);
    y = y(any(~isnan(y),2),:);
    r = r(any(~isnan(r),2),:);
    
    len = length(r);
   mask = false(size(bw_img));
   for count = 1:len
       h = drawcircle('Center',[x(count) y(count)],'Radius',r(count));
       mask = mask | createMask(h);
       %%imshow(mask);
   end
   filename = strcat('bw_frame', num2str(img),'.jpeg');
   imwrite(mask, filename, 'JPEG');
   image{iteration} = mask;
   iteration = iteration+1;
   disp(img);
   close all;

end