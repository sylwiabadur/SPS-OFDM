clear all;
close all;

hMod = comm.OFDMModulator;
hMod.InsertDCNull = true;
hMod.NumTransmitAntennas = 1;
hMod.PilotInputPort = true;
hMod.NumGuardBandCarriers = [1; 10];
hMod.PilotCarrierIndices= [12; 15; 25; 37];
showResourceMapping(hMod);
modDim  = info(hMod);
disp(hMod)

dataIn = complex(randn(modDim.DataInputSize),randn(modDim.DataInputSize));
pilotIn = complex(rand(modDim.PilotInputSize),rand(modDim.PilotInputSize));
modData = step(hMod,dataIn,pilotIn);
figure;
subplot(3,1,1);
plot(dataIn(:,:,1), '*');
title('Sygnaly wejsciowe przed OFDM');
subplot(3,1,2);
plot(pilotIn(:,:,1), '*');
title('Sygnaly pilotowe przed OFDM');
subplot(3,1,3);
plot(modData, '*');
title('Dane wyjsciowe z OFDM');

demod = comm.OFDMDemodulator(hMod);
[dataOut, pilotOut] = step(demod,modData);

figure;
subplot(3,1,1);
plot(dataOut(:,:,1), '*');
title('Dane uzyskane po demodulacji OFDM');
subplot(3,1,2);
plot(pilotOut(:,:,1), '*');
title('Sygnaly pilotowe pod demodulacji OFDM');
subplot(3,1,3);
plot(modData, '*');
title('Dane wyjsciowe z OFDM');