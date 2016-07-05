% Computational Vision
% 2015-2016
% Student name: Julia Camps Sereix
%
% >> OBJECTIVE: 
% 1) Write the code for Exercise 2
% 2) Execute the code and check the results
% 3) Comment the experiments and results in a report

% main function
function FD_ex2()
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
% New definitions
d5 = 10; d6 = 10; d7 = 10; d8 = 20; d9 = 10;
w4 = 60; w5 = 30; w6 = 10; w7 = 25;
h3 = 15; h4 = 15; h5 = 10; h6 = 20; h7 = 20; h8 = 20;


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
    %F1
    area_A = S(y+d1+h1,x+d2+w1) - S(y+d1+1,x+d2+w1) - (S(y+d1+h1,x+d2+1) - S(y+d1+1,x+d2+1));
    area_B = S(y+2*h1+d1,x+w1+d2) - S(y+d1+h1+1,x+d2+w1) - (S(y+d1+2*h1,x+d2+1)-S(y+d1+h1+1,x+d2+1));
    
    % compute area of regions C, D and E for the second feature
    % HERE WE USE INTEGRAL IMAGE!
    % >> code to compute the area of regions C and E <<
    %F2
    area_C = S(y+d3+h2,x+d4+w2) - S(y+d3+1,x+d4+w2) - (S(y+d3+h2,x+d4+1) - S(y+d3+1,x+d4+1));
    area_D = S(y+d3+h2,x+d4+w2+w3) - S(y+d3+1,x+d4+w2+w3) - (S(y+d3+h2,x+d4+w2+1) - S(y+d3+1,x+d4+w2+1));
    area_E = S(y+d3+h2,x+d4+2*w2+w3) - S(y+d3+1,x+d4+2*w2+w3) - (S(y+d3+h2,x+d4+w2+w3+1) - S(y+d3+1,x+d4+w2+w3+1));
    %New configurations
    %F3
    area_F = S(y+d5+h3,x+d5+w4) - S(y+d5+1,x+d5+w4) - (S(y+d5+h3,x+d5+1) - S(y+d5+1,x+d5+1));
    area_G = S(y+h3+h4+d5,x+w4+d5) - S(y+d5+h3+1,x+d5+w4) - (S(y+d5+h3+h4,x+d5+1)-S(y+d5+h3+1,x+d5+1));
    area_H = S(y+2*h3+h4+d5,x+w4+d5) - S(y+d5+h3+h4+1,x+d5+w4) - (S(y+d5+2*h3+h4,x+d5+1)-S(y+d5+h3+h4+1,x+d5+1));
    %F4
    area_I = S(y+d6+h5,x+d6+w5) - S(y+d6+1,x+d6+w5) - (S(y+d6+h5,x+d6+1) - S(y+d6+1,x+d6+1));
    area_J = S(y+d6+h5,x+d6+2*w5) - S(y+d6+1,x+d6+2*w5) - (S(y+d6+h5,x+d6+w5+1) - S(y+d6+1,x+d6+w5+1));
    area_K = S(y+2*h5+d6,x+w5+d6) - S(y+d6+h5+1,x+d6+w5) - (S(y+d6+2*h5,x+d6+1)-S(y+d6+h5+1,x+d6+1));
    area_L = S(y+2*h5+d6,x+2*w5+d6) - S(y+d6+h5+1,x+d6+2*w5) - (S(y+d6+2*h5,x+d6+w5+1)-S(y+d6+h5+1,x+d6+w5+1));
    %F5
    area_M = S(y+d7+h6,x+d8+w6) - S(y+d7+1,x+d8+w6) - (S(y+d7+h6,x+d8+1) - S(y+d7+1,x+d8+1));
    area_N = S(y+h6+h7+d7,x+w6+d8) - S(y+d7+h6+1,x+d8+w6) - (S(y+d7+h6+h7,x+d8+1)-S(y+d7+h6+1,x+d8+1));
    area_O = S(y+2*h6+h7+d7,x+w6+d8) - S(y+d7+h6+h7+1,x+d8+w6) - (S(y+d7+2*h6+h7,x+d8+1)-S(y+d7+h6+h7+1,x+d8+1));
    %F6
    area_P = S(y+d9+h8,x+d9+w7) - S(y+d9+1,x+d9+w7) - (S(y+d9+h8,x+d9+1) - S(y+d9+1,x+d9+1));
    area_Q = S(y+d9+h8,x+d9+2*w7) - S(y+d9+1,x+d9+2*w7) - (S(y+d9+h8,x+d9+w7+1) - S(y+d9+1,x+d9+w7+1));
    
    % compute features value
    F1 = area_B - area_A;
    F2 = area_D - (area_C + area_E);
    F3 = area_G - (area_F + area_H);
    F4 = area_J + area_K - (area_I + area_L);
    F5 = area_N - (area_M + area_O);
    F6 = area_Q - area_P;
    
    % cumulate the computed values
    FEAT_FACE = [FEAT_FACE; [F1 F2 F3 F4 F5 F6]];
    
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
    %F1
    area_A = S(y+d1+h1,x+d2+w1) - S(y+d1+1,x+d2+w1) - (S(y+d1+h1,x+d2+1) - S(y+d1+1,x+d2+1));
    area_B = S(y+2*h1+d1,x+w1+d2) - S(y+d1+h1+1,x+d2+w1) - (S(y+d1+2*h1,x+d2+1)-S(y+d1+h1+1,x+d2+1));
    
    % compute area of regions C, D and E for the second feature
    % HERE WE USE INTEGRAL IMAGE!
    % >> code to compute the area of regions C and E <<
    %F2
    area_C = S(y+d3+h2,x+d4+w2) - S(y+d3+1,x+d4+w2) - (S(y+d3+h2,x+d4+1) - S(y+d3+1,x+d4+1));
    area_D = S(y+d3+h2,x+d4+w2+w3) - S(y+d3+1,x+d4+w2+w3) - (S(y+d3+h2,x+d4+w2+1) - S(y+d3+1,x+d4+w2+1));
    area_E = S(y+d3+h2,x+d4+2*w2+w3) - S(y+d3+1,x+d4+2*w2+w3) - (S(y+d3+h2,x+d4+w2+w3+1) - S(y+d3+1,x+d4+w2+w3+1));
     %New configurations
     %F3
    area_F = S(y+d5+h3,x+d5+w4) - S(y+d5+1,x+d5+w4) - (S(y+d5+h3,x+d5+1) - S(y+d5+1,x+d5+1));
    area_G = S(y+h3+h4+d5,x+w4+d5) - S(y+d5+h3+1,x+d5+w4) - (S(y+d5+h3+h4,x+d5+1)-S(y+d5+h3+1,x+d5+1));
    area_H = S(y+2*h3+h4+d5,x+w4+d5) - S(y+d5+h3+h4+1,x+d5+w4) - (S(y+d5+2*h3+h4,x+d5+1)-S(y+d5+h3+h4+1,x+d5+1));
    %F4
    area_I = S(y+d6+h5,x+d6+w5) - S(y+d6+1,x+d6+w5) - (S(y+d6+h5,x+d6+1) - S(y+d6+1,x+d6+1));
    area_J = S(y+d6+h5,x+d6+2*w5) - S(y+d6+1,x+d6+2*w5) - (S(y+d6+h5,x+d6+w5+1) - S(y+d6+1,x+d6+w5+1));
    area_K = S(y+2*h5+d6,x+w5+d6) - S(y+d6+h5+1,x+d6+w5) - (S(y+d6+2*h5,x+d6+1)-S(y+d6+h5+1,x+d6+1));
    area_L = S(y+2*h5+d6,x+2*w5+d6) - S(y+d6+h5+1,x+d6+2*w5) - (S(y+d6+2*h5,x+d6+w5+1)-S(y+d6+h5+1,x+d6+w5+1));
    %F5
    area_M = S(y+d7+h6,x+d8+w6) - S(y+d7+1,x+d8+w6) - (S(y+d7+h6,x+d8+1) - S(y+d7+1,x+d8+1));
    area_N = S(y+h6+h7+d7,x+w6+d8) - S(y+d7+h6+1,x+d8+w6) - (S(y+d7+h6+h7,x+d8+1)-S(y+d7+h6+1,x+d8+1));
    area_O = S(y+2*h6+h7+d7,x+w6+d8) - S(y+d7+h6+h7+1,x+d8+w6) - (S(y+d7+2*h6+h7,x+d8+1)-S(y+d7+h6+h7+1,x+d8+1));
    %F6
    area_P = S(y+d9+h8,x+d9+w7) - S(y+d9+1,x+d9+w7) - (S(y+d9+h8,x+d9+1) - S(y+d9+1,x+d9+1));
    area_Q = S(y+d9+h8,x+d9+2*w7) - S(y+d9+1,x+d9+2*w7) - (S(y+d9+h8,x+d9+w7+1) - S(y+d9+1,x+d9+w7+1));
    
    % compute features value
    F1 = area_B - area_A;
    F2 = area_D - (area_C + area_E);
    F3 = area_G - (area_F + area_H);
    F4 = area_J + area_K - (area_I + area_L);
    F5 = area_N - (area_M + area_O);
    F6 = area_Q - area_P;
    
    % cumulate the computed values
    FEAT_NON_FACE = [FEAT_NON_FACE; [F1 F2 F3 F4 F5 F6]];
    
