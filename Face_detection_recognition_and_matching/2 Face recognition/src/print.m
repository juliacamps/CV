function [final] = print( rates )
%PRINT Summary of this function goes here
%   Detailed explanation goes here

conf = rates.ConfusionMatrix(:,1:floor(size(rates.ConfusionMatrix,2)/2));
labels = rates.clases;
final={'\begin{center}';...
    '\def\arraystretch{0.5}'};
text = '\begin{longtable}{';
for i=1:size(conf,1)+2
    text = strcat(text,' p{0.005cm}');
end
final=[final;strcat(text,'|}')];
final=[final;strcat('& & \multicolumn{',num2str(size(conf,2)),'}{ c }{\textit{True Subjects}} \\[1ex]')];
text = strcat('& & \multicolumn{1}{|p{0.005cm}}{',num2str(labels(1)),'}');
for i=2:1:size(conf,2)
    text = strcat(text,' & \multicolumn{1}{p{0.005cm}}{',num2str(labels(i)),'}');
end
final=[final;strcat(text,'\\ [1ex]\cline{2-',num2str(size(conf,1)+2),'}')];
final=[final;'\endhead'];
final=[final;strcat('\parbox[t]{2mm}{\multirow{',num2str(size(conf,1)),'}{*}{\rotatebox[origin=c]{90}{\textit{Predicted Subjects}}}}')];
for i=1:1:size(conf,1)
    text = strcat('& \multicolumn{1}{|c|}{',num2str(labels(i)),'}');
    for j=1:1:size(conf,2)
        if(i==j)
            aux =strcat('\cellcolor[HTML]{11AA11}{',num2str(conf(i,j)),'}');
        else
            aux = num2str(conf(i,j));
        end
        text = strcat(text,' & ',aux);
    end
    final=[final;strcat(text,'\\')];
end
final = [final;'\\';'\caption{Confusion matrix} \label{confMat} \\';'\end{longtable}';'\end{center}'];

offset = floor(length(rates.clases)/2);
conf = rates.ConfusionMatrix(:,offset:end);
final=[final;'\begin{center}';...
    '\def\arraystretch{0.5}'];
text = '\begin{longtable}{';
for i=1:size(conf,1)+2
    text = strcat(text,' p{0.005cm}');
end
final=[final;strcat(text,'|}')];
final=[final;strcat('& & \multicolumn{',num2str(size(conf,2)),'}{ c }{\textit{True Subjects}} \\[1ex]')];
text = strcat('& & \multicolumn{1}{|p{0.005cm}}{',num2str(labels(offset+1)),'}');
for i=2:1:size(conf,2)-1
    text = strcat(text,' & \multicolumn{1}{p{0.005cm}}{',num2str(labels(i+offset)),'}');
end
final=[final;strcat(text,'\\[1ex] \cline{2-',num2str(size(conf,2)+2),'}')];
final=[final;'\endhead'];
final=[final;strcat('\parbox[t]{2mm}{\multirow{',num2str(size(conf,1)),'}{*}{\rotatebox[origin=c]{90}{\textit{Predicted Subjects}}}}')];
for i=1:1:size(conf,1)
    text = strcat('& \multicolumn{1}{|c|}{',num2str(labels(i)),'}');
    for j=2:1:size(conf,2)
       if(i==(j+offset-1))
            aux =strcat('\cellcolor[HTML]{11AA11}{',num2str(conf(i,j)),'}');
        else
            aux = num2str(conf(i,j));
        end
        text = strcat(text,' & ',aux);
    end
    final=[final;strcat(text,'\\')];
end
final = [final;'\\';'\caption{Confusion matrix} \label{confMat} \\';'\end{longtable}';'\end{center}'];

end

