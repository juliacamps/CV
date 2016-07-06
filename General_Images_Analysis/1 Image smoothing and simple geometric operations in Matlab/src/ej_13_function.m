function ej_13_function( imagename )
    %a)
    %Read original image
    im_orig = imread(imagename);

    %b)
    %RESCALE
    im_small = imresize(im_orig,0.1);%image resizing to 10 times smaller
    %Show how details of the image disappear when rescale the size of the image
    figure;%figure1
    subplot(1,2,1); imshow(im_orig); title('Original');%will plot on the left side of figure 2
    subplot(1,2,2); imshow(im_small); title('Rescaled');%will plot on the right side
    %As we can see on the previous plot, lots of details are lost when rescaling the selected image.

    %HISTOGRAMS
    %Does the histogram change of both images (the original and the rescaled one)?	
    figure;%figure2
    %(histograms only work with one color channel at a time)
    %histogram for the original image
    subplot(1,2,1); imhist(rgb2gray(im_orig)); title('Original');%will plot on the left side of figure 2
    %histogram for the rescaled image
    subplot(1,2,2); imhist(rgb2gray(im_small)); title('Rescaled');%will plot on the right side

    %RETURN TO ORIGINAL SIZE
    %Return back the smaller image to the original size. Compare to the original one.
    im_small_re = imresize(im_small,10);
    figure;%figure3
    subplot(1,2,1); imshow(im_orig); title('Original');%will plot on the left side of figure 2
    subplot(1,2,2); imshow(im_small_re); title('Restored size');%will plot on the right side
    %Whe can see that the pixel density is better than in the without returning
    %to the original size image, but, the information that was lost when we
    %rescaled first time hasn't been recovered with simply returning to the
    %original size.

    %HISTOGRAMS
    figure;
    subplot(1,3,1); imhist(rgb2gray(im_orig)); title('Original Image Histogram');
    subplot(1,3,2); imhist(rgb2gray(im_small)); title('Small image Histogram');
    subplot(1,3,3); imhist(rgb2gray(im_small_re)); title('Returned to original size Histogram');

    %c)
    figure;
    subplot(3,3,1); imshow(im_orig); title('Original');
    mask=[1 1 1 1 1 1 1 1 1 1]/10;%vector mask
    subplot(3,3,2); imshow(mask); title('Mask: [1 1 1 1 1 1 1 1 1 1]/10');
    hsize = 10; sigma = 3;
    filter = fspecial('gaussian',hsize,sigma);%gaussian filter
    subplot(3,3,3); imagesc(filter); axis equal tight; title('Gausian Filter');
    %first iteration
    img_smooth_mask=imfilter(im_orig,mask);%vector mask filtering
    img_smooth_gausian = imfilter(im_orig, filter);%gausian filering
    subplot(3,3,4); imshow(img_smooth_mask); title('1 M. Smooth');
    subplot(3,3,7); imshow(img_smooth_gausian); title('1 G. Smooth');
    for i=1 : 2
        img_smooth_mask=imfilter(img_smooth_mask,mask);%vector mask filtering
        img_smooth_gausian = imfilter(img_smooth_gausian, filter);%gausian filering
        subplot(3,3,i+4); imshow(img_smooth_mask); title(strcat(num2str(i+1),' M. Smooth'));
        subplot(3,3,i+7); imshow(img_smooth_gausian); title(strcat(num2str(i+1),' G. Smooth'));
    end
%Can you apply the filter on the rgb image?
    %Yes you can. Demostration:
%     hsize = 10; sigma = 3;
%     filter = fspecial('gaussian',hsize,sigma);%gaussian filter
%     img_smooth_gausian = imfilter(im_orig, filter);%gausian filering
%     figure; imshow(img_smooth_gausian); title('RGB Image Smoothed with Gausian Filter');
%What type should be the image before convolving and why?
    %Should be a 2D image, because the conv2 is for 2D Matrixes.
%What dimensions should be the mask?
    %Should be at least a 1D mask, in orther to have horitzontal or
    %vertical smooting. Or it can be a matrix based mask.
%What is the difference using the following three masks: 
    %a) [1 1 1 1 1] -> Is only Horitzontal Smoothing mask
    %b) [1;1;1;1;1] -> Is only Vertical Smoothing mask
    %c) [[1 1 1 1 1];[1 1 1 1 1];[1 1 1 1 1];[1 1 1 1 1];[1 1 1 1 1]] -> 
    %Is using information from horizontal and vertical neightbours to smooth the image.
%Do we need to normalize the mask (divide by the sum of all its numbers)?
    %Yes, because otherwise we may obtain values that are out of range
    %(more than 255).
    
%Note2) Substract the smoothed image to the original one, in order to see
%the differences.
figure;
subplot(1,3,1); imshow(im_orig); title('Original Image');
subplot(1,3,2); imshow(img_smooth_gausian); title('Gaussian Smoothed Image');
subplot(1,3,3); imshow(imsubtract(im_orig, img_smooth_gausian)); title('Substraction from both images');

end