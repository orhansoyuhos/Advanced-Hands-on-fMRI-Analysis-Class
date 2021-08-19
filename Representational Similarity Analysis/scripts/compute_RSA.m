%% Compute RSA between models and fMRI data

function compute_RSA(lower_models_vect, subs_RDMs, results_RSA, results_stat)

%% Setting paths
mkdir(results_RSA);
mkdir(results_stat);

%% Info
subjs =  {'SUB01', 'SUB02', 'SUB03', 'SUB04', 'SUB05', 'SUB06', 'SUB07', 'SUB08', 'SUB09', 'SUB10', 'SUB11', 'SUB12'};
numSubjs = size(subjs, 2);
naROI =  {'V1', 'VTC-ant', 'VTC-post'};
ROI =  {'V1.nii', 'VTC_ant.nii', 'VTC_post.nii'};
numROIs = size(ROI, 2);

%% Load models
load(fullfile(lower_models_vect, 'models'));

%% Load fMRI data
load(fullfile(subs_RDMs, 'RDMs_all'));

for r = 1:numROIs
    
    fMRI_vect = RDMs.data(:,:,r);
    
    %% RSA with partial-corri
    RSA_parcorr(:,:,r) = partialcorri(fMRI_vect, models.lower_vect, 'Type', 'Pearson');
    
    %% Fisher transform the RSA results
    RSA_fisher_parcorr(:,:,r) = atanh(RSA_parcorr(:,:,r)); 
    
    %% ttest
    [h, p, ~, stats] = ttest(RSA_fisher_parcorr(:,:,r));
    stat.h = h;
    stat.p = p;
    stat.stats = stats;
    stat.rois = ROI{r};
    
    %% Compute noise ceiling
    for s = 1:size(fMRI_vect,2)
        one_subj = fMRI_vect(:, s);        
        
        mask = fMRI_vect;
        mask(:, s) = NaN;
        group_exceptOne = nanmean(mask, 2);
        lower_bound(s, r) = corr(one_subj, group_exceptOne);
    end
    stat.noiseCeiling = mean(lower_bound(:, r));
    
    %% Record per ROI
    statistics{r} = stat;
    
end

name_file = fullfile(results_RSA, 'RSA_fisher_parcorr');
save(name_file, 'RSA_fisher_parcorr');

name_file = fullfile(results_stat, 'statistics');
save(name_file, 'statistics');

end