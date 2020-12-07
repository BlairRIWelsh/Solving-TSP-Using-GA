% 
%
% ---------------------------------------------------------
function [temp_chromosome_1,temp_chromosome_2] = Selection(population,choice)
    chromasome_size = size(population,2) - 1; 
    population_size = size(population,1);
    
    
    switch choice
        case 'roulette'
            %% ROULETTE SELCTION - selects the Chromosomes based on a probability proportional to the fitness
            temp_chromosome_1 = RouletteSelection(population);
            temp_chromosome_2 = RouletteSelection(population);
        case 'tournament'
            %% TOURNAMENT SELECTION -
            % ???
    end

    
