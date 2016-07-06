function [ classFeatures, images ] = getClassFeatures( dirPath, extension )
% ej_3.3
% Write	 a	 function	 getClassFeatures()	 in	 Matlab	 that	 given	 a	 directory	 and	 an	
% extension,	reads	all	images	in	the	directory	with	the	specific	extension,	calculates	their	
% texture	 descriptors	 (using	 3.1)	 and	 stores	 them	 in	 an	 array,	 where	 each	 row	
% corresponds	to	an	image	and	each	column	to	a	feature.	Apply	this	function	to	build	three	
% arrays	of	descriptors	of	texture	of	the	3	kinds	of	images	in	the	directory	textureimages	
% downloaded	from	the	Virtual	Campus.	Help:	given	a	directory	in	the	variable	‘directory’	
% (e.g.	 '	 images/sunset	 /'),	 the	 following	 command	 reads	 the	 files	 that	 exist	 in	 this	
% directory:
files=dir(fullfile(dirPath,strcat('*.',extension)));
%images=zeros(size(files,1),1);
F=makeLMfilters(); % generating the filters
classFeatures=zeros(1,size(F,3));
imsize=size(imread(fullfile(dirPath, files(1).name)));
images=zeros(size(files,1),imsize(1),imsize(2),imsize(3));
for i=1:size(files,1)
    im=imread(fullfile(dirPath, files(i).name));
    images(i,:,:,:)=im;
    classFeatures(i,:)=getFeatures(im, F);
end;

end

