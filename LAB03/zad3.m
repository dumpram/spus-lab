close all;
K = 1/(2 * pi);
x = sin(pi * (0:200) / 100);
Xc = (fftshift(fft(x)));
figure
plot (0:200, abs(Xc));
title('Spektar zrcaljenog signala ~ K * Hopt');
Hopt = K  * Xc; 
hopt = (ifft(ifftshift(Hopt)));
figure
plot(0:200, hopt);
title('Impulsni odziv prilagodjenog filtra');
akf_hopt = xcorr(hopt);
figure
plot(-200:200, akf_hopt);
title('Autokorelacijska funkcija optimalnog filtra');
W = randn(1, 2000);
w = W + [zeros(1,500) x zeros(1,2000 - 500 - length(x))];
figure 
plot(0:1999, w);
title('Signal utopljen u sum');
figure
plot(conv(w, hopt));
title('Detektiran signal u sumu');