end

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
    %F1
    area_A = S(y+d1+h1,x+d2+w1) - S(y+d1+1,x+d2+w1) - (S(y+d1+h1,x+d2+1) - S(y+d1+1,x+d2+1));
    area_B = S(y+2*h1+d1,x+w1+d2) - S(y+d1+h1+1,x+d2+w1) - (S(y+d1+2*h1,x+d2+1)-S(y+d1+h1+1,x+d2+1));
    
    % compute area of regions C, D and E for the second feature
    % HERE WE USE INTEGRAL IMAGE!
    %F2
    area_C = S(y+d3+h2,x+d4+w2) - S(y+d3+1,x+d4+w2) - (S(y+d3+h2,x+d4+1) - S(y+d3+1,x+d4+1));
    area_D = S(y+d3+h2,x+d4+w2+w3) - S(y+d3+1,x+d4+w2+w3) - (S(y+d3+h2,x+d4+w2+1) - S(y+d3+1,x+d4+w2+1));
    area_E = S(y+d3+h2,x+d4+2*w2+w3) - S(y+d3+1,x+d4+2*w2+w3) - (S(y+d3+h2,x+d4+w2+w3+1) - S(y+d3+1,x+d4+w2+w3+1));  
     %New configurations
     %F3
    area_F = S(y+d5+h3,x+d5+w4) - S(y+d5+1,x+d5+w4) - (S(y+d5+h3,x+d5+1) - S(y+d5+1,x+d5+1));
    area_G = S(y+h3+h4+d5,x+w4+d5) - S(y+d5+h3+1,x+d5+w4) - (S(y+d5+h3+h4,x+d5+1)-S(y+d5+h3+1,x+d5+1));
    area_H = S(y+2*h3+h4+d5,x+w4+d5) - S(y+d5+h3+h4+1,x+d5+w4) - (S(y+d5+2*h3+h4,x+d5+1)-S(y+d5+h3+h4+1,x+d5+1));
    %F4
    area_I = S(y+d6+h5,x+d6+w5) - S(y+d6+1,x+d6+w5) - (S(y+d6+h5,x+d6+1) - S(y+d6+1,x+d6+1));
    area_J = S(y+d6+h5,x+d6+2*w5) - S(y+d6+1,x+d6+2*w5) - (S(y+d6+h5,x+d6+w5+1) - S(y+d6+1,x+d6+w5+1));
    area_K = S(y+2*h5+d6,x+w5+d6) - S(y+d6+h5+1,x+d6+w5) - (S(y+d6+2*h5,x+d6+1)-S(y+d6+h5+1,x+d6+1));
    area_L = S(y+2*h5+d6,x+2*w5+d6) - S(y+d6+h5+1,x+d6+2*w5) - (S(y+d6+2*h5,x+d6+w5+1)-S(y+d6+h5+1,x+d6+w5+1));
    %F5
    area_M = S(y+d7+h6,x+d8+w6) - S(y+d7+1,x+d8+w6) - (S(y+d7+h6,x+d8+1) - S(y+d7+1,x+d8+1));
    area_N = S(y+h6+h7+d7,x+w6+d8) - S(y+d7+h6+1,x+d8+w6) - (S(y+d7+h6+h7,x+d8+1)-S(y+d7+h6+1,x+d8+1));
    area_O = S(y+2*h6+h7+d7,x+w6+d8) - S(y+d7+h6+h7+1,x+d8+w6) - (S(y+d7+2*h6+h7,x+d8+1)-S(y+d7+h6+h7+1,x+d8+1));
    %F6
    area_P = S(y+d9+h8,x+d9+w7) - S(y+d9+1,x+d9+w7) - (S(y+d9+h8,x+d9+1) - S(y+d9+1,x+d9+1));
    area_Q = S(y+d9+h8,x+d9+2*w7) - S(y+d9+1,x+d9+2*w7) - (S(y+d9+h8,x+d9+w7+1) - S(y+d9+1,x+d9+w7+1));
    
    % compute features value
    F1 = area_B - area_A;
    F2 = area_D - (area_C + area_E);
    F3 = area_G - (area_F + area_H);
    F4 = area_J + area_K - (area_I + area_L);
    F5 = area_N - (area_M + area_O);
    F6 = area_Q - area_P;
    
    % cumulate the computed values
    FEAT_TEST = [FEAT_TEST; [F1 F2 F3 F4 F5 F6]];
    
end


%% Train a k-nn classifier and test the new windows
features = [FEAT_FACE; FEAT_NON_FACE];
Group = [repmat(1, length(FEAT_FACE), 1); repmat(2, length(FEAT_NON_FACE), 1)];
% Call the function knnclassify
clase = knnclassify(FEAT_TEST,features,Group);

XY_FACE = XY_TEST(find(clase==1),:);
XY_NON_FACE = XY_TEST(find(clase==2),:);


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