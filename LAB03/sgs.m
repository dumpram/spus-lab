function sxx = sgs(rxx)
% SGS - Spektralna gusto�a snage slu�ajnog procesa
%    SGS(Rxx) ra�una spektralnu gusto�u snage slucajnog procesa X iz
%    njegove (vremenski usrednjene) autokorelacijske funkcije Rxx(tau).
%    Rxx(tau) sadr�i uzorke autokorelacijske funkcije samo za
%    nenegativne pomake i dobiva se pomo�u funkcije AKF_SA.

% SPUS - Laboratorijske vjezbe - 02. 11. 2009.

if nargin ~= 1
   error('Autokorelacijska funkcija Rxx(tau) slu�ajnog procesa mora biti zadana.');
end

% najprije je potrebno pro�iriti rxx, tj. dodati negativne pomake
% koje funkcija akf_sa(x) ne ra�una (znamo da je AKF parna)
rxx_length = length(rxx);
rxx_sym = [rxx rxx(rxx_length:-1:2)];

% sada ra�unamo spektar snage te provjeravamo odnos imaginarnog i realnog dijela
sxx = fft(rxx_sym);
MR = max(abs(real(sxx)));
MI = max(abs(imag(sxx)));
if MI*1000 > MR
   warning('Imaginarni dio spektralne gusto�e snage je prevelik.');
end
sxx = abs(fftshift(sxx));

