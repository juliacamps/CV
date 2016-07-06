function im = thresholdImg( threshold )
%THRESHOLDING This function creates a binary image of car_gray.jpg, given a
%threshold
im_orig=imread('images/car_gray.jpg');
im=im2bw(im_orig, threshold/255);
end

