function [ output_args ] = autocorr_t( input_args )
%AUTOCORR_T Summary of this function goes here
%   Detailed explanation goes here
function acfs = autocorr_t(xs)
    [m, n] = size(xs);
    mf2 = floor(m / 2);
    acfs = zeros(mf2, n);
    for i = 1 : mf2
        for j = 1 : n
            i1 = i + 1;
            imf2 = i + mf2;            
            acfs(i, j) = mean (xs(1 : mf2, j) .* xs(i1 : imf2, j));
        end
    end
end


end

