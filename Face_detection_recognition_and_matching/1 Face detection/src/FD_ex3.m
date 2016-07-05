% Computational Vision
% 2015-2016
% Student name: Julia Camps Sereix
%
% >> OBJECTIVE:
% 1) Write the code for Exercise 3
% 2) Execute the code and check the results
% 3) Comment the experiments and results in a report

% main
function FD_ex3()
    clear all; close all; clc;
    tmp = matlab.desktop.editor.getActive;
    cd(fileparts(tmp.Filename));
    % Create the face detector object.
    faceDetector = vision.CascadeObjectDetector();
    
    videoFReader = vision.VideoFileReader('Black_or_White_face_Morphing.mp4');
    videoPlayer = vision.VideoPlayer('Name','Face Recognition');

    while ~isDone(videoFReader)
        videoFrame = step(videoFReader);
        %Face bounding box
        bbox = faceDetector.step(rgb2gray(videoFrame));
        if ~isempty(bbox)          
            videoFrame = insertShape(videoFrame, 'Rectangle', bbox);
        end
        % Display the annotated video frame using the video player object.
        step(videoPlayer, videoFrame);
    end
    release(videoPlayer);
    release(videoFReader);
    release(faceDetector);
end















