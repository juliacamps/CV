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
% values of C: 0.0001,0.0003,0.0005
% Static definitions
% kernel = 'linear';
% num_instances = 100;
% permSmall = randperm(rangeSize,num_instances);
% permBig = randperm(rangeSize,num_instances);
% gamma = [1];
% C = [0.1, 1, 10, 100, 1000, 10000];

%% Train SVM with 500 random samples and a linear kernel with different
% values of C: 0.0001,0.0003,0.0005
% Static definitions
kernel = 'linear';
num_instances = 500;
permSmall = randperm(rangeSize,num_instances);
permBig = randperm(rangeSize,num_instances);
gamma = [1];
C = [0.01, 0.1, 1, 10];

%% Train SVM with 100 random samples and a RBF kernel with different
% values of C: 0.0001,0.0003,0.0005
% kernel = 'rbf';
% num_instances = 100;
% permSmall = randperm(rangeSize,num_instances);
% permBig = randperm(rangeSize,num_instances);
% gamma = [0.0001,0.001,0.01];%,0.1,1,10];%provar mes petita
% C = [ 5, 10, 100, 1000];%,0.01,1,10,100];

%% Evaluation
bestResults = [];
DtrainAll = [];
DtrainSmall = [];
Dtrain = [];
Dtest = [];
DtrainAux = [];
DtestAux = [];
DtestIndex = [0];
y_pred = [];
% Test instances
for i=0:1:9
    DtrainAux = double(eval(['[' sprintf('mnist.train%d; ', i) ']']));
    permBig = randperm(size(DtrainAux,1),num_instances);
    
    DtrainAll(:,:,i+1) = DtrainAux(permBig,:);
    
    DtestAux = double(eval(['[' sprintf('mnist.test%d; ', i) ']']));
    DtestIndex = [DtestIndex, size(Dtest,1)+size(DtestAux,1)];
    Dtest  = [Dtest; DtestAux];
end

% Normalize the data
DtrainAll = (DtrainAll-min(min(min(DtrainAll))))./(max(max(max(DtrainAll)))-min(min(min(DtrainAll))));
for i=0:1:9
    permSmall = randperm(size(permBig,2),num_instances);
    DtrainSmall = [DtrainSmall; DtrainAll(permSmall,:,i+1)];
end
Dtest = (Dtest-min(min(Dtest)))./(max(max(Dtest))-min(min(Dtest)));


DtestIndex = [DtestIndex, DtestIndex(end)+1];

y_train = [ones(1,size(permBig,2)),-ones(1,num_instances*9)];
y_test = zeros(1,size(Dtest,1));

%%
new_bestResults = [];
for j=0:1:9
%     y_train(1:end) = 0;
    % Positive train instances
    Xp_train = DtrainAll(:,:,j+1)';
%     y_train(j*100+1:(j+1)*100) = 1;
    
    % Negative train instances
    Xn_train = [DtrainSmall(1:j*num_instances,:);DtrainSmall((j+1)*num_instances+1:end,:)]';
