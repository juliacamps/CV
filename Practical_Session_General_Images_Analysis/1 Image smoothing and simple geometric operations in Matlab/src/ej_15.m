%We create and display the binary image with different thresholds: 20, 30,
%150, 255
figure;
subplot(2,2,1);
imshow(thresholdImg(20));
title('Threshold 20');
subplot(2,2,2);
imshow(thresholdImg(30));
title('Threshold 30');
subplot(2,2,3);
im_150=thresholdImg(150);
imshow(im_150);
title('Threshold 150');
subplot(2,2,4);
imshow(thresholdImg(255));
title('Threshold 255');

%We store the image with threshold=150 as car_binary.jpg
imwrite(im_150, 'car_binary.jpg');

%We multiply the original image by the binary image (th=150) and display
%the original, the binary and the result
orig=imread('images/car_gray.jpg');
mult=immultiply(orig,im_150);
figure;
subplot(1,3,1);
imshow(orig);
title('Original');

subplot(1,3,2);
imshow(im_150);
title('Threshold 150');

subplot(1,3,3);
imshow(mult);
title('Binary * Original');


%We multiply the the original image by the inverse of the binary image (th=150) 
%and display the original, the inverse and the result
inv=imcomplement(im_150);
multinv=immultiply(orig,inv);
figure;
subplot(1,3,1);
imshow(orig);
title('Original');

subplot(1,3,2);
imshow(inv);
title('Threshold 150 Inverse');

subplot(1,3,3);
imshow(multinv);
title('Binary Inverse * Original');