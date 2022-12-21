function [data_hilbert_transform] = prepoc_hilber_phase(data_reref_WM_deleted_correct_50, frequencyranges )
%% inputs
% data_reref_WM_deleted_correct_50 = fieldtrip format data
% frequencyranges = frequency ranges hilbert transform needs to be
% calculated

% outputs
% data_hilbert_transform = fieldtrip data saved in a cell
%% code
for i = 1:size(frequencyranges,1)
    if length(data_reref_WM_deleted_correct_50.trial) > 1

cfg = [];
cfg.bpfilter = 'yes';
cfg.bpfreq = [frequencyranges(i, 1) frequencyranges(i, 2)];
cfg.bpfilttype = 'but';
cfg.hilbert = 'angle';
 cfg.bpfiltord     = 4;
 cfg.bpfiltdir = 'twopass';
data_phase = ft_preprocessing(cfg, data_reref_WM_deleted_correct_50);



data_hilbert_transform{i} = data_phase;
for k = 1:size(data_phase.trial, 2)
%     data_phase.trial{1, k} = unwrap(data_phase.trial{1, k});
    data_phase.trial{1, k} = (data_phase.trial{1, k});

end
data_hilbert_transform{i} = data_phase;





data_hilbert_transform{i}.label = strcat(data_reref_WM_deleted_correct_50.label2(:,1), ":", string(data_reref_WM_deleted_correct_50.label));
data_hilbert_transform{i}.label2 = data_reref_WM_deleted_correct_50.label2; 
data_hilbert_transform{i}.time = data_phase.time;
data_hilbert_transform{i}.elec = data_phase.elec;


else
  cfg = [];
cfg.bpfilter = 'yes';
cfg.bpfreq = [frequencyranges(i, 1) frequencyranges(i, 2)];
% cfg.bpfilttype = 'fir';
cfg.hilbert = 'angle';
data_phase = ft_preprocessing(cfg, data_reref_WM_deleted_correct_50);
data_hilbert_transform{i} = data_phase;





data_hilbert_transform{i}.label = strcat(data_reref_WM_deleted_correct_50.label2(:,1), ":", string(data_reref_WM_deleted_correct_50.label));
data_hilbert_transform{i}.label2 = data_reref_WM_deleted_correct_50.label2; 
data_hilbert_transform{i}.time = data_phase.time;
data_hilbert_transform{i}.elec = data_phase.elec;


    end
end


end

