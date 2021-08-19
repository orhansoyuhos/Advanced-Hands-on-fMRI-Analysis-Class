%% Save RDMs of each subject in a file and separately.

function save_RDMs(subs_DS, results_path)

%% Setting paths 
mkdir(results_path);
subs_RDMs = results_path;

%% Info
subjs =  {'SUB01', 'SUB02', 'SUB03', 'SUB04', 'SUB05', 'SUB06', 'SUB07', 'SUB08', 'SUB09', 'SUB10', 'SUB11', 'SUB12'};
numSubjs = size(subjs, 2);
naROI =  {'V1', 'VTC-ant', 'VTC-post'};
ROI =  {'V1.nii', 'VTC_ant.nii', 'VTC_post.nii'};
numROIs = size(ROI, 2);

%% PART 1: Save each RDMs separately.
f = waitbar(0, 'Looping around...');

for s = 1:numSubjs
    for r = 1:numROIs
        
        %% Load fMRI DS
        name = sprintf('%s_%s_ds.mat', subjs{s}, naROI{r});
        filename = fullfile(subs_DS, name);
        load(filename, 'ds');
        
        cosmo_check_dataset(ds);
        % remove constant features
        ds = cosmo_remove_useless_data(ds);
        
        %% Compute avg across runs with cosmo cosmo_fx
        f_ds = cosmo_fx(ds, @(x)mean(x,1), 'targets');
        
        %% Compute RDM with cosmo_dissimilarity_matrix_measure
        ds_dsm = cosmo_dissimilarity_matrix_measure(f_ds, 'metric', 'correlation', 'center_data', true);
        
        [samples, ~, ~] = cosmo_unflatten(ds_dsm, 1, 'set_missing_to', NaN);
        
        %% store results
        RDM.data = ds_dsm.samples;
        RDM.data_unflatten = samples;
        RDM.ROIs = subjs{s};
        RDM.SUB = naROI{r};
        
        name_file = fullfile([subs_RDMs, sprintf('%s_%s_RDM', subjs{s}, naROI{r})]);
        save(name_file, 'RDM');
        
    end
    
    waitbar(s/numSubjs, f, sprintf('Progress: %d %%', floor(s/numSubjs*100)));
end
close(f)


%% PART 2: Save All RDMs in a file.
RDMs = struct;
RDMs.ROIs = naROI;
RDMs.subjs = subjs;

for s = 1:numSubjs
    for r = 1:numROIs
        
        name_file = fullfile([subs_RDMs, sprintf('%s_%s_RDM', subjs{s}, naROI{r})]);
        per_RDM = load(name_file);
        
        RDMs.data(:,s,r) = per_RDM.RDM.data;
        RDMs.data_unflatten{s,r} = per_RDM.RDM.data_unflatten;
    end
end

name_file = fullfile(subs_RDMs, 'RDMs_all');
save(name_file, 'RDMs');

end