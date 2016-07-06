% SVMREGDEMO_LINEAR

n = 25 ;
epsilon = .25 ;
C = 10 ;

randn('state', 1) ;
rand('state', 1) ;
[x,y] = genregdata(n) ;

figure(1) ;
svmregdemo(x, y, 'linear', C, epsilon) ;
