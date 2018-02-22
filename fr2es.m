%% Transformation drapeau France -> drapeau Espagne
%% Remplacer bleu par rouge
lecimage;
rot_teinte2bis;
%% Remplacer blanc par jaune
im = image_rgb_filtre;
rot_teinte2bis;

%% Pivoter l'image de 90 degrés pour avoir à peu près le drapeau espagnol
image_rgb_filtre = permute(image_rgb_filtre, [2 1 3]);

%% Afficher l'image finale
imshow(image_rgb_filtre/255);