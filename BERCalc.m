clc; clear; close all;

% This m-file runs the BER Calculation functions, and plots the BER vs
% Frequency graphs.

f4 = zeros(8,1); 
BER4_1 = zeros(8,1);
BER4_2 = zeros(8,1);
BER4_3 = zeros(8,1);

f8 = zeros(8,1); 
BER8_1 = zeros(8,1);
BER8_2 = zeros(8,1);
BER8_3 = zeros(8,1);

f16 = zeros(8,1);
BER16_1 = zeros(8,1);
BER16_2 = zeros(8,1);
BER16_3 = zeros(8,1);

rawdata4_1 = [];
rawdata4_2 = [];
rawdata4_3 = [];

rawdata8_1 = [];
rawdata8_2 = [];
rawdata8_3 = [];

rawdata16_1 = [];
rawdata16_2 = [];
rawdata16_3 = [];


opts = detectImportOptions('p4r11khz.csv');
opts.SelectedVariableNames = [2,10,11,4,5];
rawdata4_1(:,1:6) = readmatrix('p4r11khz.csv',opts);
rawdata4_1(:,7:12) = readmatrix('p4r15khz.csv',opts);
rawdata4_1(:,13:18) = readmatrix('p4r110khz.csv',opts);
rawdata4_1(:,19:24) = readmatrix('p4r150khz.csv',opts);
rawdata4_1(:,25:30) = readmatrix('p4r1100khz.csv',opts);
rawdata4_1(:,31:36) = readmatrix('p4r1500khz.csv',opts);
rawdata4_1(:,37:42) = readmatrix('p4r11MHz.csv',opts);
rawdata4_1(:,43:48) = readmatrix('p4r12MHz.csv',opts);
rawdata4_2(:,1:6) = readmatrix('p4r21khz.csv',opts);
rawdata4_2(:,7:12) = readmatrix('p4r25khz.csv',opts);
rawdata4_2(:,13:18) = readmatrix('p4r210khz.csv',opts);
rawdata4_2(:,19:24) = readmatrix('p4r250khz.csv',opts);
rawdata4_2(:,25:30) = readmatrix('p4r2100khz.csv',opts);
rawdata4_2(:,31:36) = readmatrix('p4r2500khz.csv',opts);
rawdata4_2(:,37:42) = readmatrix('p4r21MHz.csv',opts);
rawdata4_2(:,43:48) = readmatrix('p4r22MHz.csv',opts);
rawdata4_3(:,1:6) = readmatrix('p4r31khz.csv',opts);
rawdata4_3(:,7:12) = readmatrix('p4r35khz.csv',opts);
rawdata4_3(:,13:18) = readmatrix('p4r310khz.csv',opts);
rawdata4_3(:,19:24) = readmatrix('p4r350khz.csv',opts);
rawdata4_3(:,25:30) = readmatrix('p4r3100khz.csv',opts);
rawdata4_3(:,31:36) = readmatrix('p4r3500khz.csv',opts);
rawdata4_3(:,37:42) = readmatrix('p4r31MHz.csv',opts);
rawdata4_3(:,43:48) = readmatrix('p4r32MHz.csv',opts);

for i = 1:length(BER4_1)
    [BER4_1(i),f4(i)] = BERcalcPAM4(rawdata4_1(:,1+(6*(i-1)):6*i));
    [BER4_2(i)] = BERcalcPAM4(rawdata4_2(:,1+(6*(i-1)):6*i));
    [BER4_3(i)] = BERcalcPAM4(rawdata4_3(:,1+(6*(i-1)):6*i));
end

BER4 = (BER4_1+BER4_2+BER4_3)./3;

figure(1)
plot(f4,BER4);
title('Bit Error Rate for PAM-4 Modulation');
xlabel('f(Hz)');
ylabel('BER');

