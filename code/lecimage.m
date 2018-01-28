% Lecture d'une image au format TRIMAGO ou au format JPEG
%
NOMFIC = uigetfile('Images/*.*') ;
suffixe = NOMFIC(find(NOMFIC=='.')+1 :length(NOMFIC)) ;
NOMFIC = ['Images/' NOMFIC] ;
if strcmp(suffixe,'tri')
	lecshowtrimago2 ;
elseif strcmp(suffixe,'jpg')
	lecshowjpg2 ;
else
	disp('ERREUR')
	return
end
