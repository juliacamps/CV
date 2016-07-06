function [ at_listNew eigVal transData] = representPCA(dataMat, clusArr, at_listPar, dataset)
%Function that given an clurstering representation in array format, and a
%data matrix, plots the data reducing its dimensionality to 3-D
    %Atributes treatment
    if ~exist('dataMat'),
        disp('Error: No data specified');
        return;
    end
    if ~exist('clusArr'),
        clusArr = ones(1,size(dataMat,2));
    end
    if ~exist('at_listPar'),
        at_listPar = ones(size(dataMat,2),1);
    end
    if ~exist('dataset'),
        dataset = 'unknown';
    end
    
    %core function
    figure;
    num_PCs=3;
    [eigVec transData eigVal at_listNew] = myPCA(dataMat, at_listPar);
    x = transData(:,1);
    y = transData(:,2);
    z = transData(:,3);
    gscatter3(x,y,z,clusArr);
    title(['PCA on dataset ',dataset,', reducing from ',num2str(length(at_listNew)), ...
        ' dimensions, to ',num2str(num_PCs),' dimensions']);
    xlabel(['PC1-(',num2str(round(eigVal(1)/sum(eigVal)*100)),'%)']);
    ylabel(['PC2-(',num2str(round(eigVal(2)/sum(eigVal)*100)),'%)']);
    zlabel(['PC3-(',num2str(round(eigVal(3)/sum(eigVal)*100)),'%)']);



end

