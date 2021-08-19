%% Advanced Hands on fMRI Analysis
%% End-to-end script for the Final (Moritz's part)
clear;
close all;

% select your path for CoSMoMVPA-master 
addpath(genpath(load_path('CoSMoMVPA'))); 

%% PART 1:
% Use a multiclass decoding approach to test whether the pattern of activity for the lookalike
% objects generalises to their corresponding animals;

multiclass_decoding('lookalike-animal', load_path('subs_fMRI'), load_path('ROIs'), load_path('results_OVO_multiclass'));

%% PART 2:
% Use a multiclass decoding approach to test whether the pattern of activity for the lookalike
% objects generalises to their corresponding objects;

multiclass_decoding('lookalike-object', load_path('subs_fMRI'), load_path('ROIs'), load_path('results_OVO_multiclass'));

% Bonus:
multiclass_decoding('animal-object', load_path('subs_fMRI'), load_path('ROIs'), load_path('results_OVO_multiclass'));

%% PART 3:
% Visualize the results for all three ROIs;

figure;
visualize_results('lookalike-animal', load_path('results_OVO_multiclass'), load_path('figures'));
figure;
visualize_results('lookalike-object', load_path('results_OVO_multiclass'), load_path('figures'));

% Bonus:
figure;
visualize_results('animal-object', load_path('results_OVO_multiclass'), load_path('figures'));

%% PART 4:
% Statistical analysis for all three ROIs;
% one-tailed one sample t test

test_significance(0.05, 'lookalike-animal', load_path('results_OVO_multiclass'), true, load_path('workingDir'))
test_significance(0.001, 'lookalike-object', load_path('results_OVO_multiclass'), true, load_path('workingDir'))

% Bonus:
test_significance(0.001, 'animal-object', load_path('results_OVO_multiclass'), false, load_path('workingDir'))
