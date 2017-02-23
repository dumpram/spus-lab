%mu = 1/2;
%sigma = 1/2;
y = LCG(10001, 1) * 1/(2^31 - 1);
%Finv = sqrt(2 * sigma^2 * log(1 ./ (sigma * sqrt(2 * pi) * y)));
%Finv = Finv - mu;
Finv = 1/5 * log(1./(1 - y));

%[n, xout] = hist(Finv);
hist(1/5 * log(1./(1 -y)));
figure
hist(y);
%kumulativa
%N = cumsum(n);
%bar(xout, N);
