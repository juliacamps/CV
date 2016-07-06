function ej_22(filename)
im=imread(filename);
 
I=rgb2gray(im);
BW1 = edge(I,'sobel');
BW2 = edge(I,'canny',0.2,1);
BW3 = edge(I,'Prewitt',0.2);

figure;
subplot(2,3,1);
imshow(BW1,[])
subplot(2,3,2);
imshow(BW2,[])
subplot(2,3,3);
imshow(BW3,[])

subplot(2,3,4);
inv_BW1=imcomplement(BW1);
edges1=uint8(cat(3,BW1,BW1,BW1))+immultiply(im,cat(3,inv_BW1,inv_BW1,inv_BW1));
imshow(edges1,[])
title('Sobel');

subplot(2,3,5);
inv_BW2=imcomplement(BW2);
edges2=uint8(cat(3,BW2,BW2,BW2))+immultiply(im,cat(3,inv_BW2,inv_BW2,inv_BW2));
imshow(edges2,[])
title('Canny');

subplot(2,3,6);

inv_BW3=imcomplement(BW3);
edges3=uint8(cat(3,BW3,BW3,BW3))+immultiply(im,cat(3,inv_BW3,inv_BW3,inv_BW3));
imshow(edges3,[])
title('Prewitt');

end