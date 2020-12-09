% Generates a random population of size [population_size x chromasome_size]
% ---------------------------------------------------------
function population = GenerateRandomPopulation(population_size,chromasome_size)
    population = zeros(population_size,chromasome_size);
    i = 1;
    while (i<population_size+1)
        % Generate 1,100 Matrix with random permutation of numbers 1-100
        temp_chromosome = randperm(chromasome_size);
        % Add chromasome to population if it does not already exist
        if ~ismember(temp_chromosome, population,'rows')
            population(i,:) = temp_chromosome;
            i = i + 1;
        end
    end