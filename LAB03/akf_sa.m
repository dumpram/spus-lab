function rxxa = akf_sa(x, tau)
% AKF_SA - Usrednjena statisti�ka autokorelacijska funkcija
%     AKF_SA(X) ra�una usrednjenu statisti�ku autokorelcijsku funkciju
%     procesa zadanog matricom X. Matrica X sadrzi razli�ite
%     realizacije po stupcima.
%     AKF_SA(X, T) ra�una usrednjenu statisti�ku autokorelacijsku funkciju
%     samo za prvih T pomaka.

% SPUS - Laboratorijske vje�be - 02. 11. 2009.

if nargin == 0
   error('Matrica slu�ajnog procesa mora biti zadana.');
end

% AKF ra�unamo samo do polovice trajanja signala (odnosno do
% manjeg cijelog broja) ako pomak nije zadan, odnosno do
% najve�eg mogu�eg trenutka ako je pomak zadan.
[t_length, x_length] = size(x);
tau_max = floor(t_length/2);
if (1 ~= nargin) && (tau_max > tau)
  tau_max = fix(tau);
end
t_max = t_length - tau_max;

% inicijalizacija varijabli
rxx = zeros(t_max, tau_max);
xx = zeros(t_max, x_length);
dim = max(find(size(xx)~=1));
if isempty(dim)
   dim = 1;
end

% ra�unanje AKF
if ~isempty(xx)
   % ra�unamo AKF redak po redak za razli�ita vremena t
   % gdje svaki dobiveni redak odgovara jednoj vrijednosti
   % pomaka tau
   for tau = 1 : tau_max;
      xx = x(tau:tau+t_max-1,:).*x(1:t_max,:);
      rxx(:,tau) = sum(xx,dim)/size(xx,dim);
   end
   % na kraju usrednjimo rezultate
   rxxa = mean(rxx);
else
   rxx=NaN;
end
