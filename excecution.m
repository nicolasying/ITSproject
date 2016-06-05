clc;
clear all;

pflow = prediction_micro(fileflowold,fileflownew);
pspeed = prediction_micro(filespeedold, filespeednew);

info_matrix = read_file(fileflownew, filespeednew);
[speed_max, flow_max] = update_maximal(info_matrix);

jam_matrix = set_jam_mark(info_matrix, speed_max, flow_max);