function [ textureDescriptors, images ] = getClassFeaturesAllDirectories(extension, firstDirectory, varargin )
[textureDescriptors,images]=getClassFeatures(firstDirectory,extension);

for k = 1:length(varargin)
    [textureDescriptors1,images1]=getClassFeatures(varargin{k},extension);
    textureDescriptors=vertcat(textureDescriptors,textureDescriptors1);
    images=vertcat(images,images1);
end
end

