function [angle_diff2, angle_raw, coord1, label_name1] = prepoc_twave(data_trial_avg, data_trial_avg_sub, toi, avg_across_trials)
%UNTITLED11 Summary of this function goes here
% input
% data_trial_avg = phase calculated data (generally ouput from hibert calculation).
% data_trial_avg_sub = same data as data_trial_avg
% toi =  time window of interest.
% avg_across_trials = if data is averaged across trial put 1 else put 0 

% output
% angle_diff2 = travelling wave at each electrode
% angle_raw = raw phase at each electrode
% label_name1 = label of each electrode

% output

% angle_diff2 = traveling wave. Fiedltrip  structure saved inside a cell. angle_diff2.trial{1, number of trials} is [chan x time]
% angle_raw = Raw phase. Fiedltrip  structure saved inside a cell. angle_raw.trial{1, number of trials} is [chan x time]
% coord1 = electrode coordinates 
% label_name1 = label names
%% code
% time window in v epoched data to be replaced with fixation
time_sub_ind1 = knnsearch((data_trial_avg_sub{1, 1}.time{1, 1} - toi(1))', 0);
time_sub_ind2 = knnsearch((data_trial_avg_sub{1, 1}.time{1, 1} - toi(2))', 0);
%%
angle_diff = data_trial_avg;
cHoi = extractAfter(angle_diff{1,1}.label, ":");
cHoi_hem = extractBefore(angle_diff{1,1}.label, 2);

angle_diff{1, 1}.label = cellstr(angle_diff{1, 1}.label);
angle_diff_lh = angle_diff;
for i = 1:size(cHoi, 1)
 
    cHoi_ind = find(strcmp(cHoi(i), angle_diff{1, 1}.elec.label ) == 1);
    cHoi_chanpos(i, :) = angle_diff{1, 1}.elec.chanpos(cHoi_ind, :);
end

% divide into LH and RH

chan_pos_L = cHoi_chanpos;

xx = normalize(chan_pos_L(:, 2), 'range', [0, 1]); % change 31
yy = normalize(chan_pos_L(:, 3), 'range', [0, 1]); %change 31
% distance from ventro-posterior point
distances = sqrt((xx-min(xx)).^2 + (yy-min(yy)).^2); %anterior ventral: xx-max, y-min



% % % % Step 3: Find the correct sorted order:
[~, order2] = sort(distances, 'ascend');

% ventro_pos = lat_temp(order2(1));
ventro_pos = order2(1);
% ventro_pos = frontal(order2(1));

coord1 = chan_pos_L(ventro_pos, :);
label_name1 = angle_diff{1, 1}.label2(ventro_pos, 1);




%%
% if avg_across_trials == 0 
for i=1:size(data_trial_avg, 2)
if length(data_trial_avg{i}.trial) == 1
%     data_trial_avg{i}.trial{1,1} = unwrap(data_trial_avg{i}.trial{1,1}, [], 2);
data_of_in = data_trial_avg{i}.trial{1,1}(:, time_sub_ind1:time_sub_ind2);
data_of_in_sub = data_trial_avg_sub{i}.trial{1,1}(:, time_sub_ind1:time_sub_ind2);

angle_diff2{i}.trial{1, 1} = circ_dist(data_of_in, repmat(circ_mean(data_of_in_sub),[size(data_of_in, 1) 1]));
% delay_avg = circ_mean(data_trial_avg_sub{i}.trial{1,1});
% delay_avg_total =  circ_mean(delay_avg(:, time_sub_ind1: time_sub_ind2), [], 2);
% angle_diff{i}.trial{1, 1} = circ_dist(data_trial_avg{i}.trial{1,1}, repmat( delay_avg_total,[size(data_trial_avg{i}.trial{1,1}, 1) size(data_trial_avg{i}.trial{1,1}, 2)]));
% angle_diff{i}.trial{1, 1} = circ_dist(data_trial_avg{i}.trial{1,1}, repmat( delay_avg_total,[size(data_trial_avg{i}.trial{1,1}, 1) size(data_trial_avg{i}.trial{1,1}, 2)]));


angle_diff2{i}.label = (data_trial_avg{i}.label);
angle_diff2{i}.label2 = data_trial_avg{i}.label2; 
angle_diff2{i}.time = data_trial_avg{i}.time(:, time_sub_ind1:time_sub_ind2);
angle_diff2{i}.elec = data_trial_avg{i}.elec;
angle_diff2{i}.dimord = 'chan_freq_time';
elseif length(data_trial_avg{i}.trial) > 1
 for kk = 1:length(data_trial_avg{i}.trial) 
data_of_in = data_trial_avg{i}.trial{1,kk}(:, time_sub_ind1:time_sub_ind2);
data_of_in_sub = data_trial_avg_sub{i}.trial{1,kk}(:, time_sub_ind1:time_sub_ind2);


% subtracting mean phase of the ventro posterior most electrode from all
% electrodes
angle_diff2{i}.trial{1, kk} = circ_dist(data_of_in, repmat(circ_mean(data_of_in_sub(ventro_pos, :)),[size(data_of_in, 1) 1]));




angle_diff2{i}.label = (data_trial_avg{i}.label);
angle_diff2{i}.label2 = data_trial_avg{i}.label2; 
angle_diff2{i}.time{1,1} = data_trial_avg{i}.time{1, kk}(:, time_sub_ind1:time_sub_ind2);
angle_diff2{i}.elec = data_trial_avg{i}.elec;
angle_diff2{i}.dimord = 'chan_time';
 angle_raw = angle_diff2;
 angle_raw{i}.trial{kk} = data_of_in;
end
end
end

   
end


