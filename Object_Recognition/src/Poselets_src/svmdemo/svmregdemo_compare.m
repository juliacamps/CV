% Runs several demos in sequence

n = 16 ;
epsilon = .25 ;

randn('state', 1) ;
rand('state', 1) ;
[X, y] = genregdata(n) ;

% linear kernel
figure(1) ; clf ;
Cr = [1 5 10] ;

t = 0 ;
for C = Cr
  t = t + 1 ;
  subplot(3,1,t) ;
  svmregdemo(X, y, 'linear', C, epsilon) ;
end

% RBF kernel
figure(2) ; clf ;
Cr = [1 10 100] ;
gammar = [1 5 50] ;

t = 0 ;
for C = Cr
  for gamma = gammar
    t = t + 1 ;
    subplot(3,3,t) ;
    svmregdemo(X, y, 'rbf', C, epsilon, gamma) ;
  end
end

