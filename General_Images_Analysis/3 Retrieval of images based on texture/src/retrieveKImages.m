function [ mostSimilarImages ] = retrieveKImages( image, imageFeatures, images, textureDescriptors, k )
% ej_3.4
found=knnsearch(textureDescriptors,imageFeatures,'K',k);
figure;
subplot(k/3+1,3,2);
imshow(image);
title('Original image');
mostSimilarImages=zeros(k,size(image,1),size(image,2),size(image,3));
for i=1:k
    im=found(i);
    mostSimilarImages(i,:,:,:)=images(im,:,:,:);
    subplot(k/3+1,3,3+i);
    imshow(uint8(squeeze(images(im,:,:,:))));
    title('Retrieved image');
end
end

