% Single Segment Actual threshold value
function [Occ_critical] = update_maximal(Occ_Matrix, Flow_Matrix)


% filter should be applied to the info_matrix

[xData, yData] = prepareCurveData( Occ_Matrix, Flow_Matrix );

% Set up fittype and options.
ft = fittype( 'poly3' );

% Fit model to data.
[curve_func_struct] = fit( xData, yData, ft );


Occ_critical = (-curve_func_struct.p2 - sqrt((curve_func_struct.p2)^2-3*curve_func_struct.p1*curve_func_struct.p3))/(3*curve_func_struct.p1);

disp('Updated Critical Occupancy: ');
disp(Occ_critical);
%disp(speed_max);

end