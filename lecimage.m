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

% image_ihs = rgb2ihs(image_rgb);
% figure(2)
% imshow(image_ihs(:,:,3));
% Codage en IHS
% 
% image_ih1h2s = rgbw2ih1h2s(im);
% image_rgb = ih1h2s2rgb(image_ih1h2s);
% 
% % Affichage de l'image
% figure(2)
% imshow(image_rgb/255);

% saturation de mireTV.jpg : les couleurs en niveau de gris ont une
% saturation maximale (elles sont pures), les autres non
