function [ y ] = LCG2(a, m, N, z1)
%LCG linear congruent generator
%   Detailed explanation goes here



y = zeros(1, N);
y(1)= z1;
for i = 1 : N - 1
    y(i+1) = mod(a * y(i), m);
end

