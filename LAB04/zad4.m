close all;

variance = 25;
N = 100000;
w = 1;
std_dev = sqrt(variance);
x_norm_dist = 0 + std_dev .* randn(1, N);
x_unif_dist = rand(1, N) * 20 - 10;
x_sins_detr = 10 * sin(w * (0:N-1));

kv_x_norm_dist = zeros(8,N);
kv_x_unif_dist = zeros(8,N);
kv_x_sins_detr = zeros(8,N);

kv_x_norm_dist_u = zeros(8,N);
kv_x_unif_dist_u = zeros(8,N);
kv_x_sins_detr_u = zeros(8,N);

kv_p_norm_dist = zeros(1,8);
kv_p_unif_dist = zeros(1,8);
kv_p_sins_detr = zeros(1,8);

SNR_norm = zeros(1,8);
SNR_unif = zeros(1,8);
SNR_sins = zeros(1,8);


bin_centers_norm = linspace(min(x_norm_dist), max(x_norm_dist), 4096);
hist_norm = hist(x_norm_dist, bin_centers_norm);

bin_centers_unif = linspace(min(x_unif_dist), max(x_unif_dist), 4096);
hist_unif = hist(x_unif_dist, bin_centers_unif);

bin_centers_sins = linspace(min(x_sins_detr), max(x_sins_detr), 4096);
hist_sins = hist(x_sins_detr, bin_centers_sins);

F_dist_norm = cumsum(hist_norm);
F_dist_unif = cumsum(hist_unif);
F_dist_sins = cumsum(hist_sins);

figure('name','Procjena normalne razdiobe histogramom');
subplot(2, 1, 1); plot(bin_centers_norm, F_dist_norm/N); title('Funkcija distribucije vjerojatnosti');
subplot(2, 1, 2); plot(bin_centers_norm, hist_norm/N); title('Funkcija gustoce vjerojatnosti');

figure('name', 'Procjena uniformne razdiobe histogramom');
subplot(2, 1, 1); plot(bin_centers_unif, F_dist_unif/N); title('Funkcija distribucije vjerojatnosti');
subplot(2, 1, 2); plot(bin_centers_unif, hist_unif/N); title('Funkcija gustoce vjerojatnosti');

figure('name', 'Procjena razdiobe 10 * sin(x)');
subplot(2, 1, 1); plot(bin_centers_sins, F_dist_sins/N); title('Funkcija distribucije vjerojatnosti');
subplot(2, 1, 2); plot(bin_centers_sins, hist_sins/N); title('Funkcija gustoce vjerojatnosti');

%%
% KOMPRESOR

x_norm_comp = interp1(bin_centers_norm, F_dist_norm, x_norm_dist);
x_unif_comp = interp1(bin_centers_unif, F_dist_unif, x_unif_dist);
x_sins_comp = interp1(bin_centers_sins, F_dist_sins, x_sins_detr);
figure('name', 'Funkcije gustoće vjerojatnosti nakon kompresije');
subplot(3, 1, 1); hist(x_norm_comp/N); title('Normalna razdioba');
subplot(3, 1, 2); hist(x_unif_comp/N); title('Uniformna razdioba');
subplot(3, 1, 3); hist(x_sins_comp/N); title('Sinus');

% END OF KOMPRESOR

for i=1:8
    
    % KVANTIZATOR
    
    kv_x_norm_dist_u(i,:) = kvantiziraj(x_norm_comp/N, 2^i);
    kv_x_unif_dist_u(i,:) = kvantiziraj(x_unif_comp/N, 2^i);
    kv_x_sins_detr_u(i,:) = kvantiziraj(x_sins_comp, 2^i);
    
    % EKSPANDER
    
    kv_x_norm_dist(i,:) = norminv(kv_x_norm_dist_u(i,:), 0, std_dev);
    kv_x_unif_dist(i,:) = unifinv(kv_x_unif_dist_u(i,:), -10, 10);   
    kv_x_sins_detr(i,:) = interp1(F_dist_sins, bin_centers_sins, kv_x_sins_detr_u(i,:));
    %kv_x_sins_detr(i,:) = (1/w) * asin(kv_x_sins_detr_u(i,:)/10);
    
    kv_p_norm_dist(1,i) = mean(abs(kv_x_norm_dist(i,:)-x_norm_dist).^2);
    kv_p_unif_dist(1,i) = mean(abs(kv_x_unif_dist(i,:)-x_unif_dist).^2);
    kv_p_sins_detr(1,i) = mean(abs(kv_x_sins_detr(i,:)-x_sins_detr).^2);
    
    SNR_norm(1,i) = 10 * log10(mean(x_norm_dist.^2) / kv_p_norm_dist(1,i));
    SNR_unif(1,i) = 10 * log10(mean(x_unif_dist.^2) / kv_p_unif_dist(1,i));
    SNR_sins(1,i) = 10 * log10(mean(x_sins_detr.^2) / kv_p_sins_detr(1,i));
end

