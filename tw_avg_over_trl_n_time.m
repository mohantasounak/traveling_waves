function [angle_diffn, angle_diff_chan_by_time] = tw_avg_over_trl_n_time(angle_diff)

% output
% angle_diffn = traveling wave average over all trials and toi. Fiedltrip  structure saved inside a cell. angle_diffn.trial is [chan x 1]
% angle_diff_chan_by_time = traveling wave average over all trials. Fiedltrip  structure saved inside a cell. angle_diff_chan_by_time.trial is  [chan x
% time]

%% code

%   averages over all trials and then over the time axis. Produces a matrix
%   of chan X 1
        [angle_diffn] = fieldtrip2trial_avg(angle_diff);% data_trial_avg will be of size chan X time
angle_diff_chan_by_time = angle_diffn;
angle_diffn{1}.trial{1,1} = circ_mean(angle_diffn{1}.trial{1,1}, [], 2);
angle_diffn{1}.elec = angle_diff{1}.elec;
angle_diffn{1}.dimord = 'chan_time';

end

