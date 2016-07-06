% SVMDEMO_PRINT
figure(1) ; clf ;
svmdemo_linear ;

set(gcf,'paperunits','normalized','paperposition',[0 0 .65 .65]) ;
print('-dpng', 'linear.png', '-r300') ;
system('convert -transparent ''#ffffff'' -trim -resize 30% linear.png linear.png') ;

figure(2) ; clf ;
svmdemo_rbf ;

set(gcf,'paperunits','normalized','paperposition',[0 0 .65 .65]) ;
print('-dpng', 'rbf.png', '-r300') ;
system('convert -transparent ''#ffffff'' -trim -resize 30% rbf.png rbf.png') ;



