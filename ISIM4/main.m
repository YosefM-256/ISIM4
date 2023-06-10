close all; clear all;
global DAC1 DAC0 sMode;

DAC1 = 4095; DAC0 = 4095; sMode = [1 1 1 0];

pathsNconsts = struct(  'simulationCommand',    'XVIIx64.exe -b -ascii', ...
                        'homePath',             'U:\ISIM4\PNP_2N3906', ...
                        'cirFileName',          'ISIM4cir_PNP_2N3906.cir', ...
                        'rawFileName',          'ISIM4cir_PNP_2N3906.raw', ...
                        'variablesFile',        'variables_PNP_2N3906.txt', ...
                        'LTSpicePath',          'C:\Program Files\LTC\LTspiceXVII', ...
                        'databasePath',         'database_PNP_2N3906.mat');

simulationVariables = getSimulationVariables(pathsNconsts);

findall(0,'Name','ISIM app').delete();
global app; app = ISIMapp;
setSystemMode("P");
% simulate(pathsNconsts,simulationVariables);

%%
% k = plotIcVce([5e-4 1e-3 2e-3 3e-3],[100:100:4000],pathsNconsts,simulationVariables);
% l = plothfeIc(5,[[1:0.5:9]*1e-5 [1:0.5:9]*1e-4 [1:0.5:9]*1e-3 ],"return",pathsNconsts,simulationVariables);
% z = plotVsatIcNPN(10,[ [5:9]*1e-4 [1:9]*1e-3 [1:9]*1e-2 [1:4]*1e-1 ],pathsNconsts,simulationVariables);


% x = plotIcVcePNP([-1:-1:-4]*1e-3,100:100:4000,pathsNconsts,simulationVariables);
% c = plothfeIcPNPalt(-5,[25:25:4075],[25:25:4075],pathsNconsts,simulationVariables);


% v = sweepDAC0Vgs([2.5 3 4 5],[100:100:4000],pathsNconsts,simulationVariables);
% b = plotRdsonVgs(0.05,[50:50:4050],pathsNconsts,simulationVariables);
% n = plotIdVgs(5,25:25:4075,"return",pathsNconsts,simulationVariables);


% m = plotIdVdsPMOS([-2 -2.5 -3 -4],[400:400:4000],[100:100:4000],pathsNconsts,simulationVariables);
% q = plotRdsonVgsPMOS(-0.05,[100:100:4000],pathsNconsts,simulationVariables);   % doesn't work

saveDatabase(pathsNconsts);