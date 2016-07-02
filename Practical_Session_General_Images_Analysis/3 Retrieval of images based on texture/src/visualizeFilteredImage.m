function [ output_args ] = visualizeFilteredImage( Image,Filters )
%VISUALIZEFILTEREDIMAGE Summary of this function goes here
%   Detailed explanation goes here
for i=1:size(Filters,3)
    subplot(8,6,i);
    imagesc(imfilter(rgb2gray(Image),Filters(:,:,i))); colorbar;
    
end

end

