%% Visualize the results.

function visualize_results(subs_RDMs, lower_models_vect, RSA_fisher_parcorr, RSA_statistics, figures_path)

%% Setting paths
mkdir(figures_path)

%% Info
subjs =  {'SUB01', 'SUB02', 'SUB03', 'SUB04', 'SUB05', 'SUB06', 'SUB07', 'SUB08', 'SUB09', 'SUB10', 'SUB11', 'SUB12'};
numSubjs = size(subjs, 2);
naROI =  {'V1', 'VTC-ant', 'VTC-post'};
ROI =  {'V1.nii', 'VTC_ant.nii', 'VTC_post.nii'};
numROIs = size(ROI, 2);

%% Average RDMs of each RIOs across all subjects

f = figure;
f.Position = 100 + 3*[0 75 400 75];

for r = 1:numROIs
    tmp_RDM = 0;
    for s = 1:numSubjs
        
        name_file = fullfile([subs_RDMs, sprintf('%s_%s_RDM', subjs{s}, naROI{r})]);
        per_RDM = load(name_file);
        
        tmp_RDM = tmp_RDM + per_RDM.RDM.data_unflatten;

    end
    tmp_RDM = tmp_RDM / numROIs;
    
    subplot(1, numROIs, r);
    imagesc(tmp_RDM);
    title(naROI{r});
end
sgt = sgtitle(sprintf('RDMs of Three ROIs Averaged Across Subjects'));
sgt.FontSize = 14;

saveas(f, fullfile([figures_path, 'ROIs_across_subjects.png']));

%% Load models 

name_file = fullfile([lower_models_vect, 'models']);
load(name_file, 'models');
models_names = {'H1: lookalike-animal', 'H2: lookalike-object'};

%% RSA between models and fMRI data

name_file = fullfile([RSA_fisher_parcorr, 'RSA_fisher_parcorr']);
load(name_file, 'RSA_fisher_parcorr');
name_file = fullfile([RSA_statistics, 'statistics']);
load(name_file, 'statistics');

results = zeros(numROIs, length(models.names));
tmp_results = zeros(numSubjs, length(models.names), numROIs);
SEMs = zeros(numROIs, length(models.names));
noiseCeiling = zeros(numROIs, 1);

for r = 1:numROIs
    tmp_results(:, :, r) = RSA_fisher_parcorr(:, :, r);
    results(r, :) = mean(tmp_results(:, :, r));
    
    % standard error of mean
    SEMs(r, :) = std(tmp_results(:, :, r)) / sqrt(size(tmp_results(:, :, r), 1));
    % noise-ceiling 
    noiseCeiling(r) = statistics{r}.noiseCeiling; 
end

% for lines 83-89 please see: https://it.mathworks.com/matlabcentral/answers/444743-multiple-bar-plots-and-error-bars
f = figure('Position', get(0, 'Screensize'));

hBar = bar(results, 0.8);                                           
for k1 = 1:size(results, 2)
    ctr(k1,:) = bsxfun(@plus, hBar(k1).XData, hBar(k1).XOffset');   
    ydt(k1,:) = hBar(k1).YData;                                     
end
hold on
errorbar(ctr, ydt, SEMs', '.r')      

% add lines indicating noise-ceiling
pos = [0.75 1.25];
for ii = 1:length(noiseCeiling)
    line(pos, [noiseCeiling(ii) noiseCeiling(ii)], 'Color', 'black');
    pos = pos+1;
end

set(gca, 'XTick', 1:numROIs, 'XTickLabel', [naROI]); 
sgt = sgtitle('RSA Between Models and ROIs');
sgt.FontSize = 16;
sgt.FontWeight = 'bold';
legend([models_names])

saveas(f, fullfile([figures_path, 'RSA Between Models and ROIs.png']));

end
