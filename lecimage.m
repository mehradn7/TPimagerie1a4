%% Lecture d'une image au format TRIMAGO ou au format JPEG
%
NOMFIC = uigetfile('Images/*.*') ;
suffixe = NOMFIC(find(NOMFIC=='.')+1 :length(NOMFIC)) ;
NOMFIC = ['Images/' NOMFIC] ;
if strcmp(suffixe,'tri')
	lecshowtrimago2;
elseif strcmp(suffixe,'jpg')
	lecshowjpg2;
else
	disp('ERREUR')
	return 
end

% Codage en IHS

image_ihs = rgb2ihs(im);
image_rgb = ihs2rgb(image_ihs);

% Affichage de l'image
figure(2)
imshow(image_rgb/255);
% saturation de mireTV.jpg : les couleurs en niveau de gris ont une
% saturation maximale (elles sont pures), les autres non
