function [ output_args ] = ej_21function(im1_name, im2_name)
    im1=imread(im1_name);
    im2=imread(im2_name);
    
    hsize = 30; sigma = 9; sigma_high=25;
    filter_low = fspecial('gaussian',hsize,sigma);%gaussian filter
    filter_high = fspecial('gaussian',hsize,sigma_high);%gaussian filter
    im1_low = imfilter(im1, filter_low);%obtain the lowpass filtered
    im2_high= im2- imfilter(im2, filter_high);%obtain the highpass filtered
    im_hybrid = imadd(im1_low,im2_high); %generate the hybrid image
    
    %plot all
    figure;
    subplot(3,3,1); imshow(im1);
    subplot(3,3,2); imshow(im2);
    for i=3:1:9
        subplot(3,3,i); imshow(im_hybrid);
        im_hybrid((size(im_hybrid,1)+ceil(size(im_hybrid,1)/5)),(size(im_hybrid,2)+ceil(size(im_hybrid,2)/5)))=0;
    end
end

