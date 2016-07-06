% SVMREGDEMO_RBF

n = 25 ;
epsilon = .25 ;
C = 10 ;
gamma = 5 ;

randn('state' ,1) ;
rand('state', 1) ;
[x,y] = genregdata(n) ;

figure(1) ;
svmregdemo(x, y, 'rbf', C, epsilon, gamma) ;
