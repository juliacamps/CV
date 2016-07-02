function show_keypoints(I, f)
% Obtained from vl_demo_sift_basic

imagesc(I);
colormap(gray);
axis equal ; axis off ; axis tight ;
vl_plotframe(f);
