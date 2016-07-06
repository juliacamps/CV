% Read	 the	image	 sillas.jpg.	Display	 different	 channels	 and	 explain	 the	 difference	 and	
% similarities	in	pixel	values.	What	would	happen	if	we	interchange	the	channels?	What	
% would	happen	if	we	multiply	one	of	them	by	0?	

%Read the image sillas.jpg
figure;
im=imread('images/sillas.jpg');
size(im);
im1=im(10,20); % grey imatge
R=im(:,:,1); % R channel
G=im(:,:,2); % G channel
B=im(:,:,3); % B channel
subplot(2, 3, 2);
imshow(im);


%As we can see, in the blue and green layers, the chairs appear
%black (no green nor blue color there), and the red layer appears with
%white chairs much red color there)
title('Original image')

subplot(2, 3, 4);
imshow(R);
title('R')

subplot(2, 3, 5);
imshow(G);
title('G')

subplot(2, 3, 6);
imshow(B);
title('B')


%What	would	happen	if	we	interchange	the	channels?

%As we can see, if we change the layers Red and Green the chairs are now
%green instead of red, therefore the red layer now appears with the chairs
%black (no red color there), and the green layer appears with white chair
%(much green color there)
imGreen=im;
 imGreen(:,:,1)=im(:,:,2);
 imGreen(:,:,2)=im(:,:,1);

RimGreen=imGreen(:,:,1); % R channel
GimGreen=imGreen(:,:,2); % G channel
BimGreen=imGreen(:,:,3); % B channel
figure;
subplot(2, 3, 2);
imshow(imGreen);
title('Green image')

subplot(2, 3, 4);
imshow(RimGreen);
title('R')

subplot(2, 3, 5);
imshow(GimGreen);
title('G')

subplot(2, 3, 6);
imshow(BimGreen);
title('B')

%What would	happen	if	we	multiply	one	of	them	by	0?	
%We multiply the Green layer by 0
imGreen=im;
 imGreen(:,:,1)=im(:,:,2);
 imGreen(:,:,2)=im(:,:,1);

RimGreen=imGreen(:,:,1); % R channel
GimGreen=imGreen(:,:,2); % G channel
BimGreen=imGreen(:,:,3); % B channel
figure;
subplot(2, 3, 2);
imshow(imGreen);
title('Green image')

subplot(2, 3, 4);
imshow(RimGreen);
title('R')

subplot(2, 3, 5);
imshow(GimGreen);
title('G')

subplot(2, 3, 6);
imshow(BimGreen);
title('B')
