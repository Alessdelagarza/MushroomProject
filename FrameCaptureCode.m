a=VideoReader('MontShroom2.AVI');
count = 1057;
for img = 1:a.NumFrames
    filename=strcat('frame',num2str(count),'.jpg');
    b = read(a, img);
    imwrite(b,filename);
    count = count+1;
end