figure('name', 'SNR kompander');
plot(1:8, SNR_norm, 1:8, SNR_unif, 1:8, SNR_sins);
legend('norm dist', 'unif dist', 'sins');

% END OF KUMULATIVNA METODA

%% SNR TEORIJSKI

% KOMPRESOR

x_norm_comp = normcdf(x_norm_dist, 0, std_dev);
x_unif_comp = unifcdf(x_unif_dist, -10, 10);
figure('name', 'Funkcije gustoće vjerojatnosti nakon kompresije(teorijski)');
subplot(3, 1, 1); hist(x_norm_comp); title('Normalna razdioba');
subplot(3, 1, 2); hist(x_unif_comp); title('Uniformna razdioba');


% END OF KOMPRESOR

for i=1:8
    
    % KVANTIZATOR
    
    kv_x_norm_dist_u(i,:) = kvantiziraj(x_norm_comp, 2^i);
    kv_x_unif_dist_u(i,:) = kvantiziraj(x_unif_comp, 2^i);
    
    % EKSPANDER
    
    kv_x_norm_dist(i,:) = norminv(kv_x_norm_dist_u(i,:), 0, std_dev);
    kv_x_unif_dist(i,:) = unifinv(kv_x_unif_dist_u(i,:), -10, 10);   
    
    kv_p_norm_dist(1,i) = mean(abs(kv_x_norm_dist(i,:)-x_norm_dist).^2);
    kv_p_unif_dist(1,i) = mean(abs(kv_x_unif_dist(i,:)-x_unif_dist).^2);
    
    SNR_norm(1,i) = 10 * log10(mean(x_norm_dist.^2) / kv_p_norm_dist(1,i));
    SNR_unif(1,i) = 10 * log10(mean(x_unif_dist.^2) / kv_p_unif_dist(1,i));
end

figure('name', 'SNR kompander(teorijski)');
plot(1:8, SNR_norm, 1:8, SNR_unif);
legend('norm dist', 'unif dist');
 
%% GOVORNI SIGNAL

close all;

x_glas = wavread('glas.wav')';

fs = 48000;

n = length(x_glas);

S = mean(x_glas.^2);

bin_centers_voice = linspace(min(x_glas), max(x_glas), 162);
x_glas_hist = hist(x_glas, bin_centers_voice);

F_dist_voice = cumsum(x_glas_hist);

figure('name', 'Razdioba glasa');
plot(bin_centers_voice, F_dist_voice/max(F_dist_voice));

% KOMPRESOR

x_glas_comp = interp1(bin_centers_voice, F_dist_voice, x_glas);

figure('name','Funkcija gustoće vjerojatnosti nakon kompresije glasa');
hist(x_glas_comp/n);

kv_x_glas_u = zeros(8, n);
kv_x_glas = zeros(8, n);
SNR_glas = zeros(1,8);


for i=1:8
    kv_x_glas_u(i,:) = kvantiziraj(x_glas_comp, 2^i);
    
    % EKSPANDER
    kv_x_glas(i,:) = interp1(F_dist_voice, bin_centers_voice, kv_x_glas_u(i,:));

    SNR_glas(1, i) = 10 * log10(S / mean(abs(x_glas - kv_x_glas(i,:)).^2));
end
    
figure('name','SNR(glas)');
plot(1:8, SNR_glas);


%% LLOYD - MAX 

close all;

for i=1:8
    disp(i);
    [p_norm, c_norm] = lloyds(kv_x_norm_dist(i,:), 2^i);
    [p_unif, c_unif] = lloyds(kv_x_unif_dist(i,:), 2^i);
    [p_sins, c_sins] = lloyds(kv_x_sins_detr(i,:), 2^i);
    [p_glas, c_glas] = lloyds(kv_x_glas(i,:), 2^i);
    [q_norm, Q_norm] = quantiz(x_norm_dist, p_norm, c_norm);
    [q_unif, Q_unif] = quantiz(x_unif_dist, p_unif, c_unif);
    [q_sins, Q_sins] = quantiz(x_sins_detr, p_sins, c_sins);
    [q_glas, Q_glas] = quantiz(x_glas, p_glas, c_glas);
    SNR_norm(1, i) = 10 * log10(mean(abs(x_norm_dist).^2)/mean(abs(x_norm_dist-Q_norm).^2));
    SNR_unif(1, i) = 10 * log10(mean(abs(x_unif_dist).^2)/mean(abs(x_unif_dist-Q_unif).^2));
    SNR_sins(1, i) = 10 * log10(mean(abs(x_sins_detr).^2)/mean(abs(x_sins_detr-Q_sins).^2));
    SNR_glas(1, i) = 10 * log10(mean(abs(x_glas).^2)/mean(abs(x_glas-Q_glas).^2));
end
    
figure('name','SNR-LLM-signali');
plot(1:8, SNR_norm, 1:8, SNR_unif, 1:8, SNR_sins);
legend('norm', 'unif', 'sins');

figure('name', 'SNR-LLM-glas');
plot(1:8, SNR_glas);
    