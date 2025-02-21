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
    % Create an instance of the constants class
    obj = Position_velocity_doppler_shift;

    % Define orbital parameters
    altitude = obj.ORBIT_ALTITUDE;  
    earth_radius = obj.EARTH_RADIUS;
    mu = obj.EARTH_MU;

    % Calculate semi-major axis (for circular orbit)
    a = earth_radius + altitude; 
    
    % Calculate orbital speed using vis-viva equation
    velocity = sqrt(mu / a);
    
    % Time vector (one orbit period)
    T = 2 * pi * sqrt(a^3 / mu); % Orbital period
    t = linspace(0, T, 1000); % Time steps

    % Compute satellite position over time (assuming equatorial orbit)
    theta = 2 * pi * t / T;  
    x_sat = a * cos(theta);
    y_sat = a * sin(theta);
    z_sat = zeros(size(t)); % Equatorial orbit

    % Observer position (approximated as fixed on Earth's surface)
    observer_lat = deg2rad(obj.COV_LATITUDE);
    observer_long = deg2rad(obj.COV_LONGITUDE);
    observer_x = earth_radius * cos(observer_lat) * cos(observer_long);
    observer_y = earth_radius * cos(observer_lat) * sin(observer_long);
    observer_z = earth_radius * sin(observer_lat);

    % Compute relative velocity and Doppler shift
    doppler_shift = zeros(size(t));

    for i = 1:length(t)
        % Compute relative position vector
        relative_x = x_sat(i) - observer_x;
        relative_y = y_sat(i) - observer_y;
        relative_z = z_sat(i) - observer_z;
        relative_distance = sqrt(relative_x^2 + relative_y^2 + relative_z^2);

        % Compute unit line-of-sight vector
        los_vector = [relative_x; relative_y; relative_z] / relative_distance;

        % Compute satellite velocity vector (perpendicular to radius in circular motion)
        velocity_vector = velocity * [-sin(theta(i)); cos(theta(i)); 0];

        % Compute radial velocity (dot product of velocity and line-of-sight)
        vr = dot(velocity_vector, los_vector);

        % Doppler shift calculation
        doppler_shift(i) = obj.FREQUENCY_BAND * vr / obj.SPEED_OF_LIGHT;
    end

    % Plot results
    figure;
    subplot(2,1,1);
    plot(t, doppler_shift);
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
satellite_tracking();
