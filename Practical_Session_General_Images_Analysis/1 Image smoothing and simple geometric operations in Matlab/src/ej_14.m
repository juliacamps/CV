function  ej_14( original_image )
%ej_14 this function swaps the two halves of a given image
%   First we read the image
im_orig=imread(original_image);

%We select the cutting point manually (to ensure its well done even if its
%not in the middle of the original image
[im_sel,rect] =imcrop(im_orig);

%Now we check if the previous selected part is the first part or the second
%one, and depending on this we rejoin both images to create an inverted
%parts one
if (rect(1) > 1) && (rect(1) > 1) %The selection was taken from the first part of the image
    %We fix the selection to ensure no problems happen
    im_sel=im_orig(1:size(im_orig,1),size(im_sel,2):size(im_orig,2),:);
    %We obtain the unselected part of the image
    im_unsel=im_orig(1:size(im_orig,1),1:size(im_sel,2),:);
    %We invert the order of the both parts
    Res = cat(2,im_sel,im_unsel);
else %The selection was taken from the second part of the image
    %We fix the selection to ensure no problems happen
    im_sel=im_orig(1:size(im_orig,1),1:size(im_sel,2),:);
    %We obtain the unselected part of the image
    im_unsel=im_orig(1:size(im_orig,1),size(im_sel,2):size(im_orig,2),:);
    %We invert the order of the both parts
    Res = cat(2,im_unsel,im_sel);
end
%We display the original and the new image
figure; imshow(Res); %figure1
%Original vs Inverted
figure; %figure2
subplot(1,2,1);imshow(im_orig); title('Original');
subplot(1,2,2); imshow(Res); title('Inverted');

end

