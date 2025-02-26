classdef Position_velocity_doppler_shift
    properties (Constant)
        % Physical Constants
        SPEED_OF_LIGHT = 299792458; % m/s
        BOLTZMANN_CONSTANT = 1.380649e-23; % J/K
        
        % Earth and Orbital Parameters
        EARTH_RADIUS = 6371e3; % meters
        EARTH_MU = 3.986e14; % m^3/s^2 (gravitational parameter)
        
        % Observer Location
        COV_LATITUDE = 52.408054; % Degrees
        COV_LONGITUDE = -1.510556; % Degrees
        
        % Satellite Parameters
        ORBIT_ALTITUDE = 500e3; % meters (500 km)
        FREQUENCY_BAND = 437.5e6; % Hz (UHF Band)
    end
end

% Function to compute satellite position, velocity, and Doppler shift
function satellite_tracking()

    % Define orbital parameters
    altitude = Constants.ORBIT_ALTITUDE;  
    earth_radius = Constants.EARTH_RADIUS;
    mu = Constants.EARTH_MU;

    % Calculate semi-major axis (for circular orbit)
    a = earth_radius + altitude; 
    
    % Calculate orbital speed using vis-viva equation
    velocity = sqrt(mu / a);
    
    % Time vector (one orbit period)
    T = 2 * pi * sqrt(a^3 / mu); % Orbital period
    t = linspace(0, T, 1000); % Time steps

    % Compute satellite position over time
    theta = 2 * pi * t / T;  % Assuming uniform circular motion
    x_sat = a * cos(theta);
    y_sat = a * sin(theta);
    z_sat = 0; % Assume equatorial orbit for simplicity

    % Observer position (approximated as fixed on Earth's surface)
    observer_lat = deg2rad(Constants.COV_LATITUDE);
    observer_long = deg2rad(Constants.COV_LONGITUDE);
    observer_x = earth_radius * cos(observer_lat) * cos(observer_long);
    observer_y = earth_radius * cos(observer_lat) * sin(observer_long);
    observer_z = earth_radius * sin(observer_lat);

    % Compute relative velocity and Doppler shift
    doppler_shift = zeros(size(t));

    for i = 1:length(t)
        % Compute radial velocity (projected velocity along observer-satellite line)
        relative_x = x_sat(i) - observer_x;
        relative_y = y_sat(i) - observer_y;
        relative_distance = sqrt(relative_x^2 + relative_y^2);
        
        % Radial velocity approximation (assuming observer directly below satellite)
        vr = velocity * sin(theta(i)); 
        
        % Doppler shift calculation
        doppler_shift(i) = Constants.FREQUENCY_BAND * (Constants.SPEED_OF_LIGHT + vr) / Constants.SPEED_OF_LIGHT;
    end

    % Plot results
    figure;
    subplot(2,1,1);
    plot(t, doppler_shift - Constants.FREQUENCY_BAND);
    title('Doppler Shift over Time');
    xlabel('Time (s)');
    ylabel('Frequency Shift (Hz)');
    grid on;

    subplot(2,1,2);
    plot(x_sat, y_sat, 'b'); hold on;
    plot(observer_x, observer_y, 'ro', 'MarkerSize', 10, 'MarkerFaceColor', 'r');
    title('Satellite Orbit and Observer Position');
    xlabel('X Position (m)');
    ylabel('Y Position (m)');
    legend('Satellite Orbit', 'Observer');
    axis equal;
    grid on;
end

% Run the tracking function
satellite_tracking()


