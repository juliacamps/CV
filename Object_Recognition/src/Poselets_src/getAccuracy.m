function [ accuracy ] = getAccuracy( confMat )
    accuracy = (confMat(1,1)+confMat(2,2))/sum(sum(confMat));
end

