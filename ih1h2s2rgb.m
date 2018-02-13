function image_rgb = ih1h2s2rgb(image_ih1h2s)
%
% Fonction effectuant la conversion d'une image IH1H2S en RGBW
% W = White (Blanc)
%
% Au départ, on a une image ihs : image_ihs
%
% Prétraitement : Passage de RGB à RGBW
% Pour cela, on retire tout le blanc possible de RGB et on le met dans W
% R = image_rgb( :, :,1) ;
% G = image_rgb( :, :,2) ;
% B = image_rgb( :, :,3) ;
% W = min(R,G) ;
% image_rgb( :, :,4) = min(W,B) ;
% %
% for k = 1 :3
% 	image_rgb( :, :,k) = image_rgb( :, :,k) -image_rgb( :, :,4) ;
% end
% %
M = [1/3 1/3 1/3 1/3 ; -1/3 -1/3 -1/3 1 ; -1/2 -1/2 1 0 ; sqrt(3)/2 -sqrt(3)/2 0 0] ;
% (M (4,4) n'est pas orthogonale)
%
nlig = size(image_ih1h2s,1) ;
ncol = size(image_ih1h2s,2) ;
image_rgbw = zeros(nlig,ncol,4) ;
%
% on met d'abord v1, v2 et v3 dans image_ih1h2s avant d'appliquer inv(M)
H1 = image_ih1h2s(:,:,2);
H2 = image_ih1h2s(:,:,3);
S = image_ih1h2s(:,:,4);
S_etoile = sqrt(S.^2 - (S.*sin(H2)).^2);
image_ih1h2s(:,:,2) = S.*sin(H2);
image_ih1h2s(:,:,3) = S_etoile.*cos(H1);
image_ih1h2s(:,:,4) = S_etoile.*sin(H1);


for nolig=1 :nlig
	for nocol=1 :ncol
		image_rgbw(nolig,nocol, :) = M \ double(squeeze(image_ih1h2s(nolig,nocol, :))) ;
	end
end
%
% On passe de R*G*B*W* à RGB
image_rgb = zeros(nlig,ncol,3);
image_rgb(:,:,1:3) = image_rgbw(:,:,1:3) + image_rgbw(:,:,4);

end
