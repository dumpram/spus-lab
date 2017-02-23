function [ y ] = wien_filt(X)
%WIEN_FILTER Summary of this function goes here
%   Detailed explanation goes here

X = X(1:8001);
N = zeros(1, 8001);
N(1) = 1;
Sxx = sgs(akf_sa(X));
Snn = sgs(akf_sa(N));

y = Sxx/(Sxx + Snn);

end

