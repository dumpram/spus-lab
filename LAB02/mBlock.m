function [ y ] = mBlock( signal, M )
%MBLOCK Function divides signal in block of size M.
i = 1;
y = zeros(ceil(length(signal) / M), M);
while length(signal) >= M
    y(i,:) = signal(1:M);
    signal = signal(M + 1:length(signal));
    i = i + 1;
end
y(i,1:length(signal)) = signal;

end

