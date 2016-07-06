function [ confMat ] = confusionMatrix( predLabels, realLabels )
    PredPos = find(predLabels==1);
    PredNeg = find(predLabels==-1);
    RealPos = find(realLabels==1);
    RealNeg = find(realLabels==-1);
    TruePos = intersect(PredPos,RealPos);
    TrueNeg = intersect(PredNeg,RealNeg);
    FalsPos = intersect(PredPos,RealNeg);
    FalsNeg = intersect(PredNeg,RealPos);
    confMat = [size(TruePos,2),size(FalsPos,2);size(FalsNeg,2),size(TrueNeg,2)];
end

