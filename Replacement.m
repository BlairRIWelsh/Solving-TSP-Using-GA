% 
%
% ---------------------------------------------------------
function [newPopulation,population_new_num] = Replacement(population,replacementChoice)
    chromasome_size = size(population,2) - 1; 
    population_size = size(population,1);
    
    population = sortrows(population,chromasome_size+1);
    newPopulation = zeros(population_size,chromasome_size);
    
    switch replacementChoice
        case 'elitism'
            % ELITISM - Select best n parents to survive into new population
            numberOfParentsToKeep = 2;
            newPopulation(1:numberOfParentsToKeep,:) = population(population_size-1:population_size,1:chromasome_size);
            population_new_num = numberOfParentsToKeep;
        case 'generational'
            % GENERATIONAL - All old population members are removed
            % population_new_num = 0;
        case 'random'
            % RANDOM REPLACEMENT - "children replace two randomly chosen individuals in the population."
            % ???
    end
    
    
    
    
    
    
    