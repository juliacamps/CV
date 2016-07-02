function [ output_args ] = testFilters()
clc;
close all;
% Illustrating Gaussian filter bank
F=makeLMfilters(); % generating the filters
visualizeFilters(F);
I=imread(fullfile('texturesimages/forest/forest_9.jpg'));
imFeatures=getFeatures(I,F);
visualizeConvolution(I,F);
[textureDescriptors,images]=getClassFeaturesAllDirectories('jpg','texturesimages/forest/','texturesimages/buildings/','texturesimages/sunset/');
retrieveKImages(I,imFeatures,images,textureDescriptors,9);
end

