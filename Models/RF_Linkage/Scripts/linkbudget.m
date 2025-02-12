% 
% All values should be in dB

satdata = satData;

% Path loss table
% in future, import raw values from data table
pathLoss = 20*log10((4*pi*satdata.distanceTo*satdata.frequency)/physconst('LightSpeed'));
%pathLoss = 154;

% Calculating EIRP (dB), not inc. transmitter system (ie wires) loss:
eirp = satdata.transmitPower + satdata.transGain;
% Calculate Gr/Ts (dB) - recv gain to temperature ratio 
grts = satdata.recvGain - satdata.temp;

% Calculate C/N (dB)
cn = eirp - pathLoss - satdata.miscLoss + grts + satdata.toDecibel(1/physconst('Boltzmann')) - satdata.bandwidth;
% Calculate received power a sum of gains and losses in dB
recvPower = eirp - pathLoss + satdata.recvGain - satdata.miscLoss;

testboltz = satdata.toDecibel(1/physconst('Boltzmann'));

% Calculate Eb/N0 - energy per bits to noise power density 
ebn0 = cn + satdata.bandwidth - satdata.bitrate;

disp("received power");
disp(recvPower);
disp("carrier to noise ratio");
disp(cn);
disp("energy per bits to noise power desnity ratio");
disp(ebn0);
disp("eirp");
disp(eirp);
disp("grts");
disp(grts);
disp("pathloss");
disp(pathLoss);
