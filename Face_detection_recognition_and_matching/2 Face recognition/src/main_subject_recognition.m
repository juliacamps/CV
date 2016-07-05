% Computational Vision
% Practicum Face Recognition: Subject recognition
%
% Student name: Julia Camps Sereix
%
% >> OBJECTIVE: 
% 1)Complete this function to solve the subject recognition problem

% main function
function main_subject_recognition()
clc; close all; clear;
%% These sub-directories are required
addpath(genpath('feature_extraction'))
addpath(genpath('classification'))
%% Load database of images and analyze the structure
ARFace = importdata('ARFace.mat');
%% Define the training set and test set from the data set using:
images = ARFace.internal;
labels = ARFace.person;
    
%% Atention! We will use the dataset in the representation: Sample x Variables (Samples x 1188):
images = images';
labels = labels';
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
Rates_pca = validation2(mat_features_pca', labels', F, [1,3,5,7]);
display(Rates_pca)
% When I tried to use more than 10 attributes the knn function crashed for
% exceeding the number of allowed attributes in matlab knn funcion
Rates_pca95 = validation2(mat_features_pca95(:,1:10)', labels', F, [1,3,5,7]);
display(Rates_pca95)
Rates_lda = validation2(mat_features_lda(:,1:10)', labels', F, [1,3,5,7]);
display(Rates_lda)
% Code for generating the latex confusion matrix tables
aux1 = print(Rates_pca);
aux2 = print(Rates_pca95);
aux3 = print(Rates_lda);
end



