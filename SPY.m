clc;
clear;
close all;

addpath(genpath(pwd));

%% groundtruth object
m = 32;
n = 32;
phase = imresize(double(imread('cameraman.tif')),[m,n]);
phase = phase./255*2*pi-pi;
amplitude = imresize(double(imread('barbara.tif')),[m,n]);
amplitude = amplitude*255;
img = amplitude.*exp(1j*0.8*phase);
% figure;imshow(abs(img),[],'InitialMagnification',1000);
% figure;imshow(angle(img),[],'InitialMagnification',1000);

%% illumination pattern
clear illp;
for i=1:floor(m*n*4)
    illp(:,:,i) = round(rand(m,n));
end

%% captured signal
clear imlowseq
for i=1:size(illp,3)
    imillp = img.*illp(:,:,i);
    imillp_fft = fftshift(fft2(imillp));
    rawpixel(i) = (abs(imillp_fft(m/2+1,n/2+1))).^2;
end

%% initial
O_estimate = randn(m,n).*exp(1j*randn(m,n));

%% recovery
alfa = 1;
j_max = 500;
loop_max = 50;
for loopnum=1:loop_max
    for j=1:j_max
        for i=1:size(illp,3)
            psi_estimate = illp(:,:,i).*O_estimate;
            psi_estimate_fft = fftshift(fft2(psi_estimate));
            psi_update_fft = psi_estimate_fft;
            psi_update_fft(m/2+1,n/2+1) = sqrt(rawpixel(i)).*exp(1j*angle(psi_update_fft(m/2+1,n/2+1)));
            psi_update = ifft2(fftshift(psi_update_fft));
            O_update = O_estimate+alfa*illp(:,:,i).*(psi_update-psi_estimate)./(max(max(illp(:,:,i))).^2);
            O_estimate = O_update;
        end
    end
    abs_PSNR = psnr(abs(O_estimate),abs(img),max(max(amplitude)));
    fprintf(['loop ' num2str(loopnum) ' PSNR=' num2str(abs_PSNR) '\n']);
end

phase_wrapped = angle(O_estimate);
phunwrap = GoldsteinUnwrap2D_r1(exp(1j*phase_wrapped));
figure;imshow(abs(O_estimate),[],'InitialMagnification',1000);title('Recovered amplitude');
figure;imshow(phunwrap,[],'InitialMagnification',1000);title('Recovered phase');
