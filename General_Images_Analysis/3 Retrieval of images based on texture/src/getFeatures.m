function [ texturesDescriptor ] = getFeatures(Image,Filters)
% ej_3.2
% Implement	 a	 function	 getFeatures()	 in	 Matlab	 that	 given	 an	 image,	 builds	 a
% descriptor	of	textures	where	each	element	of	the	descriptor	is	the	average	of	the	result
% of	 the	 convolution	 of	 the	 image	 with	 any	 of	 the	 filters.	 Display	 the	 result	 of	 the
% convolution	with	some	filters.	See	which	filters	have	a	better	response	on	the	image	you
% have	chosen	and	comment	why.	What	size	does	the	texture	descriptor	have?
texturesDescriptor = zeros(1,size(Filters,3));

for i=1:size(Filters,3)
    texturesDescriptor(1,i)=mean(mean(abs(imfilter(rgb2gray(Image),Filters(:,:,i)))));
end

end

