function sxx = sgs(rxx)
% SGS - Spektralna gustoæa snage sluèajnog procesa
%    SGS(Rxx) raèuna spektralnu gustoæu snage slucajnog procesa X iz
%    njegove (vremenski usrednjene) autokorelacijske funkcije Rxx(tau).
%    Rxx(tau) sadrži uzorke autokorelacijske funkcije samo za
%    nenegativne pomake i dobiva se pomoæu funkcije AKF_SA.

% SPUS - Laboratorijske vjezbe - 02. 11. 2009.

if nargin ~= 1
   error('Autokorelacijska funkcija Rxx(tau) sluèajnog procesa mora biti zadana.');
end

% najprije je potrebno proširiti rxx, tj. dodati negativne pomake
% koje funkcija akf_sa(x) ne raèuna (znamo da je AKF parna)
rxx_length = length(rxx);
rxx_sym = [rxx rxx(rxx_length:-1:2)];

% sada raèunamo spektar snage te provjeravamo odnos imaginarnog i realnog dijela
sxx = fft(rxx_sym);
MR = max(abs(real(sxx)));
MI = max(abs(imag(sxx)));
if MI*1000 > MR
   warning('Imaginarni dio spektralne gustoæe snage je prevelik.');
end
sxx = abs(fftshift(sxx));

