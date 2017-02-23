function [ y ] = LCG( N, z1 )
%LCG linear congruent generator
%   Detailed explanation goes here


m = 2^31 - 1;
a = 16807;
y = zeros(1, N);
y(1)= z1;
for i = 1 : N - 1
    y(i+1) = mod(a * y(i), m);
end

