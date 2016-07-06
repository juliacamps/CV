function ej_23( filename )
    videoFReader = vision.VideoFileReader(filename);
    videoPlayer1 = vision.VideoPlayer('Name','Sobel');
    videoPlayer11 = vision.VideoPlayer('Name','Sobel');
    videoPlayer2 = vision.VideoPlayer('Name','Canny');
    videoPlayer22 = vision.VideoPlayer('Name','Canny');
    videoPlayer3 = vision.VideoPlayer('Name','Perwitt');
    videoPlayer33 = vision.VideoPlayer('Name','Perwitt');
    while ~isDone(videoFReader)
        videoFrame = step(videoFReader);
        I = rgb2gray(videoFrame);
        BW1 = edge(I,'sobel',0.063);
        BW2 = edge(I,'canny',0.31,0.95);
        BW3 = edge(I,'prewitt',0.065);
        
        edges_green1 = cat(3, BW1*0, BW1, BW1*0);
        edges_green2 = cat(3, BW2*0, BW2, BW2*0);
        edges_green3 = cat(3, BW3*0, BW3, BW3*0);

        videoFrame1 = videoFrame+edges_green1;
        videoFrame2 = videoFrame+edges_green2;
        videoFrame3 = videoFrame+edges_green3;
        videoFrame11 = edges_green1;
        videoFrame22 = edges_green2;
        videoFrame33 = edges_green3;

        step(videoPlayer1, videoFrame1);
        step(videoPlayer2, videoFrame2);
        step(videoPlayer3, videoFrame3);
        step(videoPlayer11, videoFrame11);
        step(videoPlayer22, videoFrame22);
        step(videoPlayer33, videoFrame33);
    end
    release(videoPlayer1);
    release(videoPlayer2);
    release(videoPlayer3);
    release(videoPlayer11);
    release(videoPlayer22);
    release(videoPlayer33);
    release(videoFReader);
end