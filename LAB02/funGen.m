function [ y ] = funGen(M, theta)
%FUNGEN Generates function cos(100pi*t + theta) in M samples.
Ts = 0.005;
N = 100;
X = zeros (M, N);
for i = 1 : N
    for t = 1 : M; 
        X(t, i) = cos(t * Ts * 100 * pi + theta(i));
    end
end
y = X;
end


