clc;
clear;
close all;
Ia = vl_impattern('roofs1');
Ib = vl_impattern('roofs2');
Ia = single(rgb2gray(Ia));
Ib = single(rgb2gray(Ib));
[fa, da] = vl_sift(Ia);
[fb, db] = vl_sift(Ib);
[matches, scores] = vl_ubcmatch(da, db);
figure;
subplot(2,2,1)
show_matches(Ia,Ib,fa,fb,matches);
title('Matches between roofs1 and roofs2');
subplot(2,2,2)
show_matches(Ia,Ib,fa,fb,random_selection(matches,50));
title('Random 50 matches between roofs1 and roofs2');
subplot(2,2,3)
[matches2, scores2] = vl_ubcmatch(da, db, 2.0);
show_matches(Ia,Ib,fa,fb,matches2);
title('Matches between roofs1 and roofs2 with 2.0 threshold');

figure;
for i=1:4
subplot(2,2,i);
threshold=2*i;
[matchesth, scoresth] = vl_ubcmatch(da, db, threshold);
show_matches(Ia,Ib,fa,fb,matchesth);
title(strcat('Matches between roof1 and roof2 with ',int2str(threshold),' threshold'));
end
figure;
subplot(2,2,1)
d = fb(1:2,matches(2,:))-fa(1:2,matches(1,:));
i = size(d, 2);
A = zeros(6,6);
b = zeros(6,1);
for j = 1:i,
x = fa(1:2,matches(1,j));
J = [x(1), x(2), 0, 0, 1, 0; 0, 0, x(1), x(2), 0, 1];
A = A + J'*J;
b = b + J'*d(1:2,j);
end
p = inv(A)*b;
show_matches_affine_model(Ia,Ib,fa,fb,p);

subplot(2,2,2)
N = 10;
[Y I] = sort(scores);
matches_sorted = matches(:,I);
show_matches(Ia,Ib,fa,fb,matches_sorted(:,1:N));

subplot(2,2,3)
N = 10;
d = fb(1:2,matches_sorted(2,1:N))-fa(1:2,matches_sorted(1,1:N));
p = mean(d,2);
show_matches_linear_model(Ia,Ib,fa,fb,p);


subplot(2,2,4)

N = 10;
d = fb(1:2,matches_sorted(2,1:N))-fa(1:2,matches_sorted(1,1:N));
i = size(d, 2);
A = zeros(6,6);
b = zeros(6,1);
for j = 1:i,
x = fa(1:2,matches_sorted(1,j));
J = [x(1), x(2), 0, 0, 1, 0; 0, 0, x(1), x(2), 0, 1];
A = A + J'*J;
b = b + J'*d(1:2,j);
end
p = inv(A)*b;
show_matches_affine_model(Ia,Ib,fa,fb,p);
