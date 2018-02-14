% Normalisation de l'image:
%  Moyenne des niveaux de gris = 0
%  Energie = 1
im = image_ihs;
imn = im - mean(im(:));
imn = imn / norm(imn(:), 'fro');
