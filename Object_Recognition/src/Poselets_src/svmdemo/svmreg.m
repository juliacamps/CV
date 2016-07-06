function model = svmreg(K,y,C,epsilon)
% SVMREG  Learns non-linear SVM regressor model
%   MODEL = SVMREG(K, Y, C, EPSILON) where K is the Gram matrix, Y the
%   label vector, C the SMV constant, and EPSILON the
%   epsilon-insensitive loss parameter. The function optimizes the
%   dual problem
%
%   min_{alpha} .5 * alpha' E K E alpha + epslon 1' * alpha - y'E alpha
%      s.t.   0 <= alpha <= C,
%             E alpha = 0.
%
%   where 1 is a vector of all ones and E = [I, -I] and I is the
%   identity matrix.
%
%   Recall that, given data points X(1), ..., X(N), their Gram matrix
%   is the matrix of all inner products (kernel evaluations):
%
%     K(i,j) = kernel(X(i), X(j)).
%
%   The vecotr Y is a N dimensional vector of real values.
%
%   The function returns a structure MODEL with the following fields:
%
%   MODEL.ALPHA::
%     Minimizer of the dual problem.
%
%   MODEL.ALPHAE::
%     Coefficients E * ALPHA for the support vector expansion.
%
%   MODEL.SVIND::
%     Indexes of the support vectors (points I for which ABS(ALPHAE(I)) >
%     0).
%
%   MODEL.BNDIND::
%     Indexes of the vectors on the decision boundary (points I for
%     which 0 < ABS(ALPHA(I)) < C).
%
%   MODEL.B::
%     SVM offset.
%
%   Given a new test point X(TEST) the SVM can be evaluated as:
%
%      sum_{I in SVIND} ALPHAE(I) kernel(X(I), X(TEST)) + B
%
%   Author:: Andrea Vedaldi (vedaldi@robots.ox.ac.uk)

n = numel(y) ;
tol = 1e-3 ;
E = [eye(n), - eye(n)] ;
alpha = quadprog(E'*K*E, epsilon - E'*y', ...
                 [], [], ...
                 ones(1,n) * E, 0, ...
                 zeros(2*n,1), C * ones(2*n,1), ...
                 [], optimset('Display','on', ...
                              'LargeScale', 'on', ...
                              'TolFun',1e-10, ...
                              'MaxIter', 1e3)) ;

model.alpha = alpha ;
model.alphaE = E * alpha ;
model.svind = find(abs(model.alphaE) > tol * C) ;
model.bndind = find(abs(model.alphaE) > tol * C & ...
                    abs(model.alphaE) < (1 - tol) * C) ;
model.bndsgn = sign(model.alphaE(model.bndind)) ;


if ~ isempty(model.bndind)
  model.b = mean(y(model.bndind) - model.alphaE' * K(:,model.bndind) - ...
               epsilon * model.bndsgn') ;
else
  % Special cases to deal with the case in which C is very small
  % and there are no support vectors on the margin.

  f = model.alphaE' * K ;

  act = ismember(1:n, model.svind) ;
  pos = model.alphaE' > 0 ;

  % inactive constraints:
  %  y - e <= f(x)+b <= y + e  [for all inactive constraints]
  %  y - e - f(x) <= b <= y + e -f(x)
  bmax = min(y(~act) + epsilon - f(~act)) ;
  bmin = max(y(~act) - epsilon - f(~act)) ;

  % active constraints from below [alphaE > 0]
  % f(x)+b <= y-e   ==> b <= y-e-f(x)
  bmax = min([bmax, y(act& pos) - epsilon - f(act& pos)]) ;

  % active constraints above [alphaE < 0]
  % f(x)+b >= y+e   ==> b >= y+e-f(x)
  bmin = max([bmin, y(act&~pos) + epsilon - f(act&~pos)]) ;

  if sum(act&pos) > sum(act&~pos)
    model.b = bmax ;
  elseif sum(act&pos) < sum(act&~pos)
    model.b = bmin ;
  else
    model.b = mean([bmin bmax]) ;
  end
end
