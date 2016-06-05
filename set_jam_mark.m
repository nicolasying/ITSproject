function [ jam_matrix ] = set_jam_mark ( info_matrix, speed_max, flow_max )
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here

% This function uses the speed_max and flow_max, to mark all the possible
% time stamps with the flag if the road is jammed, 1 stands for jammed, 0
% stands for no.


lines = length(info_matrix(:,1));
jam_matrix = zeros(lines,1);

for i = 1:n
    if (info_matrix(i,2) <= flow_max && info_matrix(i,3) <= speed_max)
        jam_matrix(i, 1) = 1;
    end;
end;

end

