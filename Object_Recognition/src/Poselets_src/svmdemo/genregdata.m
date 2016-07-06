function [x,y] = genregdata(n)
% GENREGDATA  Generate regression data

sigma = .4 ;
x = rand(1,n) ;
y = sin(8*x) + sigma * randn(size(x)) ;
