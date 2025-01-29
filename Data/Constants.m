classdef Constants
    properties (Constant)
        % Physical Constants
        SPEED_OF_LIGHT = 299792458; % m/s
        BOLTZMANN_CONSTANT = 1.380649e-23; % J/K
        
        % Location-Specific Constants
        COV_LATITUDE = 52.408054; % Degrees
        COV_LONGITUDE = -1.510556; % Degrees
        
        % Antenna & Communication Parameters
        ANTENNA_GAIN = 12; % dBi
        FREQUENCY_BAND = 437.5e6; % Hz (CubeSat UHF Band)
    end
end