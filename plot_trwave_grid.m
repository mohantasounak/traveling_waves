function [chan_pos_L, wave_label,wave_area,  wave ] = plot_twave_grid(angle_diff, desired_time_win,  AAA, jitterAmount, colorbar_val, off, seed_no, coord1, label_n)
%UNTITLED6 Summary of this function goes here
% inputs:
% angle_diff = 'phase differences across electrode calculated from
% 'tw_avg_over_trl_n_time.mat'. 

% desired_time_win = window of interest

% AAA = title for plots

% jitterAmount = jitter for plotting colorbar_val

% off = 'on' if plots need to be displayed else 'off'

% seed_no = seed number for random number generator

%coord1 =  coordinates of the electrodes

% label_n = labels of the electrodes






%creating a layout for visualization
cHoi = extractAfter(angle_diff{1,1}.label, ":");
cHoi_hem = extractBefore(angle_diff{1,1}.label, 2);

angle_diff{1, 1}.label = cellstr(angle_diff{1, 1}.label);
angle_diff_lh = angle_diff;
for i = 1:size(cHoi, 1)
 
    cHoi_ind = find(strcmp(cHoi(i), angle_diff{1, 1}.elec.label ) == 1);
    cHoi_chanpos(i, :) = angle_diff{1, 1}.elec.chanpos(cHoi_ind, :);
if strcmp(cHoi_hem(i), "lh") | strcmp(cHoi_hem(i), "L") | strcmp(cHoi_hem(i), "l")
    cHoi_chanpos(i, 1) = 0;
elseif strcmp(cHoi_hem(i), "rh") | strcmp(cHoi_hem(i), "R") | strcmp(cHoi_hem(i), "r")
    cHoi_chanpos(i, 1) = 1;
end
end

% divide into LH and RH

chan_pos_L = cHoi_chanpos;

%% plot
%% 
xx = (-1)*(normalize(chan_pos_L(:, 2), 'range', [1 size(chan_pos_L, 1)])); % change 31
yy = normalize(chan_pos_L(:, 3), 'range', [1 size(chan_pos_L, 1)]); %change 31

rng(seed_no);
jitterValuesX = 2*(rand(size(xx))-0.5)*jitterAmount;   % +/-jitterAmount max
jitterValuesY = 2*(rand(size(yy))-0.5)*jitterAmount;   % +/-jitterAmount max


x = xx;
y = yy;


figure('visible', off);
p3 = scatter(-chan_pos_L(:, 2) + jitterValuesX, chan_pos_L(:, 3) + jitterValuesY , 500, angle_diff_lh{1, 1}.trial{1, 1}   , 's', 'filled'); hold on;
text(-chan_pos_L(:, 2) + jitterValuesX, chan_pos_L(:, 3) +  jitterValuesY, extractAfter(angle_diff_lh{1, 1}.label2(:, 1), 1));hold on;



plot(-coord1(:, 2), coord1(:, 3), 'kd'); hold off;

x_op = x + jitterValuesX;
y_op = y+ jitterValuesY;


wave = angle_diff_lh{1, 1}.trial{1, 1};

wave_label =  extractAfter(angle_diff_lh{1, 1}.label2(:, 1), 1);
wave_area = extractBefore(angle_diff_lh{1, 1}.label2(:, 3), ' ');
xticks = get(gca, 'xtick');
set(gca, 'xTick', [min(xticks) max(xticks)], ...
         'xTickLabel', {'anterior', 'posterior'});
yticks = get(gca, 'ytick');

set(gca, 'ytick', [min(yticks) max(yticks)], ...
         'yTickLabel', {'ventral', 'dorsal'});



title(sprintf('%s from %1.1f to %1.1f secs', AAA, desired_time_win(1)  ...
    , desired_time_win(2)));
colorbar();
colormap jet;
caxis(colorbar_val);


end

