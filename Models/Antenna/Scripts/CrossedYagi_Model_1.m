F = 435e6;             % operating frequency (Hz)
C = 3e8;               % speed of light (m/s)
W = C / F;            % wavelength (m)
N = 5;        % number of elements


% Creating the antenna
yagi1 = design(yagiUda, F);


% Element dimensions
reflector_L = 0.55 * W;  % Reflector length
dipole_L = 0.5 * W;      % Driven element length
director_L = 0.44 * W;   % Director length
dipole_width = 0.005 * W; % Dipole width


% Setting reflector and director lengths
yagi1.ReflectorLength = reflector_L;
yagi1.DirectorLength = director_L;


% Setting spacing between elements
yagi1.ReflectorSpacing = 0.35 * W;  % Reflector spacing
yagi1.DirectorSpacing = 0.2 * W;    % Director spacing


% Setting dipole
exciter = dipole('Length', dipole_L, 'Width', dipole_width, "Tilt", 90, "TiltAxis", [0 1 0]);
yagi1.Exciter = exciter;


% Creating second part of crossed antenna
yagi2 = copy(yagi1);


% Crossing antennas
yagi2.Tilt = 90;
yagi2.TiltAxis = [0, 0, 1];


% Creating a conformal array to combine both antennas
crossedYagiArray = conformalArray;
crossedYagiArray.Element = {yagi1, yagi2};
crossedYagiArray.ElementPosition(1, :) = [0 0 0];
crossedYagiArray.ElementPosition(2, :) = [0 0 0.00000000001];
crossedYagiArray.PhaseShift = [0 90];

% Physical display of antenna
figure;
show(crossedYagiArray);
title('Antenna Design');


% Radiation pattern of antenna
figure;
pattern(crossedYagiArray, F);
title('Radiation Pattern of Antenna');