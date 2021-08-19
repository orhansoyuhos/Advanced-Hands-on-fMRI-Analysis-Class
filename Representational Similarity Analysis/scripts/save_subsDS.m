%% Generate COSMO DS structure

function save_subsDS(subs_fMRI, ROIs, results_path)

%% Setting paths 
mkdir(results_path);

%% Info
subjs =  {'SUB01', 'SUB02', 'SUB03', 'SUB04', 'SUB05', 'SUB06', 'SUB07', 'SUB08', 'SUB09', 'SUB10', 'SUB11', 'SUB12'};
numSubjs = size(subjs, 2);
naROI =  {'V1', 'VTC-ant', 'VTC-post'};
ROI =  {'V1.nii', 'VTC_ant.nii', 'VTC_post.nii'};
numROIs = size(ROI, 2);

%% Load data

f = waitbar(0, 'Looping around...');

for s = 1:numSubjs
    for r = 1:numROIs
        
        data_path = fullfile([subs_fMRI, subjs{s} ]); %data
        mask_fn = fullfile([ROIs, ROI{r}]); % ROI
        
        %% Define default targets and chunks
        targets = repmat(1:27, 1, 12);
        chunks = floor(((1:27*12) - 1) / 27) + 1 ;
        
        data_fn = fullfile(data_path, 'SPM.mat');
        
        %% Generate COSMO DS structure
        ds = cosmo_fmri_dataset(data_fn, 'mask', mask_fn, 'targets', targets, 'chunks', chunks);
        
        cosmo_check_dataset(ds);
        
        %% Remove constant features
        ds = cosmo_remove_useless_data(ds);

        %% Setting paths
        name_file = fullfile([results_path, subjs{s}, '_' naROI{r} '_ds']);
        save(name_file, 'ds');
    end
    
    waitbar(s/numSubjs, f, sprintf('Progress: %d %%', floor(s/numSubjs*100)));
end
close(f)

end