function [ y ] = periodogram( realizationMatrix )
%PERIODOGRAM Izracunava usrednjeni periodogram.


M = length(realizationMatrix(:, 1));
N = length(realizationMatrix(1, :));

y = zeros(M, 1);

for i = 1:N
    y = y + 1/M * (abs(fft(realizationMatrix(:, i), M))).^2;
end
y = y / N;
end

