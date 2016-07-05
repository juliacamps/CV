% Computational Vision
% Practicum Face Recognition: Gender recognition
%
% Student name: Julia Camps Sereix
%
% >> OBJECTIVE: 
% 1) Analize the code
% 2) Understand the function of each part of the code
% 3) Code the missing parts
% 4) Answer the pose questions
% 5) Execute the code 
% 6) Check the results and comment them in the report

% main function
function main_gender_recognition()

clc; close all; clear;

%% These sub-directories are required
addpath(genpath('feature_extraction'))
addpath(genpath('classification'))

%% Load database of images and analyze the structure
ARFace = importdata('ARFace.mat');

%% Prepare the data set samples identifying data and labels (male/female).
% We will use the internal faces loaded in the structure
display(ARFace)

% 1. To complete:
% Answer these questions: 
% a. Why the size of the field internal, size(ARFace.internal), is 1188 x
% 2210?
% We supose than internal is a matrix containing the images as columns,
% because we have the internalSz (internal size) which is [36 33] (36*33) =
% 1188, which matches with the number of rows we have in the matrix
% Demostration
figure; imshow(reshape(ARFace.internal(:,1),36,33));

% b. Which is the information contained in ARFace.person?
% We have each different person apearing on the images labeled with as
% different clases (subjects).
figure; 
for i=1:1:28
    subplot(7,4,i); imshow(reshape(ARFace.internal(:,i),36,33)); title(strcat('person:',num2str(ARFace.person(i))));
end
% As we can observe when the value of the label person changes, it also
% changes the person shown by the the image, and for a single value shown,
% all images are from the same person.


%% Count the number of samples and samples males and females of the data set.
% This information is in ARFace.gender ==> male == 1, female == 0
% 2. To complete:
NumberMales = sum(ARFace.gender)
NumberSamples = size(ARFace.gender,2)
NumberFemales = NumberSamples-NumberMales

%% Visualize some of the internal faces and save in bmp images
% Use the function reshape to transform the information from a vector to a
% matrix.
% 3. To complete:
for i=1:10:NumberSamples % 10 was storing too many images
    imwrite(reshape(ARFace.internal(:,i),36,33),strcat('face',num2str(i),'.bmp'));
end


%% Define the training set and test set from the data set using:
% a. Use the whole data set (an unbalanced problem)
% Build this data structure: 
%   images(:,i) is the image of sample i.
%   labels(i) is the label of sample i.
%   subjects(i) is the number of the subject of sample i.
% Use the "internal" images, we will reduce dimensionality later.


% 4. To complete:
images = ARFace.internal;
labels = ARFace.gender;
subjects = ARFace.person;
    
%% Atention! We will use the dataset in the representation: Sample x Variables (Samples x 1188):
images = images';
labels = labels';
subjects = subjects';


%% Feature Extraction using PCA
mat_features_pca = feature_extraction('PCA', images);


%% Feature Extraction using PCA (95% variance explained)
mat_features_pca95 = feature_extraction('PCA95', images);


%% Feature Extraction using LDA
mat_features_lda = feature_extraction('LDA', images, labels);


%% Classification
% Call the function validation to perform the F-fold
% cross validation with: the samples, labels, information
% about the training set subjects and F the number of folds.
F = 10;
Rates_pca = validation(mat_features_pca', labels', subjects', F, [1,3,5,7]);
display(Rates_pca)
% When I tried to use more than 10 attributes the knn function crashed for
% exceeding the number of allowed attributes in matlab knn funcion
Rates_pca95 = validation(mat_features_pca95(:,1:10)', labels', subjects', F, [1,3,5,7]);
display(Rates_pca95)
Rates_lda = validation(mat_features_lda', labels', subjects', F, [1,3,5,7]);
display(Rates_lda)

% 11. To complete:
% Answer this question: 
% Which is the best result?
% After analyzing the diferent values retreived I can conclude than the
% best results are in averages amogn the k-fold(10) with the tested data,
% obtained when running the validation code with LDA features and K-NN
% considering just the one-Nearest-Neighbor. We can afirm it after playing
% all different best k combinations among all features sets and having than
% for PCA the obtained average accuracy is 85.3846, for PCA_95 is 85.9276
% and for LDA is 99.9095 (best value without doubts).

end



