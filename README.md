# SPS-OFDM


## How to run - prerequisites
To run the app you will need to download Communications Toolbox packages in Matlab.

## How to run - step by step
First run *gui.m* file. The app will open. 
Click *Load Signal* button. Then load appropriate txt file with modulated data.

Default parameters will be set - you can either change them or leave as they were. Then you can display OFDM modulation properties by clicking *Display OFDM properties* button.

You can manage OFDM modulation parameters. Then click *Create OFDM Modulator*. Modulation will be proceeded in the background. After that you will see message box. Please select button *Write to file* at the end to write data stream to txt.

Written files will be named: *dataOut.txt* with the output of this block and *pilotIn.txt* with pilot signals.