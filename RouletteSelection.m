% 
%
% ---------------------------------------------------------
function temp_chromosome = RouletteSelection(population)
    chromasome_size = size(population,2) - 1; 

    %% Calculate the wieghts of each chromasome surviving and breeding
    weights= population(:,chromasome_size+1)/sum(population(:,chromasome_size+1));
    accumulation = cumsum(weights);

    % Pick a chromosome based on a probability proportional to the fitness
    p = rand();
    chosen_index = -1;
    for index = 1 : length(accumulation)
        if (accumulation(index) > p)
          chosen_index = index;
          break;
        end
    end
    choice = chosen_index;
    
    % Return chosen chromosome
    temp_chromosome = population(choice, 1:chromasome_size);