rawdata8_1(:,1:6) = readmatrix('p8r11khz.csv',opts);
rawdata8_1(:,7:12) = readmatrix('p8r15khz.csv',opts);
rawdata8_1(:,13:18) = readmatrix('p8r110khz.csv',opts);
rawdata8_1(:,19:24) = readmatrix('p8r150khz.csv',opts);
rawdata8_1(:,25:30) = readmatrix('p8r1100khz.csv',opts);
rawdata8_1(:,31:36) = readmatrix('p8r1500khz.csv',opts);
rawdata8_1(:,37:42) = readmatrix('p8r11MHz.csv',opts);
rawdata8_1(:,43:48) = readmatrix('p8r12MHz.csv',opts);
rawdata8_2(:,1:6) = readmatrix('p8r21khz.csv',opts);
rawdata8_2(:,7:12) = readmatrix('p8r25khz.csv',opts);
rawdata8_2(:,13:18) = readmatrix('p8r210khz.csv',opts);
rawdata8_2(:,19:24) = readmatrix('p8r250khz.csv',opts);
rawdata8_2(:,25:30) = readmatrix('p8r2100khz.csv',opts);
rawdata8_2(:,31:36) = readmatrix('p8r2500khz.csv',opts);
rawdata8_2(:,37:42) = readmatrix('p8r21MHz.csv',opts);
rawdata8_2(:,43:48) = readmatrix('p8r22MHz.csv',opts);
rawdata8_3(:,1:6) = readmatrix('p8r31khz.csv',opts);
rawdata8_3(:,7:12) = readmatrix('p8r35khz.csv',opts);
rawdata8_3(:,13:18) = readmatrix('p8r310khz.csv',opts);
rawdata8_3(:,19:24) = readmatrix('p8r350khz.csv',opts);
rawdata8_3(:,25:30) = readmatrix('p8r3100khz.csv',opts);
rawdata8_3(:,31:36) = readmatrix('p8r3500khz.csv',opts);
rawdata8_3(:,37:42) = readmatrix('p8r31MHz.csv',opts);
rawdata8_3(:,43:48) = readmatrix('p8r32MHz.csv',opts);

for p = 1:length(BER8_1)
    [BER8_1(p),f8(p)] = BERcalcPAM8(rawdata8_1(:,1+(6*(p-1)):6*p));
    [BER8_2(p)] = BERcalcPAM8(rawdata8_2(:,1+(6*(p-1)):6*p));
    [BER8_3(p)] = BERcalcPAM8(rawdata8_3(:,1+(6*(p-1)):6*p));
end

BER8 = (BER8_1+BER8_2+BER8_3)./3;

figure(2)
plot(f8,BER8);
title('Bit Error Rate for PAM-8 Modulation');
xlabel('f(Hz)');
ylabel('BER');

rawdata16_1(:,1:6) = readmatrix('p16r11khz.csv',opts);
rawdata16_1(:,7:12) = readmatrix('p16r15khz.csv',opts);
rawdata16_1(:,13:18) = readmatrix('p16r110khz.csv',opts);
rawdata16_1(:,19:24) = readmatrix('p16r150khz.csv',opts);
rawdata16_1(:,25:30) = readmatrix('p16r1100khz.csv',opts);
rawdata16_1(:,31:36) = readmatrix('p16r1500khz.csv',opts);
rawdata16_1(:,37:42) = readmatrix('p16r11MHz.csv',opts);
rawdata16_1(:,43:48) = readmatrix('p16r12MHz.csv',opts);
rawdata16_2(:,1:6) = readmatrix('p16r21khz.csv',opts);
rawdata16_2(:,7:12) = readmatrix('p16r25khz.csv',opts);
rawdata16_2(:,13:18) = readmatrix('p16r210khz.csv',opts);
rawdata16_2(:,19:24) = readmatrix('p16r250khz.csv',opts);
rawdata16_2(:,25:30) = readmatrix('p16r2100khz.csv',opts);
rawdata16_2(:,31:36) = readmatrix('p16r2500khz.csv',opts);
rawdata16_2(:,37:42) = readmatrix('p16r21MHz.csv',opts);
rawdata16_2(:,43:48) = readmatrix('p16r22MHz.csv',opts);
rawdata16_3(:,1:6) = readmatrix('p16r31khz.csv',opts);
rawdata16_3(:,7:12) = readmatrix('p16r35khz.csv',opts);
rawdata16_3(:,13:18) = readmatrix('p16r310khz.csv',opts);
rawdata16_3(:,19:24) = readmatrix('p16r350khz.csv',opts);
rawdata16_3(:,25:30) = readmatrix('p16r3100khz.csv',opts);
rawdata16_3(:,31:36) = readmatrix('p16r3500khz.csv',opts);
rawdata16_3(:,37:42) = readmatrix('p16r31MHz.csv',opts);
rawdata16_3(:,43:48) = readmatrix('p16r32MHz.csv',opts);

for r = 1:length(BER16_1)
    [BER16_1(r),f16(r)] = BERcalcPAM16(rawdata16_1(:,1+(6*(r-1)):6*r));
    [BER16_2(r)] = BERcalcPAM16(rawdata16_2(:,1+(6*(r-1)):6*r));
    [BER16_3(r)] = BERcalcPAM16(rawdata16_3(:,1+(6*(r-1)):6*r));
end

BER16 = (BER16_1+BER16_2+BER16_3)./3;

figure(3)
plot(f16,BER16);
title('Bit Error Rate for PAM-16 Modulation');
xlabel('f(Hz)');
ylabel('BER');