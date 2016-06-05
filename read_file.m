function info_matrix = read_file (file_name_flow,  file_name_speed)
[~, Day1, ~, H1, M1, ~, ~, ~, ~, Flow, ~, ~] = textread(file_name_flow,'%n/%n/%n %n:%n %n %n %n %n %n %n %n', 'headerlines', 1);
[~, ~, ~, ~, ~, ~, ~, ~, ~, Speed, ~, ~] = textread(file_name_speed,'%n/%n/%n %n:%n %n %n %n %n %n %n %n','headerlines', 1);
time_stamp = (Day1 - Day1(1)) * 1440 + H1 * 60 + M1;
info_matrix = [time_stamp, Flow, Speed];
end

% DESCRIPTIVE TEXT