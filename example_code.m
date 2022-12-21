%% add folders to path
restoredefaultpath
addpath /my fieldtrip software location here/fieldtrip folder name
ft_defaults
path(path,genpath('my traveling wave scripts here/my scripts folder name'));
path(path,genpath('my CircStat folder path/CircStat folder name'));

%% load data
load data.mat
%% user inuts
toi =  [-.4 0]; % add time window of interest
freqb = [7 12]; % frequency band of interest
sampling_freq = 250; % sampling frequency of your time series

% for ploting
seed_no = rng;
jitter = 0; % to jitter electrodes during plotting; 0 is no jitter
colorb = [-1 1]; % color axis limits
title = 'traveling wave';
%% downsample
desired_freq = 250;
cfg = [];
cfg.resamplefs = desired_freq;
data_ds = ft_resampledata(cfg, data);
%% demean
cfg = [];
cfg.demean = 'yes';
cfg.baselinewindow = toi;
data_ds = ft_preprocessing(cfg, data_ds);
data_ds.label2 = data.label2

%% calculate hilbert
[data_angle] = prepoc_hilber_phase(data_ds, freqb);

%% calculate speed
toi = toi
sdata_A1 =plateaufilthilb(data_ds, sampling_freq,freqb,.15);

cfg =[];
cfg.latency = toi;
sdata_A1 = ft_selectdata(cfg, sdata_A1)
%% calculate traveling phase
[angle_diff, angle_raw, cood, label_name] = prepoc_trwave(data_angle, data_angle, toi, 0);

data_speed_A1 = angle_diff;
data_speed_A1{1,1}.trial = sdata_A1.trial;




%% average phase differences over trials and time
[angle_diff_n, angle_diff_chan_by_time] = tw_avg_over_trl_n_time(angle_diff);

%% plot
rng('default');

[chan_pos_L, wave_label, wave] = plot_trwave_grid(angle_diff_n, toi,  title, jitter, colorb, 'on', seed_no, cood, label_name);

    