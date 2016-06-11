function [ jam_matrix ] = set_jam_mark ( occ_matrix, speed_matrix , speed_max, Occ_critical )
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here

% This function uses the speed_max and flow_max, to mark all the possible
% time stamps with the flag if the road is jammed, 1 stands for jammed, 0
% stands for no.


lines = length(occ_matrix);
jam_matrix = zeros(lines,1);

for i = 1:lines
    if (occ_matrix(i) >= Occ_critical && speed_matrix(i) <= speed_max)
        jam_matrix(i, 1) = 1;
    end;
end;

figure('Name', 'Jam Status');
h = plot( 1:lines, jam_matrix );
legend( h, 'Jam', 'Location', 'NorthEast' );
% Label axes
xlabel Time
ylabel 'Jam Flag'
grid off
ylim([0 1.3])
end