%     y_train(1:j*100) = -1;
%     y_train((j+1)*100+1:end)= -1;
    
    % Positive test instances
    % Xp_test = Dtest((DtestIndex(j+1)+1:DtestIndex(j+2)),:)';
    testPosIndexes = DtestIndex(j+1)+1:DtestIndex(j+2);
    y_test(DtestIndex(j+1)+1:DtestIndex(j+2)) = 1;
    
    % Negative test instances
    % Xn_test = [Dtest(1:DtestIndex(j+1),:);Dtest(DtestIndex(j+2)+1:end,:)]';
    y_test(1:DtestIndex(j+1)) = -1;
    y_test(DtestIndex(j+2)+1:end) = -1;

    Xtrain = double([Xp_train Xn_train]);
    Xtest = double(Dtest');
    
    best_accuracy = 0.0;
    confMat = [0,0;0,0];
    
    bestResult = struct('accuracy',best_accuracy,'confMat',confMat,'C',0.0);
    for g=1:1:size(gamma,2)
        switch kernel
          case 'linear'
            K = Xtrain'*Xtrain ;
          case 'rbf'
            K = exp(- gamma(g) * pdist2(Xtrain,Xtrain)) ;
        end
        for i=1:1:size(C,2)
            model = svm(K,y_train,C(i));
            switch kernel
              case 'linear'
                K_dense = Xtrain(:,model.svind)' * Xtest;
              case 'rbf'
                K_dense = exp(- gamma(g) * pdist2(Xtrain(:,model.svind), Xtest)) ;
            end
            y_pred = model.alphay(model.svind)' * K_dense + model.b;
            sign_y_pred = sign(y_pred);
            sign_y_pred(sign_y_pred==0) = 1;
%             [new_confMat,~] = confusionmat(y_test, sign_y_pred);
            new_confMat = [sum((sign(y_pred)==y_test) & (y_test==1)), ...
                sum((sign(y_pred)~=y_test) & (y_test==-1));...
                sum((sign(y_pred)~=y_test) & (y_test==1)),...
                sum((sign(y_pred)==y_test) & (y_test==-1))];
            new_accuracy = sum(sign(y_pred)==y_test)./length(y_pred)
            if new_accuracy > best_accuracy
                posYpred = find(sign(y_pred)==1);
                denom = size(posYpred,2);
                best_accuracy = new_accuracy;
                bestResult = struct('Name',int2str(j),...
                'accuracy',new_accuracy,'confMat',new_confMat,'C',C(i),...
                'Gamma',gamma(g),...
                'd0',(double(length(intersect((DtestIndex(0+1)+1:DtestIndex(0+2)),posYpred))/denom)),...
                'd1',(double(length(intersect((DtestIndex(1+1)+1:DtestIndex(1+2)),posYpred))/denom)),...
                'd2',(double(length(intersect((DtestIndex(2+1)+1:DtestIndex(2+2)),posYpred))/denom)),...
                'd3',(double(length(intersect((DtestIndex(3+1)+1:DtestIndex(3+2)),posYpred))/denom)),...
                'd4',(double(length(intersect((DtestIndex(4+1)+1:DtestIndex(4+2)),posYpred))/denom)),...
                'd5',(double(length(intersect((DtestIndex(5+1)+1:DtestIndex(5+2)),posYpred))/denom)),...
                'd6',(double(length(intersect((DtestIndex(6+1)+1:DtestIndex(6+2)),posYpred))/denom)),...
                'd7',(double(length(intersect((DtestIndex(7+1)+1:DtestIndex(7+2)),posYpred))/denom)),...
                'd8',(double(length(intersect((DtestIndex(8+1)+1:DtestIndex(8+2)),posYpred))/denom)),...
                'd9',(double(length(intersect((DtestIndex(9+1)+1:DtestIndex(9+2)),posYpred))/denom)));
            end
        end
    end
    new_bestResults = [new_bestResults, bestResult];
end
if ~isempty(new_bestResults)
    bestResults = [bestResults, new_bestResults];
end


criticSort = bestResults;
[aux, order]=sortrows({criticSort.accuracy}');
criticSort=criticSort(order);
criticSumary = [];
switch kernel
  case 'linear'
   auxStr = cellstr(['Classifications',' & ','Accuracy',' & ','Confusion Matrix',' & ',...
    'Best C value','  \\ \hline']);
    for i=1:1:length(criticSort)
        criticSumary = [criticSumary,criticSort(i)];
        aux = criticSort(i);
        auxStr = [auxStr; aux.Name,' & ',num2str(aux.accuracy),' & ',...
            mat2str(aux.confMat),' & ',num2str(aux.C),'  \\ \hline'];
    end
  case 'rbf'
    auxStr = cellstr(['Classifications',' & ','Accuracy',' & ','Confusion Matrix',' & ',...
    'Best C value',' & ','Gamma','  \\ \hline']);
    for i=1:1:length(criticSort)
        criticSumary = [criticSumary,criticSort(i)];
        aux = criticSort(i);
        auxStr = [auxStr; aux.Name,' & ',num2str(aux.accuracy),' & ',...
            mat2str(aux.confMat),' & ',num2str(aux.C),' & ',...
            num2str(aux.Gamma),'  \\ \hline'];
    end
end
auxStr

auxStr2 = cellstr(['Digit',' & ','0',' & ','1',' & ','2',' & ','3',...
    ' & ','4',' & ','5',' & ','6',' & ','7',' & ','8',' & ','9','  \\ \hline']);
for i=1:1:length(bestResults)
    aux = bestResults(i);
    auxStr2 = [auxStr2; '\multicolumn{1}{ |c||  }{\textbf{',num2str(aux.Name),'}}',' & ',num2str(round(aux.d0*100,2)),' & ',...
       num2str(round(aux.d1*100,2)),' & ',num2str(round(aux.d2*100,2)),' & ',num2str(round(aux.d3*100,2)),...
       ' & ',num2str(round(aux.d4*100,2)),' & ',num2str(round(aux.d5*100,2)),' & ',num2str(round(aux.d6*100,2)),...
       ' & ',num2str(round(aux.d7*100,2)),' & ',num2str(round(aux.d8*100,2)),' & ',num2str(round(aux.d9*100,2)),...
       '  \\ \hline'];
end
auxStr2



