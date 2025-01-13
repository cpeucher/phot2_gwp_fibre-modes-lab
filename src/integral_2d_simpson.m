function I = integral_2d_simpson(X,Y,F)
% Double integral of a function defined on a Cartesian coordinate system by Simpson method
%
% -------------------------------------------------------------------------
% DESCRIPTION:
% -------------------------------------------------------------------------
% This function integrates the function F defined by its values on the 
% rectangular grid with equal spacings space_grid using Simpson's method
%
% -------------------------------------------------------------------------
% FUNCTION CALL:
% -------------------------------------------------------------------------
% xrange = [-13, 14];  
% yrange = [-15, 10]; 
% nxpoints = 2001;
% nypoints = 1001;
% x = linspace(xrange(1),xrange(2),nxpoints);
% y = linspace(yrange(1),yrange(2),nypoints);
% [X,Y] = meshgrid(x,y);
% [THETA,RHO] = cart2pol(X,Y);
% F = exp(-RHO.^2);
% I = integral_2d_simpson(X,Y,F); % should be pi
%
% -------------------------------------------------------------------------
% INPUTS:
% -------------------------------------------------------------------------
% X                 abscissa of the points on the 2D Cartesian space grid
%                       (obtained through meshgrid) [real matrix]
% 
% Y                 ordinates of the points on the 2D Cartesian space grid
%                       (obtained through meshgrid) [real matrix]
%
% F                 values of the function to integrate, defined as a 
%                       matrix on the Cartesian grid space_grid 
%                       [real matrix]
%
% -------------------------------------------------------------------------
% OUTPUTS:
% -------------------------------------------------------------------------
% I                value of the integral [real scalar]
%
% -------------------------------------------------------------------------
% GLOBAL:
% -------------------------------------------------------------------------
% 
%
% -------------------------------------------------------------------------
% CREDITS:
% -------------------------------------------------------------------------
% Exploits functions from:
% Introduction to Numerical Methods and Matlab Programming for Engineers
% Todd Young & Martin J. Mohlenkamp
% Copyright © 2008, 2009, 2014, 2017, 2020, 2021 Todd Young and Martin J. Mohlenkamp.
% http://www.ohiouniversityfaculty.com/youngt/IntNumMeth [retrieved
% 2021-11-24]
%
% -------------------------------------------------------------------------
% -------------------------------------------------------------------------

[m,n] = size(X);
% Size of the space grid

if ~rem(m,2)
    error('num_int2d_Simpson: the number of points on the grid should be odd.')
end

xmin = X(1,1);
xmax = X(1,n);
% Extract min and max values of the grid along the x axis

ymin = Y(1,1);
ymax = Y(m,1);
% Extract min and max values of the grid along the y axis

m = m - 1;        % m is now the number of intervals along the x axis.
n = n - 1;        % n is now the number of intervals along the y axis.

W = mydblsimpweights(m,n);
% Weights of the Riemann sum.

I=(ymax - ymin)*(xmax - xmin)*sum(sum(W.*F))/(9*m*n);
% Integral according to Simpson rule.

end