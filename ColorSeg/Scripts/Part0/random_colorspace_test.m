clc
close All

%F = FrameID;
%FrameID = histeq(F);

figure
imshow(FrameID)

A = rgb2lab(FrameID);
figure;
subplot(4,3,1)
%A(:,:,1) = histeq(A(:,:,1));
imagesc(A(:,:,1))
subplot(4,3,2)
%A(:,:,2) = histeq(A(:,:,2));
imagesc(A(:,:,2))
%A(:,:,3) = histeq(A(:,:,3));
subplot(4,3,3)
imagesc(A(:,:,3))

A = rgb2hsv(FrameID);
subplot(4,3,4)
imagesc(A(:,:,1))
subplot(4,3,5)
imagesc(A(:,:,2))
subplot(4,3,6)
imagesc(A(:,:,3))

A = rgb2ycbcr(FrameID);
subplot(4,3,7)
imagesc(A(:,:,1))
subplot(4,3,8)
imagesc(A(:,:,2))
subplot(4,3,9)
imagesc(A(:,:,3))

A = rgb2lab(FrameID)
L = A(:,:,1);
Aa = A(:,:,2);
B = A(:,:,3);

A = rgb2hsv(FrameID);
H = A(:,:,1);
S = A(:,:,2);
V = A(:,:,3);

A = rgb2ycbcr(FrameID);
Y = A(:,:,1);
Cb = A(:,:,2);
Cr = A(:,:,3);

new = (1-Cb);%.*(B)
subplot(4,3,10)
imagesc(new);


% new = S.*Cr;
% subplot(4,3,10)
% imagesc(new);
FrameID = F;


