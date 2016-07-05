% Computational Vision
% 2015-2016
% Student name: Julia Camps Sereix
%
% >> OBJECTIVE: 
% 1) Analize the code
% 2) Understand the function of each part of the code
% 3) Code the missing parts
% 4) Execute the code and check the results
% 5) Comment the experiments and results in a report

% main function
function FD_ex1()

clc; close all; clear;
tmp = matlab.desktop.editor.getActive;
cd(fileparts(tmp.Filename));
%% Initialization
% Define Viola & Jones parameters for the first two feature masks
% SEE THE ATTACHED IMAGE FOR DETAILS!!!
L = 80;                            % mask size [px]
d1 = 10; d2 = 15; d3 = 20; d4 = 10; % distances from the border
w1 = 50; w2 = 20; w3 = 20;          % width of the rectangles
h1 = 10; h2 = 20;                   % height of the rectangles


%% Draw the 2 feature masks (just for visualization purpose)
m1 = zeros(L,L);
m2 = zeros(L,L);

m1(d1+1:d1+h1,d2+1:d2+w1) = 1;
m1(d1+1+h1:d1+2*h1,d2+1:d2+w1) = 2;
figure(1);
imagesc(m1);
title('Rectangluar mask for feature 1');
axis square;
colormap([128 128 128; 0 0 0; 255 255 255]/255);

m2(d3+1:d3+h2,d4+1:d4+w2) = 1;
m2(d3+1:d3+h2,d4+w2+1:d4+w2+w3) = 2;
m2(d3+1:d3+h2,d4+w2+w3+1:d4+2*w2+w3) = 1;
figure(2);
imagesc(m2);
title('Rectangluar mask for feature 2');
axis square;
colormap([128 128 128; 0 0 0; 255 255 255]/255);


%% Load image, compute Integral Image and visualize it

% Load image 'NASA1.jpg' and convert image from rgb to grayscale 
I_gray = imread('NASA1.bmp');

% Compute the Integral Image
S = cumsum(cumsum(double(I_gray),2));



%% Compute features for regions with faces

% (X,Y) coordinates of the top-left corner of windows with face
X = [193 340 444 573 717 834 979 1066 1224 195 445 717 964 1200];
Y = [118 151 112 177 114 177 121 184 127 270 298 279 285 295];
XY_FACE =  [X' Y'];    %[x1 y1; x2 y2 .....]

% Initialize the feature matrix for faces
FEAT_FACE = [];

for i = 1:size(XY_FACE,1)
    
    % current top-left corner coordinates
     x = XY_FACE(i,1); 
     y = XY_FACE(i,2);
    
    % compute area of regions A and B for the first feature
    % HERE WE USE INTEGRAL IMAGE!
    area_A = S(y+d1+h1,x+d2+w1) - S(y+d1+1,x+d2+w1) - (S(y+d1+h1,x+d2+1) - S(y+d1+1,x+d2+1));
    area_B = S(y+2*h1+d1,x+w1+d2) - S(y+d1+h1+1,x+d2+w1) - (S(y+d1+2*h1,x+d2+1)-S(y+d1+h1+1,x+d2+1));
    
    % compute area of regions C, D and E for the second feature
    % HERE WE USE INTEGRAL IMAGE!
    % >> code to compute the area of regions C and E <<
    area_C = S(y+d3+h2,x+d4+w2) - S(y+d3+1,x+d4+w2) - (S(y+d3+h2,x+d4+1) - S(y+d3+1,x+d4+1));
    area_D = S(y+d3+h2,x+d4+w2+w3) - S(y+d3+1,x+d4+w2+w3) - (S(y+d3+h2,x+d4+w2+1) - S(y+d3+1,x+d4+w2+1));
    area_E = S(y+d3+h2,x+d4+2*w2+w3) - S(y+d3+1,x+d4+2*w2+w3) - (S(y+d3+h2,x+d4+w2+w3+1) - S(y+d3+1,x+d4+w2+w3+1));
    
    % compute features value
    F1 = area_B - area_A;
    F2 = area_D - (area_C + area_E);
    
    % cumulate the computed values
    FEAT_FACE = [FEAT_FACE; [F1 F2]];
    
end

%% Compute features for regions with non-faces

% (X,Y) coordinates of the top-left corner of windows with non-face
X=[ 28 307 574 829 1093 203 350 523 580 800 931 1127 692 1265];
Y=[ 36    28    27    30    46   768   757   742   859   745   912   777   994   820];
XY_NON_FACE = [X' Y'];

