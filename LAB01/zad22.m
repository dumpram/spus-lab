N = 1;
%theta = rand(N, 1) * pi; %10 zadatak
theta = (rand(N, 1) - 1/2) * 2 * pi;
Ts = 0.01;
M = 10000;
X = zeros (M, N);
for i = 1 : N
    for t = 1 : M; 
        X(t, i) = cos(t * Ts + theta(i));
    end
end
y = autoTimeCorelation(X);
plot(y);

%povecamo li broj uzoraka statististicka autokorelacijska funkcija
%je sve slicnija vremenskoj