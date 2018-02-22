% Verification de la conservation de l'energie par fft2n
eps = 1e-6;

if abs(norm(imfn(:), 'fro') - norm(imn(:), 'fro')) < eps
    disp('La conservation est verifiee')
else
    disp('Non conservation')
end