% Initialize the feature matrix for non-faces
FEAT_NON_FACE = [];

for i = 1:size(XY_NON_FACE,1)
    
    % current top-left corner coordinates
    x = XY_NON_FACE(i,1); y = XY_NON_FACE(i,2);
    
    % compute area of regions A and B for the first feature
    % HERE WE USE INTEGRAL IMAGE!
    area_A = S(y+d1+h1,x+d2+w1) - S(y+d1+1,x+d2+w1) - (S(y+d1+h1,x+d2+1) - S(y+d1+1,x+d2+1));
    area_B = S(y+2*h1+d1,x+w1+d2) - S(y+d1+h1+1,x+d2+w1) - (S(y+d1+2*h1,x+d2+1)-S(y+d1+h1+1,x+d2+1));
    
    % compute area of regions C, D and E for the second feature
    % HERE WE USE INTEGRAL IMAGE!
    % >> code to compute the area of regions C and E <<
    area_C = S(y+d3+h2,x+d4+w2) - S(y+d3+1,x+d4+w2) - (S(y+d3+h2,x+d4+1) - S(y+d3+1,x+d4+1));
    area_D = S(y+d3+h2,x+d4+w2+w3) - S(y+d3+1,x+d4+w2+w3) - (S(y+d3+h2,x+d4+w2+1) - S(y+d3+1,x+d4+w2+1));
    area_E = S(y+d3+h2,x+d4+2*w2+w3) - S(y+d3+1,x+d4+2*w2+w3) - (S(y+d3+h2,x+d4+w2+w3+1) - S(y+d3+1,x+d4+w2+w3+1));
    
    % compute features value
    F1 = area_B - area_A;
    F2 = area_D - (area_C + area_E);
    
    % cumulate the computed values
    FEAT_NON_FACE = [FEAT_NON_FACE; [F1 F2]];
    
end

%% Visualize samples in the feature space
figure(3)
hold on
scatter(FEAT_FACE(:,1),FEAT_FACE(:,2),'g');
scatter(FEAT_NON_FACE(:,1),FEAT_NON_FACE(:,2),'r');
xlabel('Feature 1');
ylabel('Feature 2');
title('Feature space');


%% Visualize image with used regions
figure(4);
imshow(I_gray);

% patches with faces
for i = 1:size(XY_FACE,1)
    PATCH = [XY_FACE(i,:) L L];
    Rectangle = [PATCH(1) PATCH(2); PATCH(1)+PATCH(3) PATCH(2); PATCH(1)+PATCH(3) PATCH(2)+PATCH(4); PATCH(1)  PATCH(2)+PATCH(4); PATCH(1) PATCH(2)];
    hold on;
    plot (Rectangle(:,1), Rectangle(:,2), 'g');
    hold off;
end

% patches without faces
for i = 1:size(XY_NON_FACE,1)
    PATCH = [XY_NON_FACE(i,:) L L];
    Rectangle = [PATCH(1) PATCH(2); PATCH(1)+PATCH(3) PATCH(2); PATCH(1)+PATCH(3) PATCH(2)+PATCH(4); PATCH(1)  PATCH(2)+PATCH(4); PATCH(1) PATCH(2)];
    hold on;
    plot (Rectangle(:,1), Rectangle(:,2), 'r');
    hold off;
end



%% Part 2:

%% Define the new regions of the test image 

% Load image 'NASA2.bmp' and convert image from rgb to grayscale 
I = imread('NASA2.bmp');
I_gray = rgb2gray(I);

% Select regions with FACES and NON-FACES
% figure(5), imshow(I);
% [x1, y1] = ginput();
% % You can use ginput only once and copy the coordinates here
% 
% x1 = round(x1);
% y1 = round(y1);

x1 = [69    42    93   249   159   198   285   378   405   318   414   513   480   552   565   670 ...
    732   768   636   744   838   898   907   826   639   495   328   246    85    36   463   597 ...
   750    43   145   789   352   318    84   118    64   622   643];
y1 = [111   195   277   265   174   106   144   187   270    82    84    88   184   250   165   181 ...
    249   162    94    85    88   145   249   285   301   301   327   435   445   499   457   450 ... 
    465    43    42    24   486   261   450   544   640   534   507];
% (X,Y) coordinates of the top-left corner of windows with face
XY_TEST = [x1' y1'];

  
%% Compute features for these new regions
% Compute the Integral Image
S = cumsum(cumsum(double(I_gray),2));

