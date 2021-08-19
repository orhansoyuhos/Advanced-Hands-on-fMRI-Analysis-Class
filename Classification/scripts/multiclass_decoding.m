%% Generate COSMO DS structure

function multiclass_decoding(pair, subs_fMRI, ROIs, results_path)

%% Setting paths
mkdir(results_path);

%% Info
subjs =  {'SUB01', 'SUB02', 'SUB03', 'SUB04', 'SUB05', 'SUB06', 'SUB07', 'SUB08', 'SUB09', 'SUB10', 'SUB11', 'SUB12'};
numSubjs = size(subjs, 2);
naROI =  {'V1', 'VTC-ant', 'VTC-post'};
ROI =  {'V1.nii', 'VTC_ant.nii', 'VTC_post.nii'};
numROIs = size(ROI, 2);


%% PART 1:
% Use a multiclass decoding approach to test whether the pattern of activity for the lookalike
% objects generalises to their corresponding animals;

if strcmp(pair, 'lookalike-animal')
    
    %% Compute decoding accuracy over each ROI and subject
    results = zeros(numROIs, numSubjs);
    
    f = waitbar(0, 'Looping around...');
    
    for r = 1:numROIs
        for s = 1:numSubjs
            
            data_path = fullfile([subs_fMRI, subjs{s} ]); %data
            mask_fn = fullfile([ROIs, ROI{r}]); % ROI
            
            %% Define default targets and chunks
            tmp = repmat(1:9, 1, 3)';
            tmp = repmat(tmp, 1, 12);
            targets = tmp(:);
            
            chunks = floor(((1:27*12) - 1) / 27) + 1 ;
            chunks = chunks';
            
            data_fn = fullfile(data_path, 'SPM.mat');
            
            %% Generate COSMO DS structure
            ds = cosmo_fmri_dataset(data_fn, 'mask', mask_fn, 'targets', targets, 'chunks', chunks);
            
            cosmo_check_dataset(ds);
            
            %% Define the categories to select
            tmp = repmat(1:3, 9, 1);
            ds.sa.cat_dim = repmat(tmp(:), 12, 1);
            
            %% Select one vs one
            idx = cosmo_match(ds.sa.cat_dim, [1 2]);
            ds_OVO = cosmo_slice(ds, idx);
            
            %% Remove constant features
            ds_OVO = cosmo_remove_useless_data(ds_OVO);
            
            %% Define classifier
            args.classifier = @cosmo_classify_lda;
            args.normalization = 'demean';
            
            %% Define partitions
            args.partitions = cosmo_nchoosek_partitioner(ds_OVO, 1, 'cat_dim', []);
            
            %% Define measure
            measure = @cosmo_crossvalidation_measure;
            
            %% Decode using the measure
            ds_accuracy = measure(ds_OVO, args);
            
            %% Save
            results(r, s) = ds_accuracy.samples;
            
        end
        
        waitbar(s/numSubjs, f, sprintf('Progress: %d %%', floor(s/numSubjs*100)));
    end
    close(f)
    
    results = results';
    
    name_file = fullfile([results_path, 'OVO_', pair]);
    save(name_file, 'results');
    
%% PART 2:
% Use a multiclass decoding approach to test whether the pattern of activity for the lookalike
% objects generalises to their corresponding objects;

elseif strcmp(pair, 'lookalike-object')
    
    %% Compute decoding accuracy over each ROI and subject
    results = zeros(numROIs, numSubjs);
    
    f = waitbar(0, 'Looping around...');
    
    for r = 1:numROIs
        for s = 1:numSubjs
            
            data_path = fullfile([subs_fMRI, subjs{s} ]); %data
            mask_fn = fullfile([ROIs, ROI{r}]); % ROI
            
            %% Define default targets and chunks
            tmp = repmat(1:9, 1, 3)';
            tmp = repmat(tmp, 1, 12);
            targets = tmp(:);
            
            chunks = floor(((1:27*12) - 1) / 27) + 1 ;
            chunks = chunks';
            
            data_fn = fullfile(data_path, 'SPM.mat');
            
            %% Generate COSMO DS structure
            ds = cosmo_fmri_dataset(data_fn, 'mask', mask_fn, 'targets', targets, 'chunks', chunks);
            
            cosmo_check_dataset(ds);
            
            %% Define the categories to select
            tmp = repmat(1:3, 9, 1);
            ds.sa.cat_dim = repmat(tmp(:), 12, 1);
            
            %% Select one vs one
            idx = cosmo_match(ds.sa.cat_dim, [1 3]);
            ds_OVO = cosmo_slice(ds, idx);
            
            %% Remove constant features
            ds_OVO = cosmo_remove_useless_data(ds_OVO);
            
            %% Define classifier
            args.classifier = @cosmo_classify_lda;
            args.normalization = 'demean';
            
            %% Define partitions
            args.partitions = cosmo_nchoosek_partitioner(ds_OVO, 1, 'cat_dim', []);
            
            %% Define measure
            measure = @cosmo_crossvalidation_measure;
            
            %% Decode using the measure
            ds_accuracy = measure(ds_OVO, args);
            
            %% Save
            results(r, s) = ds_accuracy.samples;
            
        end
        
        waitbar(s/numSubjs, f, sprintf('Progress: %d %%', floor(s/numSubjs*100)));
    end
    close(f)
    
    results = results';
    
    name_file = fullfile([results_path, 'OVO_', pair]);
    save(name_file, 'results');
    
%% Bonus:    
elseif strcmp(pair, 'animal-object')
    
    %% Compute decoding accuracy over each ROI and subject
    results = zeros(numROIs, numSubjs);
    
    f = waitbar(0, 'Looping around...');
    
    for r = 1:numROIs
        for s = 1:numSubjs
            
            data_path = fullfile([subs_fMRI, subjs{s} ]); %data
            mask_fn = fullfile([ROIs, ROI{r}]); % ROI
            
                        %% Define default targets and chunks
            tmp = repmat(1:9, 1, 3)';
            tmp = repmat(tmp, 1, 12);
            targets = tmp(:);
            
            chunks = floor(((1:27*12) - 1) / 27) + 1 ;
            chunks = chunks';
            
            data_fn = fullfile(data_path, 'SPM.mat');
            
            %% Generate COSMO DS structure
            ds = cosmo_fmri_dataset(data_fn, 'mask', mask_fn, 'targets', targets, 'chunks', chunks);
            
            cosmo_check_dataset(ds);
            
            %% Define the categories to select
            tmp = repmat(1:3, 9, 1);
            ds.sa.cat_dim = repmat(tmp(:), 12, 1);
            
            %% Select one vs one
            idx = cosmo_match(ds.sa.cat_dim, [2 3]);
            ds_OVO = cosmo_slice(ds, idx);
            
            %% Remove constant features
            ds_OVO = cosmo_remove_useless_data(ds_OVO);
            
            %% Define classifier
            args.classifier = @cosmo_classify_lda;
            args.normalization = 'demean';
            
            %% Define partitions
            args.partitions = cosmo_nchoosek_partitioner(ds_OVO, 1, 'cat_dim', []);
            
            %% Define measure
            measure = @cosmo_crossvalidation_measure;
            
            %% Decode using the measure
            ds_accuracy = measure(ds_OVO, args);
            
            %% Save
            results(r, s) = ds_accuracy.samples;
            
        end
        
        waitbar(s/numSubjs, f, sprintf('Progress: %d %%', floor(s/numSubjs*100)));
    end
    close(f)
    
    results = results';
    
    name_file = fullfile([results_path, 'OVO_', pair]);
    save(name_file, 'results');
    
end

end