function Rates=validation2(features, labels, F, ks)
% VALIDATION: Validation of the classification method using F fold cross validation
% Outputs: 
% Rates, structure storing the validation rates.

% Fold validation strategy
[ACC, confMat, k, clases] = fold_validation2(features, labels, F, ks);

% Compute and store the mean rates of validation in 
% error=mean(error);
% FP=mean(FP);
% FN=mean(FN);
% % TP=mean(TP);
% TN=mean(TN);

% Rates.Sens=TP/(TP+FN)*100;
% Rates.Spec=TN/(TN+FP)*100;
% Rates.Prec=TP/(TP+FP)*100;
% Rates.FAR=FP/(TP+FN)*100;
% Rates.Recall=TP/(TP+FN)*100;
Rates.Acc=mean(ACC);
% Rates.Error=error;
Rates.ConfusionMatrix=confMat;
Rates.k=k;
Rates.clases = clases';
end