% Initialize the feature matrix for faces
FEAT_TEST = [];

for i = 1:size(XY_TEST,1)
    
    % current top-left corner coordinates
    x = XY_TEST(i,1);
    y = XY_TEST(i,2);
    
    % compute area of regions A and B for the first feature
    % HERE WE USE INTEGRAL IMAGE!
    area_A = S(y+d1+h1,x+d2+w1) - S(y+d1+1,x+d2+w1) - (S(y+d1+h1,x+d2+1) - S(y+d1+1,x+d2+1));
    area_B = S(y+2*h1+d1,x+w1+d2) - S(y+d1+h1+1,x+d2+w1) - (S(y+d1+2*h1,x+d2+1)-S(y+d1+h1+1,x+d2+1));
    
    % compute area of regions C, D and E for the second feature
    % HERE WE USE INTEGRAL IMAGE!
    area_C = S(y+d3+h2,x+d4+w2) - S(y+d3+1,x+d4+w2) - (S(y+d3+h2,x+d4+1) - S(y+d3+1,x+d4+1));
    area_D = S(y+d3+h2,x+d4+w2+w3) - S(y+d3+1,x+d4+w2+w3) - (S(y+d3+h2,x+d4+w2+1) - S(y+d3+1,x+d4+w2+1));
    area_E = S(y+d3+h2,x+d4+2*w2+w3) - S(y+d3+1,x+d4+2*w2+w3) - (S(y+d3+h2,x+d4+w2+w3+1) - S(y+d3+1,x+d4+w2+w3+1));  
    
    % compute features value
    F1 = area_B - area_A;
    F2 = area_D - (area_C + area_E);

    % cumulate the computed values
    FEAT_TEST = [FEAT_TEST; [F1 F2]];
    
end


%% Train a k-nn classifier and test the new windows
features = [FEAT_FACE; FEAT_NON_FACE];
Group = [repmat(1, length(FEAT_FACE), 1); repmat(2, length(FEAT_NON_FACE), 1)];
% Call the function knnclassify
clase = knnclassify(FEAT_TEST,features,Group);

XY_FACE = XY_TEST(find(clase==1),:);
XY_NON_FACE = XY_TEST(find(clase==2),:);

%% Visualize samples in the feature space
% First, visualize the training samples:
figure(6);
hold on
h(1)=scatter(FEAT_FACE(:,1),FEAT_FACE(:,2),'g');
h(2)=scatter(FEAT_NON_FACE(:,1),FEAT_NON_FACE(:,2),'r');
% xlabel('Feature 1');
% ylabel('Feature 2');
% title('Train Feature space');
% legend({'Train Face','Train Non-Face'},'Location','NorthEastOutside');

% Second, visualize the test samples in two different colors

hold on
h(3)=scatter(FEAT_TEST(find(clase==1),1),FEAT_TEST(find(clase==1),2),'c');
h(4)=scatter(FEAT_TEST(find(clase==2),1),FEAT_TEST(find(clase==2),2),'m');
xlabel('Feature 1');
ylabel('Feature 2');
title('Test Feature space');
% legend({'Test Feature'},'Location','NorthEastOutside');
legend({'True Face','True Non-Face','Pred Face','Pred Non-Face'},'Location','NorthEastOutside');


%% Visualize classification results in the test image
figure(7);
imshow(I);

%% patches with faces
for i = 1:size(XY_FACE,1)
    PATCH = [XY_FACE(i,:) L L];
    Rectangle = [PATCH(1) PATCH(2); PATCH(1)+PATCH(3) PATCH(2); PATCH(1)+PATCH(3) PATCH(2)+PATCH(4); PATCH(1)  PATCH(2)+PATCH(4); PATCH(1) PATCH(2)];
    hold on;
    plot (Rectangle(:,1), Rectangle(:,2), 'g');
    hold off;
end

% patches without faces
for i = 1:size(XY_NON_FACE,1)
    PATCH = [XY_NON_FACE(i,:) L L];
    Rectangle = [PATCH(1) PATCH(2); PATCH(1)+PATCH(3) PATCH(2); PATCH(1)+PATCH(3) PATCH(2)+PATCH(4); PATCH(1)  PATCH(2)+PATCH(4); PATCH(1) PATCH(2)];
    hold on;
    plot (Rectangle(:,1), Rectangle(:,2), 'r');
    hold off;
end


end





