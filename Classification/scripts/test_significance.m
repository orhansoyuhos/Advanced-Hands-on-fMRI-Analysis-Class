function test_significance(alpha, pair, results_path, save, workingDir)

%% Statistics

%% Info
subjs =  {'SUB01', 'SUB02', 'SUB03', 'SUB04', 'SUB05', 'SUB06', 'SUB07', 'SUB08', 'SUB09', 'SUB10', 'SUB11', 'SUB12'};
numSubjs = size(subjs, 2);
naROI =  {'V1', 'VTC_ant', 'VTC_post'};
ROI =  {'V1.nii', 'VTC_ant.nii', 'VTC_post.nii'};
numROIs = size(ROI, 2);

%% Load the results
name_file = fullfile([results_path, 'OVO_', pair]);
load(name_file, 'results');

%% Test for significance
% one-tailed one sample t test
[H, P, CI, T] = ttest(results, 1/9, 'Alpha', alpha, 'Tail', 'right');

fprintf('\n        %s%s\n', 'Test for significance: ', pair);
fprintf('\n%11s%12s%12s%12s\n', 'ROI', 'H', 'P', 'Alpha');
for ii = 1:length(H)
    fprintf('%11s %11d %11f %11.4f \n', naROI{ii}, H(ii), P(ii), alpha);
end

if save == true
    
    main_dir = pwd;
    cd(workingDir)
    
    fid = fopen( sprintf('%s%s.txt', 'statisticalResults_', pair), 'w' ) ;
    
    fprintf(fid, '\n        %s%s\n', 'Test for significance: ', pair);
    fprintf(fid, '\n%11s%12s%12s%12s\n', 'ROI', 'H', 'P', 'Alpha');
    for ii = 1:length(H)
        fprintf(fid, '%11s %11d %11f %11.4f \n', naROI{ii}, H(ii), P(ii), alpha);
    end

    fclose( fid ) ;
    
    cd(main_dir);
    fprintf('\n\n   The results are also saved in a text file.')
end

end