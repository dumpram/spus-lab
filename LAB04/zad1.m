close all;
variance = 25;
N = 100000;
w = 1/10;
std_dev = sqrt(variance);
x_norm_dist = 0 + std_dev .* randn(1, N);
x_unif_dist = rand(1, N) * 20 - 10;
x_sins_detr = 10 * sin(w * (0:N-1));

kv_x_norm_dist = zeros(8,N);
kv_x_unif_dist = zeros(8,N);
kv_x_sins_detr = zeros(8,N);

kv_p_norm_dist = zeros(1,8);
kv_p_unif_dist = zeros(1,8);
kv_p_sins_detr = zeros(1,8);
SNR_norm = zeros(1,8);
SNR_unif = zeros(1,8);
SNR_sins = zeros(1,8);

for i=1:8
    kv_x_norm_dist(i,:) = kvantiziraj(x_norm_dist, 2^i);
    kv_x_unif_dist(i,:) = kvantiziraj(x_unif_dist, 2^i);
    kv_x_sins_detr(i,:) = kvantiziraj(x_sins_detr, 2^i);
    kv_p_norm_dist(1,i) = mean(abs(kv_x_norm_dist(i,:)-x_norm_dist).^2);
    kv_p_unif_dist(1,i) = mean(abs(kv_x_unif_dist(i,:)-x_unif_dist).^2);
    kv_p_sins_detr(1,i) = mean(abs(kv_x_sins_detr(i,:)-x_sins_detr).^2);
    SNR_norm(1,i) = 10 * log10(mean(x_norm_dist.^2) / kv_p_norm_dist(1,i));
    SNR_unif(1,i) = 10 * log10(mean(x_unif_dist.^2) / kv_p_unif_dist(1,i));
    SNR_sins(1,i) = 10 * log10(mean(x_sins_detr.^2) / kv_p_sins_detr(1,i));
end

plot(1:8, SNR_norm, 1:8, SNR_unif, 1:8, SNR_sins);
legend('norm dist', 'unif dist', 'sinus');
