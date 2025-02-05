f = 435e6; 				% operating frequency (Hz)
c = 3e8; 				% speed of light (m/s)
wavelength = c / f; 			% wavelength (m)
n_elements = 5; 			% no of elements


reflector_L= 0.495 * wavelength;
dipole_L = 0.473 * wavelength;
director_L = 0.440 * wavelength;
spacing = 0.125 * wavelength;


yagi = yagiUda('Exciter', dipole);
yagi.NumDirectors = n_elements - 2;
yagi.ReflectorLength = reflector_L;
yagi.ReflectorSpacing = spacing;
yagi.DirectorLength = director_L;


figure;
show(yagi);
title('Antenna Design');


figure;
pattern(yagi, f);
title('Radiation Pattern of Antenna');


figure;
efficiency(yagi, f);
title('Efficiency of Antenna');






%https://www.elprocus.com/design-of-yagi-uda-antenna/
%https://www.wellpcb.com/blog/pcb-projects/yagi-antenna-design-formula/

