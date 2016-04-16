function info_matrix = read_file (file_name_flow, file_name_occ, file_name_speed)
[Mon1, Day1, Year1, H1, M1, Lf1, Lf2, Lf3, Lf4, Flow, Lpt1, Obs1] = textread(file_name_flow,'%n/%n/%n %n:%n %n %n %n %n %n %n %n');
[Mon2, Day2, Year2, H2, M2, Lo1, Lo2, Lo3, Lo4, Occupancy, Lpt2, Obs2] = textread(file_name_occ,'%n/%n/%n %n:%n %n %n %n %n %n %n %n');
[Mon3, Day3, Year3, H3, M3, Ls1, Ls2, Ls3, Ls4, Speed, Lpt3, Obs3] = textread(file_name_speed,'%n/%n/%n %n:%n %n %n %n %n %n %n %n');
info_matrix = [Lpt1, Obs1, Mon1, Day1, Year1, H1, M1, Flow, Occupancy, Speed];
end