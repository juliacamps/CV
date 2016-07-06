function model = svmregdemo(X, y, kernel, C, epsilon, gamma)
% SVMREGDEMO  Demos the SVM regression code
%   First generate some training data X, Y by using GENREGDATA(). Then try:
%
%   SVMREGDEMO(X, Y, 'LINEAR', C, EPSILON) where C is the SVM C
%   parameter and EPLSILON the parameter of the epsilon-insensitive
%   loss.
%
%   SVMREGDEMO(X, Y, 'RBF', C, EPSILON, GAMMA) where GAMMA is the RBF
%   GAMMA parameter
%
%   Restet the random number generator to run twice on the same
%   data. E.g.:
%
%     randn('state', 1) ;
%     rand('state', 1) ;
%     [X,y] = genregdata(15) ;
%
%     figure(1) ;
%     svmregdemo(X, y, 'linear', 10, .1) ;
%
%     figure(2) ;
%     svmregdemo(X, y, 'rbf', 10, .1, 2) ;
%
%   See also:: SVMREG().
%
%   Author:: Andrea Vedaldi <vedaldi@robots.ox.ac.uk>

% --------------------------------------------------------------------
%                                                       SVM parameters
% --------------------------------------------------------------------

if nargin < 3, kernel = 'linear' ; end
if nargin < 4, C = 10 ; end
if nargin < 5, epsilon = .1 ; end
if nargin < 6, gamma = 1 ; end

% --------------------------------------------------------------------
%                                                             Training
% --------------------------------------------------------------------

switch kernel
  case 'linear'
    K = X'*X ;
  case 'rbf'
    K = exp(- gamma * pdist2(X,X)) ;
end
model = svmreg(K,y,C,epsilon) ;

% --------------------------------------------------------------------
%                                                              Testing
% --------------------------------------------------------------------

X_dense = linspace(0,1,250) ;
switch kernel
  case 'linear'
    K_dense = X(model.svind)' * X_dense ;
  case 'rbf'
    K_dense = exp(- gamma * pdist2(X(model.svind), X_dense)) ;
end
y_dense = model.alphaE(model.svind)' * K_dense + model.b ;

cla ;
plot(X, y,'c.','markersize',10) ;
hold on ;
h1=plot(X_dense,y_dense,'b','linewidth',2) ;
h2=plot(X_dense,y_dense+epsilon,'g-') ;
h3=plot(X_dense,y_dense-epsilon,'r-') ;

h4=plot(X(model.svind),y(model.svind),'ko')  ;
h5=plot(X(model.bndind),y(model.bndind),'kx','markersize',10) ;
legend([h1 h2 h3 h4 h5], ...
       'est. func.', ...
       '+\epsilon', ...
       '-\epsilon', ...
       'supp. vec.', ...
       'margin. vec.', ...
       'location', 'northeastoutside') ;
switch kernel
  case 'linear'
    title(sprintf('linear \\epsilon = %.2g C = %.2g', epsilon, C)) ;
  case 'rbf'
    title(sprintf('rbf \\epsilon = %.2g C = %.2g \\gamma = %.2g', epsilon, C, gamma)) ;
end
