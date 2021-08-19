function generate_models(pair, models_path, figures_path, disp)

%% Generate the two alternative models 

%% Setting path
mkdir(models_path)

%% Part-1
% H1) The object space in VTC reflects object visual appearance (e.g., lookalike objects cluster
% together with animals for their visual appearance regardless of animacy properties);

if strcmp(pair, 'lookalike-animal')
    
    model = ones(27,27);
    model(1:18, 1:18) = zeros(18,18);
    model(19:27, 19:27) = zeros(9,9);
    
    for i = 1:size(model,1)
        model(i, i) = 0;
    end
    
    if disp == 1
        % Setting path
        mkdir(figures_path)
        
        figure;
        imagesc(model)
        title([pair ' model']);

        colorbar('Ticks',[0,1], 'TickLabels', {'Sim (0)','Dissim (1)'});
        
        saveas(gcf, fullfile([figures_path, pair, '.png'])); 
    end
    
    save([models_path pair], 'model');
    
%% Part-2
% H2) The object space in VTC reflect object animacy properties (e.g., lookalike objects cluster
% together with inanimate objects for their common (non)animate properties).

elseif strcmp(pair, 'lookalike-object')
    
    model = ones(27,27);
    model(1:9, 1:9) = zeros(9,9);
    model(1:9, 19:27) = zeros(9,9);
    model(10:18, 10:18) = zeros(9,9);
    model(19:27, 1:9) = zeros(9,9);
    model(19:27, 19:27) = zeros(9,9);
    
    for i = 1:size(model,1)
        model(i, i) = 0;
    end
    
    if disp == 1
        % Setting path
        mkdir(figures_path)
        
        figure;
        imagesc(model)
        title([pair ' model']);
        
        colorbar('Ticks',[0,1], 'TickLabels', {'Sim (0)','Dissim (1)'});
        
        saveas(gcf, fullfile([figures_path, pair, '.png']));
    end
    
    save([models_path pair], 'model');
    
end

end
