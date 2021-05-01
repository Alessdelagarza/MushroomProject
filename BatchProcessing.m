
TotalFrames = 1960;
Radius_Data = NaN(1960,500);
Center_DataX = NaN(1960,500);
Center_DataY = NaN(1960,500);
for img = 1:1:TotalFrames
    if img == 1577
        img = img+1;
    end
  filename = strcat('frame',num2str(img),'.jpg');
  
  %Calling in Images
  rgb_img = imcrop(imread(filename), [400 230 399 399]);
  gray_img = rgb2gray(rgb_img);
  
  %Image Breakdown
  sub_img = mat2tiles(gray_img, [50 50]); 
  sub_img = sub_img.';
  tile_num = numel(sub_img);
  [x, y, z] = size(sub_img);
  
  for j = 1:tile_num
      
    %Contrast Adjustment
    thresh = graythresh(sub_img{j});
    sub_img{j} = imadjust(sub_img{j}, [thresh 1], [0 1]);
    
    %Edge Detection
    sub_img{j} = edge(sub_img{j}, 'Canny');
    
  end
  
  %Stitching Image Together
  row1 = cat(2, sub_img{1:8});
  row2 = cat(2, sub_img{9:16});
  row3 = cat(2, sub_img{17:24});
  row4 = cat(2, sub_img{25:32});
  row5 = cat(2, sub_img{33:40});
  row6 = cat(2, sub_img{41:48});
  row7 = cat(2, sub_img{49:56});
  row8 = cat(2, sub_img{57:64});
  bw = cat(1, row1,row2,row3,row4,row5,row6,row7,row8);
  
  %Masking Out Noise
  gray_mask = filter2(fspecial('disk',1),gray_img)/255;
  thresh = graythresh(gray_mask);
  adj_mask = imadjust(gray_mask, [thresh 1],[]);
  sharp_mask = imsharpen(adj_mask, 'Radius', 1, 'Amount', 1);
  thresh = graythresh(sharp_mask);
  mask = imbinarize(sharp_mask, thresh);
  SE = strel('disk',5);
  mask = imopen(mask,SE);
  SE = strel('disk',5);
  mask = imdilate(mask,SE);
  bw = immultiply(bw, mask);
  
  %Circles Detetion
   [centers, radii, metric] = imfindcircles(bw, [6 60]);
%    cir_num = length(centers);
%    centersStrong = centers(1:cir_num,:); 
%    radiiStrong = radii(1:cir_num);
%    metricStrong = metric(1:cir_num);
%    figure; imshow(rgb_img);
%    viscircles(centersStrong, radiiStrong,'EdgeColor','b');
%    title('Objects Detected');
  disp(img)
  radii = padarray(radii,500-length(radii),0,'post');
  centers = padarray(centers,500-length(centers),0,'post');
  
  Radius_Data(img,:) = radii;
  Center_DataX(img,:) = centers(:,1);
  Center_DataY(img,:) = centers(:,2);
end

writematrix(Radius_Data, 'Radius_Data.xlsx')
writematrix(Center_DataX, 'Center_Data.xlsx','Sheet',1)
writematrix(Center_DataY, 'Center_Data.xlsx','Sheet',2)