%% Please set the paths before running the scripts.

function path = load_path(directory)

CoSMoMVPA = 'C:/Users/ASUS/Desktop/MATLAB/CoSMoMVPA-master';
GoogleDrive = 'C:\Users\ASUS\Desktop\Advanced Hands on fMRI Analysis [154122] - BRACCI\_FinalAssignment_OrhanSoyuhos\GoogleDrive\';
workingDir = 'C:\Users\ASUS\Desktop\Advanced Hands on fMRI Analysis [154122] - BRACCI\_FinalAssignment_OrhanSoyuhos\Moritz\';


if strcmp(directory, 'CoSMoMVPA')
    path = CoSMoMVPA;
elseif strcmp(directory, 'subs_fMRI')
    path = [GoogleDrive 'data\'];
elseif strcmp(directory, 'ROIs')
    path = [GoogleDrive 'ROIs\'];
    
elseif strcmp(directory, 'results_OVO_multiclass')
    path = [workingDir 'filesSaved\results_OVO_multiclass\'];
elseif strcmp(directory, 'figures')
    path = [workingDir 'figures\'];
elseif strcmp(directory, 'workingDir')
    path = workingDir;
    
end