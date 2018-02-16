imfc = fftshift(imf);
figure(1)
imshow(abs(imfc));

invimfc = ifft2(imfc);
figure(2)
imshow(255*invimfc);