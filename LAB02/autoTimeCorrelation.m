function [ y ] = autoTimeCorrelation( realizationMatrix )
%AUTOTIMECORELATION Summary of this function goes here
%   Detailed explanation goes here

N = length(realizationMatrix(1, :));
M = length(realizationMatrix(:, 1));

limit = floor(M/2);

y = zeros(limit, N);


for j = 1 : N
    for i = 1 : limit
        y(i, j) = mean(realizationMatrix(1:limit, j) .* realizationMatrix(1 + i:limit + i, j));  
    end
end
end


