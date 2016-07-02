clc;
clear;
close all;
I = vl_impattern('roofs1');
I = single(rgb2gray(I));
figure;
subplot(2,3,1)
imshow(I);
[f,d] = vl_sift(I);
subplot(2,3,2)
show_keypoints(I,f);
subplot(2,3,3)
show_keypoints(I,random_selection(f,50));

figure;
subplot(2,2,1)
[f,d] = vl_sift(I,'PeakThresh', 0.01);
show_keypoints(I,f);
title('Threshold 0.01')
subplot(2,2,2)
[f,d] = vl_sift(I,'PeakThresh', 0.04, 'EdgeThresh', 10);
show_keypoints(I,f);
title('Threshold 0.04')

subplot(2,2,3)
[f,d] = vl_sift(I,'PeakThresh', 0.05, 'EdgeThresh', 10);
show_keypoints(I,f);
title('Threshold 0.05')

subplot(2,2,4)
[f,d] = vl_sift(I,'PeakThresh', 0.08, 'EdgeThresh', 10);
show_keypoints(I,f);
title('Threshold 0.08')

%subplot(2,3,5)

figure;
show_keypoints(I,f);