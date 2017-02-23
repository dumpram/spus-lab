close all;

h1 = 1/256 * [-16, -19, -22, -24, -25, 230, -25, -24, -22, -19, 16];
h2 = 1/256 * [16, 19, 22, 24, 25, 26, 25, 24, 22, 19, 16];
H1 = fft(h1);
H2 = fft(h2);
HH1 = abs(H1) .* abs(H1);
HH2 = abs(H2) .* abs(H2);
subplot(2, 1, 1);
stem((0:10), HH1);
title('|H1|^2');
subplot(2, 1, 2);
stem((0:10), HH2);
title('|H2|^2');
Nn = randn(1, 11);
Nu = rand(1, 11);


% Odzivi sustava H1 i H2 na šum
Ynn1 = fft(Nn) .* H1;
Yuu1 = fft(Nu) .* H1;

Ynn2 = fft(Nn) .* H2;
Yuu2 = fft(Nu) .* H2;

figure
stem(Ynn1);


y1 = [ifft(Ynn1)' ifft(Yuu1)'];
y2 = [ifft(Ynn2)' ifft(Yuu2)'];

Syy1 = periodogram(y1);
Syy2 = periodogram(y2);

figure;
subplot(2, 1, 1);
stem((0:10), Syy1);
title('Procjena Syy1 ~ |H1|^2');
subplot(2, 1, 2);
stem((0:10), Syy2);
title('Procjena Syy2 ~ |H2|^2');



