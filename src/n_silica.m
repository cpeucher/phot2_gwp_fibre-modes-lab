function n = n_silica(xge,xf,lambda)
% Refractive index of GeO2 and F-doped silica 
%
% -------------------------------------------------------------------------
% DESCRIPTION:
% -------------------------------------------------------------------------
% This function returns the refractive index of GeO2 and F-doped silica
% glass as a function of the mole fractions of the dopants.
% The refrative index is calculated according to a 3-term Sellmeier
% expansion.
%
% The coefficients of the expansion are those from
%
% W. Hermann and D. Wiechert, “Refractive index of doped and undoped PCVD 
% bulk silica,” Mater. Res. Bull. 24, 1083 (1989)
% doi:10.1016/0025-5408(89)90065-2.
% 
% The range of validity of a similar expansion for undoped silica was
% reported in 
%
% I. H. Malitson, “Interspecimen comparison of the refractive index of 
% fused silica,” J. Opt. Soc. Am. 55, 1205 (1965) 
% doi:10.1364/JOSA.55.001205
%
% to be 200-3700 nm
%
% It was later shown in
%
% C. Tan, “Determination of refractive index of silica glass for infrared 
% wavelengths by IR spectroscopy,” J. Non Cryst. Solids 223, 158 (1998)
% doi:10.1016/S0022-3093(97)00438-9
%
% that it  could be used up to 6700 nm.
%
% -------------------------------------------------------------------------
% FUNCTION CALL:
% -------------------------------------------------------------------------
% 
%
% -------------------------------------------------------------------------
% INPUTS:
% -------------------------------------------------------------------------
% xge               mole fraction of germania (GeO2) [scalar]
%
% xf                mole fraction of fluorine (F) [scalar]
%
% lambda            wavelength, in micrometre [real vector]
%
% -------------------------------------------------------------------------
% OUTPUTS:
% -------------------------------------------------------------------------
% n                 refractive index [real vector]gnal structure]
%                       This is it.
%
% -------------------------------------------------------------------------
% GLOBAL:
% -------------------------------------------------------------------------
%
%
% -------------------------------------------------------------------------
% -------------------------------------------------------------------------

a0 = [0.697668 0.407339 0.889883]';
da_ge = [0.031510 0.267302 -0.012950]';
da_f = [-3.234366 0.164911 1.369490]';

lambda0 = [0.070861 0.113600 9.784231]'; 
dlambda_ge = [0.001677 0.032138 0.318034]';
dlambda_f = [-1.108703 0.752919 2.906858]';
% Coefficients according to Hermann and D. Wiechert

ai = a0 + xge*da_ge + xf*da_f;
% Strengths of the oscillators in the Sellmeier expansion

lambdai = lambda0 + xge*dlambda_ge + xf*dlambda_f; 
% Wavelengths of the oscillators in the Sellmeier expansion, in micrometer

lambda = lambda(:)';
% Ensure lambda is a line vector

n = sqrt( 1 + sum(ai*lambda.^2 ./ (lambda.^2 - lambdai.^2),1));
% Refractive index according to 3-term Sellmeier expansion

end