function [ output_args ] = autoKoleracija( realizationMatrix )
%AUTOKOLERACIJA Summary of this function goes here
%   Detailed explanation goes here

N = length(realizationMatrix(1, :)); %number of realizations
M = length(realizationMatrix(:, 1)); %number of samples
maxOffset = floor(M);
y = zeros(N);
sum = 0;
for tau = 0 : maxOffset
    for j = 1 : maxOffset
        for i = 1 : N
            sum = sum + realizationMatrix(j, i) * realizationMatrix(j + tau, i);
        end
        y(tau + 1, i) = sum;
        sum = 0;
    end
end



end

