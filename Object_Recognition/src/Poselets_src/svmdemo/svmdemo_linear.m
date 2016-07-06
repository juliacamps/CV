% SVMDEMO_LINEAR

Np = 150 ;
Nn = 150 ;
C  = .1 ;

[X, y] = gendata(Np, Nn) ;

cla ;
model = svmdemo(X, y, 'linear', C) ;
