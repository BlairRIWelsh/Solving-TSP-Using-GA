% Offers differnt types of replacement strategies to make sure the best
% chromsomes are not lost
% ---------------------------------------------------------
function [newPopulation,population_new_num] = Replacement(population,replacementChoice,replacementSize)
    chromasome_size = size(population,2) - 1; 
    population_size = size(population,1);
    
    population = sortrows(population,chromasome_size+1);
    newPopulation = zeros(population_size,chromasome_size);
    
    switch replacementChoice
        case 'elitism'
            % ELITISM - Select best n parents to survive into new population
            newPopulation(1:replacementSize,:) = population(population_size-(replacementSize-1):population_size,1:chromasome_size);
            population_new_num = replacementSize;
        case 'generational'
            % GENERATIONAL - All old population members are removed
            population_new_num = 0;
        case 'random'
            % RANDOM REPLACEMENT - "children replace two randomly chosen individuals in the population."
            for i=1:replacementSize 
                x = randi(size(population,1)); % Genrate a random number between 1 and population size
                newPopulation(i,:) = population(x,1:chromasome_size);
            end
            population_new_num = replacementSize;
    end
    
    
    
    
    
    
    