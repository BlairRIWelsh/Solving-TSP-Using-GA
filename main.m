% example of TSP problem
% solved using genetic algorithm 

clear all;
load('xy.mat');
chromasome_size = size(xy,1);

iter = 10;% Number of iterations: repeat "iter" times 
population_size = 20; % Number of chromosomes in population

%% Find distances between points IS THIS NEEDED OR CAN I JUST COMPUTE THIS IN FITNESS FUNCTION
distances_between_points = zeros(chromasome_size,chromasome_size);
for i=1:size(xy,1)
    for j = i + 1:size(xy,1)
        distance = sqrt((xy(i,2)-xy(i,1))^2 + (xy(j,2)-xy(j,1))^2);
        distances_between_points(j,i) = distance;
        %distances_between_points(i,j) = distance;
    end
end

%% Generates a random population using Permutation Encoding
population = GenerateRandomPopulation(population_size,chromasome_size);

% %% Do this for however many generations is specified by 'iter'
% for k = 1:iter

    % Get the fitness scores of the current population
    population = FitnessFunction(population, distances_between_points);
   
    % Keep some members of the old generation in the new one
    % Default is Elitism Replacement with 2 Chromosomes
    [populationNew, populationNewNum] = Replacement(population);

    %% For every other space left in the new population, fill it with new child chromasomes
%     while (populationNewNum < population_size)
            
        % Select two parents from the old population
        % Default is Roulette Selection
        [parent_chromosome_1,parent_chromosome_2] = Selection(population);
        
        [child_chromosome_1,child_chromosome_2] = Crossover(parent_chromosome_1,parent_chromosome_2);
        
        [chromosome_1,chromosome_2] = Mutation(chromosome_1,chromosome_2);
%         
%         
%         
%         
%         
%       
%         %% Add chromosomes to new population
%           population_new_num = population_new_num + 1;
%           population_new(population_new_num,:) = temp_chromosome_1;
%           population_new_num = population_new_num + 1;
%           population_new(population_new_num,:) = temp_chromosome_2;
%         
%     end
    
%     %% New population becomes the old population
% %     population(:,1:16) = population_new;
% end