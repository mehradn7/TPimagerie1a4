%
% Rotation de couleur sur une image trimago ou jpeg
% On remplace la couleur si sa teinte est suffisamment proche de la teinte à remplacer
% Elle reste inchangée sinon
% On utilise le codage IH1H2S : le blanc possède donc une teinte
%
M = [1/6 1/6 1/6 1/6 ; -1/3 -1/3 -1/3 1 ; -sqrt(2)/3 -sqrt(2)/3 2*sqrt(2)/3 0 ; sqrt(2)/sqrt(3) -sqrt(2)/sqrt(3) 0 0] ;
%
%
% Lecture de l'image trimago ou jpeg qui va subir une rotation colorimétrique
lecimage ;
im_depart = im ;
%on sauvegarde l'image im dans im_depart
%
% Codage IH1H2S de im_depart
image_ihs = rgbw2ih1h2s(im) ;
%
%
% Calcul des matrices V1 ,V2 et V3
V1 = sin(image_ihs( :, :,3)) ;
V2 = cos(image_ihs( :, :,3)) .* cos(image_ihs( :, :,2)) ;
V3 = cos(image_ihs( :, :,3)) .* sin(image_ihs( :, :,2)) ;
%
%
% Couleur à remplacer
disp('Désigner une couleur à remplacer') ;
[y1,x1] = ginput (1) ;
x1 = round(x1) ;
y1 = round(y1) ;
disp(['x1 = ', num2str(x1),' y1= ',num2str(y1)]) ;
%
psi1d = (image_ihs(x1,y1,2)/pi)*180 ;
% psi1 en degrés
theta1d = (image_ihs(x1,y1,3)/pi)*180 ;
% theta1 en degrés
disp(['Angle azimutal de la teinte à remplacer : ',num2str(psi1d),' degrés']) ;
disp(['Angle de site de la teinte à remplacer : ',num2str(theta1d),' degrés']) ;
%
% Calcul de v11 , v12 , v13 , v1
v11 = V1(x1,y1) ;
v12 = V2(x1,y1) ;
v13 = V3(x1,y1) ;
v1 = [v11 ;v12 ;v13] ;
%
disp(' ') ;
%
close(him) ;
%
% Couleur de remplacement
% on lit l'image qui contient la couleur de remplacement
%
disp('Lire l"image contenant la couleur de remplacement') ;
lecimage ;
% L'image de remplacement est im
%
disp('Désigner une couleur de remplacement') ;
[y2,x2] = ginput (1) ;
x2 = round(x2) ;
y2 = round(y2) ;
disp(['x2 = ', num2str(x2),' y2= ',num2str(y2)]) ;
%
% Codage IH1H2S de im(x2,y2).
% Attention im est l'image de remplacement pas l'image de depart im_depart !
%
% Prétraitement : Passage de RGB à R*G*B*W
% Pour cela, on retire tout le blanc possible de RGB et on le met dans W
%
r = im(x2,y2,1) ;
g = im(x2,y2,2) ;
b = im(x2,y2,3) ;
minrgb = min(r,g) ;
minrgb = min(minrgb,b) ;
%
rstar = r - minrgb ;
gstar = g - minrgb ;
bstar = b - minrgb ;
w = minrgb ;
%
result = M*[rstar ;gstar ;bstar ;w] ;
%
% Calcul de v21 , v22 , v23 , v2
v21 = result(2) ;
v22 = result(3) ;
v23 = result(4) ;
v2 = [v21 ;v22 ;v23] ;
v2 = v2/norm(v2) ;
%
h1 = atan2(v23,v22) ;
s = sqrt(v21^2 + v22^2 + v23^2) ;
h2 = asin(v21/s) ;
%
psi2d = (h1/pi)*180 ;% psi2 en degres
theta2d = (h2/pi)*180 ;% theta2 en degres

