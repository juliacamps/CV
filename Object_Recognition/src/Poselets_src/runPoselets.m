%% Reset all
clear all;
close all;
clc;
%% Move to working directory
tmp = matlab.desktop.editor.getActive;
cd([fileparts(tmp.Filename),'\poselets\poselets\detector']);
%% Run code
demo_poselets;