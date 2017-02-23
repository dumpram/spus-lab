function [ y ] = sr_kv_gr( x_real, x_est )
%SR_KV_GR Summary of this function goes here
%   Detailed explanation goes here

n = length(x_real);

y = sqrt((sum(x_real - x_est)^2)/(n - 1));




end

