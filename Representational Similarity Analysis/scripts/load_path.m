%% Please set the paths before running the scripts.

function path = load_path(directory)

CoSMoMVPA = 'C:/Users/ASUS/Desktop/MATLAB/CoSMoMVPA-master';
GoogleDrive = 'C:\Users\ASUS\Desktop\Advanced Hands on fMRI Analysis [154122] - BRACCI\_FinalAssignment_OrhanSoyuhos\GoogleDrive\';
workingDir = 'C:\Users\ASUS\Desktop\Advanced Hands on fMRI Analysis [154122] - BRACCI\_FinalAssignment_OrhanSoyuhos\Bracci\';


if strcmp(directory, 'CoSMoMVPA')
    path = CoSMoMVPA;
elseif strcmp(directory, 'subs_fMRI')
    path = [GoogleDrive 'data\'];
elseif strcmp(directory, 'ROIs')
    path = [GoogleDrive 'ROIs\'];

elseif strcmp(directory, 'subs_DS')
    path = [workingDir 'filesSaved\subs_DS\'];
elseif strcmp(directory, 'models_raw')
    path = [workingDir 'filesSaved\models\'];
elseif strcmp(directory, 'lower_models_vect')
    path = [workingDir 'filesSaved\models\lower_models_vect\'];
elseif strcmp(directory, 'subs_RDMs')
    path = [workingDir 'filesSaved\RDMs\'];
elseif strcmp(directory, 'figures')
    path = [workingDir 'figures\'];
elseif strcmp(directory, 'RSA_fisher_parcorr')
    path = [workingDir 'filesSaved\RSA_fisher_parcorr\'];
elseif strcmp(directory, 'RSA_statistics')
    path = [workingDir 'filesSaved\RSA_statistics\'];
elseif strcmp(directory, 'workingDir')
    path = workingDir;
end
    
end