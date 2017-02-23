function [y] = autoCorrelation( realizationMatrix )
%AUTOCORELATION Summary of this function goes here
%   Detailed explanation goes here
N = length(realizationMatrix(1, :));
M = length(realizationMatrix(:, 1));


limit = floor(M/2);
y = zeros(limit);

for k = 1 : limit
    for l = 1 : limit
        y(k, l) = mean(realizationMatrix(k, :) .* realizationMatrix(k + l, :));  
    end
end
end

