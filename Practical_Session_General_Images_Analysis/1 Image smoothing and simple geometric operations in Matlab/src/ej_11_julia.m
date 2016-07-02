%Ex_1
clear;
AZero = zeros(200, 100);%creates half of the needed matrix
AOnes = ones(200, 100);%creates the other half
ChnRed = cat(2,AZero,AOnes);%joins two matrixes to obtain the first desired one
AZero = zeros(100, 200);%repeats the process changing the concating dimension
AOnes = ones(100, 200);
ChnGreen = cat(1,AZero,AOnes);
ChnBlue = zeros(200, 200);%creates a zeros matrix
ChnBlue(1:100, 1:100)=1;%sets to one the desired section
%separated channels representation
figure;
subplot(1,3,1); imshow(ChnRed); title('Red Channel');
subplot(1,3,2); imshow(ChnGreen); title('Green Channel');
subplot(1,3,3); imshow(ChnBlue); title('Blue Channel');
%Result
rgbImage = cat(3, ChnRed, ChnGreen, ChnBlue);%constructs a 3 channels rgb image taking each of the previous matrixes as one single channel
imwrite(rgbImage,'3channels.jpg'); title('RGB Image');%saves the result in a jpg file
