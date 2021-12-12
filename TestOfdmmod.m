clear all;
close all;

MQAM = 128; % Modulation order for QAM
nfft  = 64;
cplen = 8;
nSym  = 11;
nullIdx  = [1:6 33 64-4:64]';
pilotIdx = [12 26 40 54]';
numDataCarrs = nfft-length(nullIdx);
inSig = randi([0 MQAM-1],numDataCarrs,nSym);

% figure;
% plot(inSig, '.');

qamSym = qammod(inSig,MQAM,'UnitAveragePower',true);

figure;
plot(qamSym, 'r*');
title('SYMBOLE QAM');

y1 = ofdmmod(qamSym,nfft,cplen,nullIdx);
figure;
plot(y1,'*');
title('SYGNALY MODULOWANE QAM PO OFDM');

% QPSK
MQPSK=64;
ant1 = randi([0 MQPSK-1],numDataCarrs,nSym);
ant2 = randi([0 MQPSK-1],numDataCarrs,nSym);
qpskSym(:,:,1) = pskmod(ant1,MQPSK);
qpskSym(:,:,2) = pskmod(ant2,MQPSK);

figure;
hold on;
plot(qpskSym(:,:,1), 'g*');
plot(qpskSym(:,:,2), 'r.');
title('SYMBOLE QPSK');

y2 = ofdmmod(qpskSym,nfft,cplen,nullIdx);
figure;
plot(y2,'*');
title('SYGNALY MODULOWANE QPSK PO OFDM');