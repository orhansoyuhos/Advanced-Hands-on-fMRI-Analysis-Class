%% Advanced Hands on fMRI Analysis
%% End-to-end script for the Final (Bracci's part)
clear;
close all;

% select your path for CoSMoMVPA-master 
addpath(genpath(load_path('CoSMoMVPA'))); 

%% PART 1:
% Generate the two alternative models.

% H1) The object space in VTC reflects object visual appearance (e.g., lookalike objects cluster
% together with animals for their visual appearance regardless of animacy properties);
generate_models('lookalike-animal', load_path('models_raw'), load_path('figures'), 1);

% H2) The object space in VTC reflect object animacy properties (e.g., lookalike objects cluster
% together with inanimate objects for their common (non)animate properties).
generate_models('lookalike-object', load_path('models_raw'), load_path('figures'), 1);

%% PART 2:
% Generate COSMO DS structure
save_subsDS(load_path('subs_fMRI'), load_path('ROIs'), load_path('subs_DS'));

% Save RDMs of each subject in a file and separately
save_RDMs(load_path('subs_DS'), load_path('subs_RDMs'));

% Save the lower part of the models as vectors
save_lowerModelsVect(load_path('models_raw'), load_path('lower_models_vect'));

%% PART 3:
% Compute RSA between models and fMRI data
compute_RSA(load_path('lower_models_vect'), load_path('subs_RDMs'), load_path('RSA_fisher_parcorr'), load_path('RSA_statistics'));

%% PART 4:
% Visualize the results for all three ROIs; Report tables with final results and statistics
visualize_results(load_path('subs_RDMs'), load_path('lower_models_vect'), load_path('RSA_fisher_parcorr'), ...
                    load_path('RSA_statistics'), load_path('figures'));
                
%% PART 4:
% Statistical results;
print_statistics(load_path('RSA_statistics'), true, load_path('workingDir'));
