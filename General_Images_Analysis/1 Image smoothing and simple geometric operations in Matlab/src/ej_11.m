% 1.1 Creating	images	of	3	channels	(color	images)	
% The	RGB	images	are	formed	by	3	matrices,	commonly	called	channels.	
% a)	Create	the	3	images	in	gray	scale	as	shown	in	Figure	1.	
% b)	Combine	the	3	obtained	to	construct	the	color	image	shown	in	Figure	1(right).	
% c)	Save	the	image	as	3channels.jpg
%We create a first matrix, size 200x200, full with zeros (a black square)
A=zeros(200,200);
%Image1
%Using the original matrix, we set as 255(white) the columns from 100 to 200
%(second half) and create an b&w image
M1=A;
M1(1:200,100:200)=255;
im1=mat2gray(M1);
%Image2
%Using the original matrix, we set as 255(white) the rows from 100 to 200
%(second half) and create an b&w image
M2=A;
M2(100:200,1:200)=255;
im2=mat2gray(M2);

%Image3
%Using the original matrix, we set as 255(white) the cells from 1x1 to
%100x100, the first cuadrant and create an b&w image
M3=A;
M3(1:100,1:100)=255;
im3=mat2gray(M3);

%Image4
%We create a RGB image from the other three matrixes (Red, Green and Blue)
im4 = cat(3, M1, M2, M3);

%We show all the images
subplot(2, 2, 1);
imshow(im1);
title('R')
subplot(2, 2, 2);
imshow(im2);
title('G')

subplot(2, 2, 3);
imshow(im3);
title('B')

subplot(2, 2, 4);
imshow(im4);
title('Result')


%We write the 4th image to a file called 3channels.jpg
imwrite(im4, '3channels.jpg');