disp(['Angle azimutal de la teinte de remplacement : ',num2str(psi2d),' degrés']) ;
disp(['Angle de site de la teinte de remplacement : ',num2str(theta2d),' degrés']) ;
disp(' ') ;
%
%
% Lecture du seuil de remplacement en degrés
seuild = input('Seuil de remplacement en degrés (0<= seuil<= 180) ? ','s') ;
seuil = (str2double(seuild)/180)*pi ;
% seuil en radians
%
%
% Calcul de la matrice de rotation R
%
% Calcul de l'axe de rotation
%
% Produit vectoriel pour trouver l'axe
u = cross(v1,v2) ;
% v1 et v2 sont unitaires
%
% Calcul de l'angle de rotation theta
%
sintheta0 = norm(u) ;
% sintheta>0 !
%
% Produit scalaire pour trouver costheta
costheta0 = sum(v1.*v2) ;
%
theta0 = atan2(sintheta0,costheta0) ;
% theta0 est l'angle de la rotation
theta0d = (theta0/pi)*180 ;
%theta0 en degrés
%
% Calcul de R
R = rotationmat3D(theta0,u) ;
%
%
% Rotation des couleurs dans im_depart
nlig = size(im_depart,1) ;
ncol = size(im_depart,2) ;
%
I = image_ihs( :, :,1) ;
S = image_ihs( :, :,4) ;
%
V = zeros(size(im_depart)) ;
V( :, :,1) = S .* V1 ;
V( :, :,2)= S .* V2 ;
V( :, :,3) = S .* V3 ;
%
% Rotation
for nolig=1 :nlig
    for nocol=1 :ncol
        V(nolig,nocol, :) = R * squeeze(V(nolig,nocol, :)) ;
    end
end
%
%
image_ihs = cat(3,I,V( :, :,1),V( :, :,2),V( :, :,3)) ;
%
%
% Décodage IH1H2S vers RGBW de l'image transformée
image_rgb = zeros(nlig,ncol,4) ;
% en fait c'est image_rgbw !
%
for nolig=1 :nlig
    for nocol=1 :ncol
        image_rgb(nolig,nocol, :) = M \ squeeze(image_ihs(nolig,nocol, :)) ;
    end
end
%
% Décodage RGBW vers RGB de l'image transformée
% Posttraitement : on remet le blanc dans R G et B
%
for k = 1 :3
    image_rgb( :, :,k) = image_rgb( :, :,k) + image_rgb( :, :,4) ;
end
%
image_rgb = image_rgb( :, :,1 :3) ;
%image_rgb est l'image ayant subi une rotation colorimétrique GLOBALE d'angle theta0
%
%
% Détermination des angles de rotation des teintes
THETA = zeros(nlig,ncol) ;
for nolig=1 :nlig
    for nocol = 1 :ncol
        v2 = [V1(nolig,nocol) ;V2(nolig,nocol) ;V3(nolig,nocol)] ;
        u = cross(v1,v2) ;
        sintheta = norm(u) ;
        costheta = sum(v1.*v2) ;
        THETA(nolig,nocol) = atan2(sintheta,costheta) ;
% THETA(nolig,nocol) est l'angle entre la teinte de couleur à remplacer et celle de la
% couleur du pixel (nolig,nocol)
    end
end
%
% Filtrage de l'image par un ltre sigmoïde sigmf
% les couleurs dont les teintes sont proches de la teinte a
% remplacer seront remplacées par une combinaison lineaire de la teinte à remplacer et de la teinte de remplacement.
image_rgb_filtre = zeros(size(im_depart)) ;
a = 200*seuil ;
FILTRE = sigmf(THETA,[a seuil]) ;
for k=1 :3
    image_rgb_filtre( :, :,k) = FILTRE.*im_depart( :, :,k) + (1-FILTRE).*image_rgb( :, :,k) ;
%image_rgb est maintenant l'image filtree
end
% Projection sur l'orthant positif ou nul
image_rgb_filtre = (image_rgb_filtre>= 0).*image_rgb_filtre ;
%
%
% Affichage
him = figure ('BackingStore','off','Name',['Rotation de teinte de ( ',num2str(theta0d),' ) degres'],'Units','pixels') ;
imshow(image_rgb_filtre/255)
