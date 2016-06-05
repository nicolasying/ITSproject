% Single Segment Actual threshold value
function [speed_max, flow_max] = update_maximal(info_matrix)


% filter should be applied to the info_matrix

curve_func_struct = createFit(info_matrix);
%curve_func = @(x)curve_func_struct.p1*x^2+curve_func_struct.p2*x+curve_func_struct.p3;
% a function of variable flow, value speed is generated under quadratic
% form.

speed_max = - curve_func_struct.p2 / (curve_func_struct.p1 * 2);
flow_max = - (curve_func_struct.p2) ^ 2 / (curve_func_struct.p1 * 4) + curve_func_struct.p3;

disp('Updated flow_max: ');
disp(flow_max);
%disp(speed_max);

end