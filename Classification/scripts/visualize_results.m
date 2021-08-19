function visualize_results(pair, results_path, figures_path)

%% Plot the results

%% Setting paths
mkdir(figures_path)

%% Info
subjs =  {'SUB01', 'SUB02', 'SUB03', 'SUB04', 'SUB05', 'SUB06', 'SUB07', 'SUB08', 'SUB09', 'SUB10', 'SUB11', 'SUB12'};
numSubjs = size(subjs, 2);
naROI =  {'V1', 'VTC-ant', 'VTC-post'};
ROI =  {'V1.nii', 'VTC_ant.nii', 'VTC_post.nii'};
numROIs = size(ROI, 2);

%% Load the results
name_file = fullfile([results_path, 'OVO_', pair]);
load(name_file, 'results');

%% Plot
% bar
bar(mean(results), 'c');
hold on;

% standard error of mean
SEM = std(results) / sqrt(size(results, 1)); 
errorbar( mean(results), SEM, '.');
% add a line indicating accuracy at chance
line([0 numROIs+1], [1/9 1/9]); 

% add labels
set(gca, 'XTick', 1:numROIs, 'XTickLabel', naROI); % labels
ylabel('Accuracy');
ylim([0 0.25]);

if strcmp(pair, 'lookalike-animal')
    name = 'Trained on Lookalike Objects and Tested on Animals';
elseif strcmp(pair, 'lookalike-object')
    name = 'Trained on Lookalike Objects and Tested on Inanimate Objects';
elseif strcmp(pair, 'animal-object')
    name = 'Trained on Animals and Tested on Inanimate Objects';
end
title(name)

saveas(gcf, fullfile([figures_path, pair, '.png']));

end