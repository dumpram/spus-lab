function [ y ] = spectrumEstimation( realizationMatrix )
%SPECTRUMESTIMATION Estimates spectrum density from realization matrix.

autocorr_mat = autoTimeCorrelation(realizationMatrix);
N = length(autocorr_mat(1, :));
M = length(autocorr_mat(:, 1));

autocorr_seq = zeros(M, 1);

for i = 1:N
    autocorr_seq = autocorr_seq + autocorr_mat(:,i);
end
autocorr_seq = 1/N * autocorr_seq;
n = length(autocorr_seq);
autocorr_seq = autocorr_seq';
length(autocorr_seq)
autocorr_seq = [autocorr_seq autocorr_seq(n:-1:2)];
y = abs(fft(autocorr_seq));
end

