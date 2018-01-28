%% Lecture d'une image TRIMAGO
NOMFIC = uigetfile('Images/*.tri');
NOMFIC = ['Images/' NOMFIC];
imtri = fopen(NOMFIC,'r','b'); %integer big-endian 32 bits
typeimage = fread(imtri,4,'*char');
typeimage = typeimage';
etiquette = fread(imtri,64,'*char');
etiquette = etiquette';
nlig = fread(imtri,1,'*int32');
ncol = fread(imtri,1,'*int32');
ncan = fread(imtri,1,'*int32');
fread (imtri,ncol-80);%lecture de la zone libre de 80 caractères
if strcmp(typeimage,'ITRI')
    im = fread(imtri);
    im = reshape(im,nlig,ncol,ncan);
    im = permute(im,[2 1 3]);
    him = figure('Name',etiquette,'Units','pixels');
    imshow(im/255);
elseif strcmp(typeimage,'IMON')
    im = fread (imtri,[nlig,ncol]);
    im = im';
    him = figure('Name',etiquette,'Colormap',gray(256),'Units','pixels');
    imshow(im,[0,255]);
else
    disp('ERREUR');
end

fclose(imtri) ;