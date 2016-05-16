% Single Segment Actual Status
function [] = update_status(file_name_flow, file_name_occ, file_name_speed)

info_matrix = read_file(file_name_flow, file_name_occ, file_name_speed);

% filter should be applied to the info_matrix

curve_func_struct = createFit(info_matrix);
%curve_func = @(x)curve_func_struct.p1*x^2+curve_func_struct.p2*x+curve_func_struct.p3;
% a function of variable flow, value speed is generated under quadratic
% form.

flow_max = - curve_func_struct.p2 / (curve_func_struct.p1 * 2);
speed_max = - (curve_func_struct.p2) ^ 2 / (curve_func_struct.p1 * 4) + curve_func_struct.p3;
disp(flow_max);
disp(speed_max);

end