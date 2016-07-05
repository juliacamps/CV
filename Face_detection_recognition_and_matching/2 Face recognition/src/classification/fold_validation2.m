function [auxACC, confMat, bestK, clases] = fold_validation2(features, labels, NFolds, ks)
% FOLD VALIDATION: compute the classification rates of validation after
%classification.
% Inputs:
% features: each columns is a sample and each row is a variable or feature:
% Variables x Samples
% labels: 1xS it contains all the labels (1 patients, 0 controls)
% subjects
% F: F fold validation will be used
% Outputs: vectors containing the rates of validation after classification.
%% K-Fold
data = features';
labels = labels';
kfolds = [];
partialIndexes = (1:1:size(data,1));
partialK = NFolds;
for i=1:1:NFolds
    newIndexes = partialIndexes(randperm(size(partialIndexes,2), ... 
    ceil( double(size(partialIndexes,2)/partialK))));
    kfolds{end+1} = newIndexes;
    partialK = partialK - 1;
    partialIndexes = setdiff(partialIndexes,newIndexes);
end
bestK = 1;
bestACC = 0;
for j=1:1:size(ks,2) 
    auxACC = zeros(1,NFolds);
    for n=1:1:NFolds
        trainI = cell2mat(kfolds(setdiff((1:1:NFolds),n)));
        testI = kfolds{n};

        trainX = data(trainI,:);
        trainY = labels(trainI);
        testX = data(testI,:);
        testY = labels(testI);

        Result_labels = knnclassify(testX,trainX,trainY,ks(j));
        
        auxACC(n) = mean(testY==Result_labels);
        
    end
    if (mean(auxACC)>bestACC)
        bestK = ks(j);
        bestACC = mean(auxACC);
    end
    
end
clases = unique(labels);
confMat = zeros(length(clases));
for n=1:1:NFolds
    trainI = cell2mat(kfolds(setdiff((1:1:NFolds),n)));
    testI = kfolds{n};

    trainX = data(trainI,:);
    trainY = labels(trainI);
    testX = data(testI,:);
    testY = labels(testI);

    Result_labels = knnclassify(testX,trainX,trainY,bestK);

    auxACC(n) = mean(testY==Result_labels);

    for i = 1:length(clases)
       for j = 1:length(clases)
          confMat(i,j) = confMat(i,j)+sum((Result_labels==clases(i)).*(testY==clases(j)));
       end
    end

end

end





