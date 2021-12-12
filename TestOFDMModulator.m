clear all;
close all;

hMod = comm.OFDMModulator;
showResourceMapping(hMod); % domyslne wartosci

hMod.NumSymbols = 2;
showResourceMapping(hMod); %zmiana wyswietlanych symboli - zmiana na osi x

hMod.FFTLength = 128;
showResourceMapping(hMod); % zwiekszenie punktów fft - zmiana na osi y

hMod.CyclicPrefixLength = 32;
hMod.InsertDCNull = true;
showResourceMapping(hMod); % dodanie skladowej stalej

hMod.PilotInputPort = true;
showResourceMapping(hMod); % dodanie sygnalow pilotowych

hMod.NumGuardBandCarriers = [10; 15];
showResourceMapping(hMod); % zmiana szerokosci nosnych typu guard

hMod.PilotCarrierIndices= [27; 56; 89; 100];
showResourceMapping(hMod); % zmiana polozenia sygnalow pilotowych

hMod.PilotCarrierIndices= cat(2,hMod.PilotCarrierIndices, ...
    [20; 41; 50; 85;]);
showResourceMapping(hMod); % zmiana polozenia sygnalow pilotowych, osobno dla dwoch symboli

hMod.NumTransmitAntennas = 2;
hMod.PilotCarrierIndices = cat(3,[20; 50; 70; 110], [15; 60; 75; 105]);
showResourceMapping(hMod); % zwiekszenie do dwoch anten i wyswietlenie symboli osobno dla nich, zmienione polozenia pilotow, i nulli
disp(hMod)
