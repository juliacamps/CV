function fuseImg()
%FUSEIMG Summary of this function goes here
%   Detailed explanation goes here
original_mapfre=imread('images/mapfre.jpg');

% a)	Open	hand.jpg	and	convert	it	in	gray	scale	image.
original_hand=imread('images/hand.jpg');
gray_hand=rgb2gray(original_hand);

% b)	 Perform	 a	 binarization	 to	 obtain	 a	 binary	 image	 of	 2	 regions:	 the	 hand	 (called	
% foreground)	 and	 the	 rest	 (called	 background).	 Create	 the	 inverse	 binary	 image	
% changing	the	areas	of	foreground	and	background.	
binary_hand=im2bw(gray_hand, 0.099);
inv_binary_hand=imcomplement(binary_hand);

% c)	use	 the	binary	matrices	created	in	b)	 to	merge	 the	images	hand	and	mapfre	(Fig. 3(c))	
foreground_mask = cat(3,binary_hand,binary_hand,binary_hand);
background_mask = cat(3,inv_binary_hand,inv_binary_hand,inv_binary_hand);

background=immultiply(original_mapfre,background_mask);
foreground=immultiply(original_hand,foreground_mask);

figure;
subplot(1,3,1);
imshow(background);

subplot(1,3,2);
imshow(foreground);

hand_mapfre=background+foreground;

subplot(1,3,3);
imshow(hand_mapfre);
% e)	Save	the	image	as	hand_mapfre_3C.jpg.
imwrite(hand_mapfre,'hand_mapfre_3C.jpg');
end

