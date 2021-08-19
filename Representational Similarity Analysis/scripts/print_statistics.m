function print_statistics(statistics_results, save, workingDir)

%% Statistics

%% Info
subjs =  {'SUB01', 'SUB02', 'SUB03', 'SUB04', 'SUB05', 'SUB06', 'SUB07', 'SUB08', 'SUB09', 'SUB10', 'SUB11', 'SUB12'};
numSubjs = size(subjs, 2);
naROI =  {'V1', 'VTC_ant', 'VTC_post'};
ROI =  {'V1.nii', 'VTC_ant.nii', 'VTC_post.nii'};
numROIs = size(ROI, 2);

pairs = {'lookalike-animal', 'lookalike-object'};

%% Load the results
name_file = fullfile([statistics_results, 'statistics']);
load(name_file, 'statistics');

%% Test for significance
fprintf('\n             %s\n', 'Test for significance:');

for r = 1:numROIs
        
    fprintf('\n%16s%24s%24s \n', 'ROI', 'H_lookalike-animal', 'P_lookalike-animal');
    fprintf('%16s %23d %23f \n', naROI{r}, statistics{r}.h(1), statistics{r}.p(1));
    fprintf('\n%16s%24s%24s \n', '   ', 'H_lookalike-object', 'P_lookalike-object');
    fprintf('%16s %23d %23f \n', '   ', statistics{r}.h(2), statistics{r}.p(2));

end

if save == true
    
    main_dir = pwd;
    cd(workingDir)
    
    fid = fopen( sprintf(['%s.txt'], 'statistical results'), 'w' ) ;
    
    fprintf(fid, '\n             %s\n', 'Test for significance:');
    for r = 1:numROIs  
        fprintf(fid, '\n%16s%24s%24s \n', 'ROI', 'H_lookalike-animal', 'P_lookalike-animal');
        fprintf(fid, '%16s %23d %23f \n', naROI{r}, statistics{r}.h(1), statistics{r}.p(1));
        fprintf(fid, '\n%16s%24s%24s \n', '   ', 'H_lookalike-object', 'P_lookalike-object');
        fprintf(fid, '%16s %23d %23f \n', '   ', statistics{r}.h(2), statistics{r}.p(2));
    end
    
    fclose( fid ) ;
    
    cd(main_dir);
    fprintf('\n\n   The results are also saved in a text file.')
end

end