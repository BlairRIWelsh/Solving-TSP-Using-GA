% 
%
% ---------------------------------------------------------
function population = GenerateRandomPopulation(population_size,chromasome_size)
    population = zeros(population_size,chromasome_size);
    for i = 1:population_size
        % Generate 1,100 Matrix with random permutation of numbers 1-100
        temp_chromosome = randperm(chromasome_size);
        % Add chromasome to population if it does not already exist
        if ~ismember(temp_chromosome, population,'rows')
            population(i,:) = temp_chromosome;
        else
            i = i -1;
        end
    end