function image_rgb = ihs2rgb(image_ihs)
%% Fonction effectuant la conversion d'une image RGB en IHS
%
M = [1/3 1/3 1/3 ; -1/2 -1/2 1 ; sqrt(3)/2 -sqrt(3)/2 0] ;
%
nlig = size(image_ihs,1) ;
ncol = size(image_ihs,2) ;
image_rgb = zeros(nlig,ncol,3) ;
%

% on met d'abord v1 et v2 dans image_ihs avant d'appliquer inv(M)
H = image_ihs(:,:,2);
S = image_ihs(:,:,3);
image_ihs(:,:,2) = S.*cos(H);
image_ihs(:,:,3) = S.*sin(H);

for nolig = 1:nlig
	for nocol = 1:ncol
		image_rgb(nolig,nocol, :) = M \ double(squeeze(image_ihs(nolig,nocol,:)));
	end
end


end
