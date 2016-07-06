%% Reset all
clear all;
close all;
clc;
%% Move to working directory
tmp = matlab.desktop.editor.getActive;
cd(fileparts(tmp.Filename));
%% Load Data
mnist = load('svmdemo\mnist_all.mat');
rangeSize = size(mnist.train0,1);
for i=0:1:9
    size1 = size(eval(['[' sprintf('mnist.train%d; ', i) ']']),1);
	rangeSize = min([rangeSize,size1]);
end

%% Train SVM with 100 random samples and a linear kernel with different
% values of C: 0.01, 0.1, 1, 2 and 4
% Static definitions
kernel = 'linear';
num_instances = 100;
perm = randperm(rangeSize,num_instances);
C = [0.000001,0.00001,0.0001];

%% Train SVM with 500 random samples and a linear kernel with different
% values of C: 0.01, 0.1, 1, 2 and 4
% Static definitions
% num_instances = 500;
% perm = randperm(rangeSize,num_instances);
% C = [0.000001,0.00001,0.0001];

%% RBF
% kernel = 'rbf';
% gamma = 10;
% C = [0.000001,0.00001,0.0001];
%% Evaluation
bestResults = [];
for j=0:1:9
% j=0;
    Dtrain1 = eval(['[' sprintf('mnist.train%d; ', j) ']']);
    Dtest1  = eval(['[' sprintf('mnist.test%d; ', j) ']']);
    new_bestResults = [];
    for n=0:1:9
% n=1;
        Dtrain2 = eval(['[' sprintf('mnist.train%d; ', n) ']']);
        Dtest2  = eval(['[' sprintf('mnist.test%d; ', n) ']']);
        Xp_train=Dtrain1(perm,:)';
        Xn_train=Dtrain2(perm,:)';
        Xp_test=Dtest1';
        Xn_test=Dtest2';
        Xtrain = double([Xp_train Xn_train]);
        Xtest = double([Xp_test Xn_test]);
        y_train = [ones(size(Xp_train,2),1); -ones(size(Xn_train,2),1)]';
        y_test =  [ones(size(Xp_test,2),1); -ones(size(Xn_test,2),1)]';
        switch kernel
            case 'linear'
                K = Xtrain'*Xtrain ;
            case 'rbf'
                K = exp(- gamma * pdist2(Xtrain,Xtrain)) ;
        end
        %K = Xtrain' * Xtrain;
        best_accuracy = 0.0;
        confMat = [0,0;0,0];
        bestResult = struct('accuracy',best_accuracy,'confMat',confMat,'C',0.0);
        for i=1:1:size(C,2)
            model = svm(K,y_train,C(i));
            switch kernel
              case 'linear'
                K_dense = Xtrain(:,model.svind)' * Xtest;
              case 'rbf'
                K_dense = exp(- gamma * pdist2(X(:,model.svind), Xtest)) ;
            end
            y_pred = model.alphay(model.svind)' * K_dense + model.b;
            sign_y_pred = sign(y_pred);
            [new_confMat,~] = confusionmat(y_test, sign_y_pred);
            %new_confMat = confusionMatrix(sign_y_pred, y_test);
            new_accuracy = sum(sign_y_pred==y_test)./length(y_pred);
			% plot(sign(y_pred))
            if new_accuracy > best_accuracy
                bestResult = struct('Name',strcat(int2str(j),' vs ',int2str(n)),...
                    'accuracy',new_accuracy,'confMat',new_confMat,'C',C(i));
            end
        end
        new_bestResults = [new_bestResults, bestResult];
    end
    bestResults = [bestResults; new_bestResults];
end

criticSort = reshape(bestResults,1,[]);
[aux, order]=sortrows({criticSort.accuracy}');
criticSort=criticSort(order);
for i=1:10
    criticSort(i).Name
end