M = 1000; %broj uzoraka
%frekvencijska razlucivost je fs/M
%funkcija funGen otipkava s 200 Hz
S4 = periodogram(funGen(M, rand(M) * pi));
S5 = periodogram(funGen(M, (rand(M) - 1/2) * 2 * pi));
plot((-length(S5)/2:1:length(S5)/2-1), S4);
figure
plot((-length(S5)/2:1:length(S5)/2-1), S5);