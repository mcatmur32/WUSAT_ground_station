% Operating frequency and constants
f = 435e6;             % operating frequency (Hz)
c = 3e8;               % speed of light (m/s)
wavelength = c / f;    % wavelength (m)
n_elements = 5;        % number of elements

% Yagi-Uda antenna design
yagi = yagiUda('NumDirectors', n_elements - 2);  % Create Yagi-Uda antenna

% Element dimensions
reflector_L = 0.495 * wavelength
dipole_L = 0.473 * wavelength
director_L = 0.440 * wavelength;
spacing = 0.125 * wavelength;
dipole_width = 0.005 * wavelength;

% Reflector and Director properties
yagi.ReflectorLength = reflector_L;
yagi.DirectorLength = director_L;
yagi.ReflectorSpacing = spacing;  % Reflector spacing
yagi.DirectorSpacing = spacing;   % Spacing between directors

% Setting Dipole
exciter = dipole('Length', dipole_L, 'Width', dipole_width, "Tilt", 90, "TiltAxis",[0 1 0]);
yagi.Exciter = exciter;

% Antenna Design
figure;
show(yagi);
title('Antenna Design');

% Radiation pattern of antenna
figure;
pattern(yagi, f);
title('Radiation Pattern of Antenna');


