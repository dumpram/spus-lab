N = 200;
theta = rand(N, 1) * pi; %10 zadatak
%theta = (rand(N, 1) - 1/2) * 2 * pi;
Ts = 0.01;
M = 1000;
X = zeros (M, N);
for i = 1 : N
    for t = 1 : M; 
        X(t, i) = cos(t * Ts + theta(i));
    end
end
E = zeros(1, M);
for i = 1 : M
    E(i) = mean(X(i, :));
end
Var = zeros(1, M);
for i = 1 : M
    for j = 1 : N
        Var(i) = Var(i) + (X(i, j) - mean(X(i, :)))^2;
    end
    Var(i) = 1/(N-1) * Var(i);
end
figure;
plot(E);
figure;
plot(Var);