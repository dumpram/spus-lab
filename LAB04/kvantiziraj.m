function y = kvantiziraj(x, n, a, b)
% KVANTIZIRAJ Jednolika kvantizacija signala x.
%   KVANTIZIRAJ(X) vrsi kvantizaciju vektora X s rezolucijom od 8 bitova
%   (256 razina). Dinamika kvantiziranog vektora je jednaka dinamici
%   ulaznog vektora.
%
%   KVANTIZIRAJ(X,n) vrsi kvantizaciju signala X u n razina.
% SPUS - Laboratorijske vjezbe - 2008-01-09
ni = nargin;
no = nargout;
error(nargchk(1,4,ni));
if nargin == 1
n = 2^8;
minx = min(x(:));
maxx = max(x(:));
elseif nargin == 2
minx = min(x(:));
maxx = max(x(:));
elseif nargin == 3
minx = a;
maxx = max(x(:));
else
minx = a;
maxx = b;
end;
if n <= 0 error('Pretvorba nije moguca!'); end;
if minx >= maxx error('Raspon nije dobro definiran!'); end;
% Odredi raspon ulaznog signala.
raspon = abs(maxx - minx);
d = raspon / n;
d2 = raspon / n / 2;
% Zadnju granicu ukljucujemo u zadnji kvant. Da bi to postigli moramo maxx
% zamijeniti s manjom vrijednoscu, no tek nakon skaliranja kako bi izbjegli
% numericke pogreske pri zaokruzivanju (zadnja znamenka je zaokruzena pri
% mnozenju i dijeljenju).
y = (x - minx) * n / raspon;
granica = n - eps(n);
k = find(y >= granica);
y(k) = granica;
% Kvantiziraj signal koristenjem floor funkcije i vrati ga u izvorni opseg.
y = floor(y);
y = y * raspon / n + minx + d2;