function visualizeConvolution( Image,Filters )
figure;
imshow(Image);
figure;
for i=1:size(Filters,3)
    subplot(8,6,i);
    imagesc(imfilter(rgb2gray(Image),Filters(:,:,i)));
end
end

