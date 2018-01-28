%% Conversion d'une image TRIMAGO en image JPG
lecshowtrimago;
NOMFIC = [NOMFIC(1 :find(NOMFIC =='.')),'jpg'] ;
imwrite(im/255,NOMFIC,'jpg','Comment',etiquette);
disp(imfinfo(NOMFIC));