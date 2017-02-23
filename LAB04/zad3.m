close all;

x_glas = wavread('glas.wav')';

fs = 48000;

n = length(x_glas);

S = mean(x_glas.^2);

bits = input('Unesi broj bita: ');

kv_x_glas = zeros(7,n);
N = zeros(1,7);
for i = 1:7
    kv_x_glas(i,:) = kvantiziraj(x_glas, 2^(i+1));
    SNR(1,i) = 10 * log10(S / mean((x_glas-kv_x_glas(i,:)).^2));
end

figure
plot(0:n-1, kv_x_glas(bits,:));
player = audioplayer(kv_x_glas(bits-1,:), fs);
play(player);

figure
plot(2:8, SNR); 



