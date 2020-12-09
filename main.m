%% INFORMATION
% Name: Blair Welsh
% Student ID: 34740627
% Example of TSP problem solved using genetic algorithm 

%% Load in data points

clear all;
load('xy.mat');
tic;
chromasome_size = size(xy,1);

%% Display Graphs?
displayShortestRoutePlot = true;

%% Parameter Selection
iter = 1000;                                        % Number of iterations: repeat "iter" times 
population_size = 100;                              % Number of chromosomes in population
replacementChoice = "elitism";                      % CHOICES: 'elitism', 'generational', 'random'
replacementSize = 2;                                % Number of members of last generation to keep using elitism or random replacment
selectionChoice = 'tournamentWithReplacement';      % CHOICES: 'roulette', 'tournamentWithoutReplacement', 'tournamentWithReplacement'
tournamentSelectionSize = 4;                        % Size of tournament when using tournament selection
crossoverChoice = 'pmx';                            % CHOICES: 'pmx', 'cx2', 'ox'
crossoverProbability = 0.8;                         % Chance of selected parents crossing over
mutationChoice = "rsm";                             % CHOICES: 'twors', 'thrors', 'rsm'
mutationProbability = 0.2;                          % Chance of new child chromosomes mutating

%% Generates a random population using Permutation Encoding
population = GenerateRandomPopulation(population_size,chromasome_size);

%% Do this for however many generations is specified by 'iter'
for k = 1:iter

    % Get the fitness scores of the current population
    population = FitnessFunction(population, xy);
    
    % Keep some members of the old generation in the new one
    [populationNew, populationNewNum] = Replacement(population,replacementChoice,replacementSize);

    %% For every other space left in the new population, fill it with new child chromasomes
    while (populationNewNum < population_size)
            
        % Select two parents from the old population
        [parent_chromosome_1,parent_chromosome_2] = Selection(population,selectionChoice,tournamentSelectionSize);
        
        % Crossover them to form 2 new child chromosomes
        [child_chromosome_1,child_chromosome_2] = Crossover(parent_chromosome_1,parent_chromosome_2,crossoverProbability,crossoverChoice);
        
        % Mutate those two children
        [child_chromosome_1,child_chromosome_2] = Mutation(child_chromosome_1,child_chromosome_2,mutationProbability,mutationChoice);
        
        % Check child 1 does not already exist in populaion and does not contain 0
        if ((~ismember(child_chromosome_1, populationNew,'rows')) && (~ismember(0,child_chromosome_1)))
            % Add child 1 to population
            populationNewNum = populationNewNum + 1;
            populationNew(populationNewNum,:) = child_chromosome_1;
        end
        % Check child 2 does not already exist in population, does not contain 0 and that population is not full
        if ((~ismember(child_chromosome_2, populationNew,'rows')) && (populationNewNum < population_size) && (~ismember(0,child_chromosome_1)))
            % Add child 2 to population
            populationNewNum = populationNewNum + 1;
            populationNew(populationNewNum,:) = child_chromosome_2;
        end

    end
    
    population = populationNew;                     % New population becomes the old population
    population = population(:,1:chromasome_size);   % Drop fitness score collumn
    
end

%% Find the shortest route of the Final Generation
% Get the fitness scores of the last population
population = FitnessFunction(population, xy);

% Find the shortest route and distance it took
[shortestRouteFitnessScore,shortestRouteIndex] = max(population(:,chromasome_size+1)); % biggest fitness score / lowest distance in last population
shortestRouteDistance = 1/shortestRouteFitnessScore;
shortestRoute = population(shortestRouteIndex,1:chromasome_size);

%% Display plot of the Shortest Route
if (displayShortestRoutePlot == true)
    f2 = figure('Name','TSP_GA | Results','Numbertitle','off');
    figure(f2);
    subplot(2,2,1);
    pclr = ~get(0,'DefaultAxesColor');
    plot(xy(:,1),xy(:,2),'.','Color',pclr);
    title('City Locations');
    subplot(2,2,2);
    rte = shortestRoute([1:100 1]);
    plot(xy(rte,1),xy(rte,2),'r.-');
    title(sprintf('Total Distance = %1.4f',shortestRouteDistance));
end

%% Print information about the last run
fprintf('\n*** RUN COMPLETE ***\n');
fprintf('Population Size: %d \nIterations: %d\n',population_size,iter);
if strcmp(selectionChoice,'tournamentWithoutReplacement') || strcmp(selectionChoice,'tournamentWithReplacement')
    fprintf('Replacement: "%s" with %d Chromosomes\n',replacementChoice,replacementSize);
else
    fprintf('Replacement: "%s"\n',replacementChoice);
end
if strcmp(selectionChoice,'tournamentWithoutReplacement') || strcmp(selectionChoice,'tournamentWithReplacement')
    fprintf('Selection: "%s" with Tournament Size: %d\n',selectionChoice,tournamentSelectionSize);
else
    fprintf('Selection: "%s"\n',selectionChoice);
end
fprintf('Crossover: "%s" at %d%% probabilty\n',crossoverChoice, crossoverProbability*100);
fprintf('Mutation: "%s" at %d%% probabilty\n\n',mutationChoice, mutationProbability*100);
toc;
fprintf('Shortest Route Distance last Generation: %f\n\n',shortestRouteDistance);
