classdef satData
    % satelite data ie losses and distances
    properties
        distanceTo = satData.getData("Transmitter data").Distance(1);
        % antenna gains
        recvGain = satData.toDecibel(satData.getData("Receiver data").Gain(1));
        transGain = satData.toDecibel(satData.getData("Transmitter data").Gain(1));
        % RF frequency
        frequency = satData.getData("Transmitter data").Frequency(1);
        transmitPower = satData.toDecibel(satData.getData("Transmitter data").Power(1));
        temp = satData.toDecibel(satData.getData("Receiver data").Temperature(1));
        bandwidth = satData.toDecibel(satData.getData("Receiver data").Bandwidth(1));
        bitrate = satData.toDecibel(satData.getData("Transmitter data").Bitrate(1));
        miscLoss = satData.sumLoss();
    end
% define a method that takes values from tables
    methods (Static)
        function d = toDecibel(value)
            d = 10 * log10(value);
        end 
        function dataTable = getData(sheetsname)
            dataTable = readtable("linkbudgetspreadsheet.xlsx", "Sheet", sheetsname);
        end

        function x = sumLoss(~)
            dataTable = readtable("linkbudgetspreadsheet.xlsx", "Sheet", "Other Loss");
            x = satData.toDecibel(dataTable.Atmospheric(1))+satData.toDecibel(dataTable.RecvFeeder(1)) + satData.toDecibel(dataTable.TransFeeder(1))+satData.toDecibel(dataTable.Polarisation(1));
        end
    end 
end 
    
% define a method that converts values to decibels
% define a method that sums losses from 'other' obstructions ie atmospheric
% and rain alignment etc


