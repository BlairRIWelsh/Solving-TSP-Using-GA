% 
%
% ---------------------------------------------------------
function [temp_chromosome_1,temp_chromosome_2] = Mutation(temp_chromosome_1,temp_chromosome_2, mutationProbability, mutationChoice)
%% https://arxiv.org/ftp/arxiv/papers/1203/1203.3099.pdf
    if (rand < mutationProbability)
        switch mutationChoice
            case 'twors'
                % TWORS Mutation
                temp_chromosome_1 = MutationTwors(temp_chromosome_1);
                temp_chromosome_2 = MutationTwors(temp_chromosome_2);
            case 'thrors'
                % Thrors mutation
                temp_chromosome_1 = MutationThrors(temp_chromosome_1);
                temp_chromosome_2 = MutationThrors(temp_chromosome_2);
            case 'rsm'
                % Reverse Sequence Mutation (RSM)
                temp_chromosome_1 = MutationRSM(temp_chromosome_1);
                temp_chromosome_2 = MutationRSM(temp_chromosome_2);
        end
    end
    
%% Swaps two genes in the given chromasome
function mutatedChromasome = MutationTwors(chromasome)
    [lb,ub] = generateCutPoints(size(chromasome,2));
    gene1 = chromasome(lb);
    gene2 = chromasome(ub);
    mutatedChromasome = chromasome;
    mutatedChromasome(lb) = gene2;
    mutatedChromasome(ub) = gene1;

%% Swap three genes in the given chromasome
function mutatedChromasome = MutationThrors(chromasome)
    % Generate 3 Unique Numbers between 1 and Chromasome Size(100)
    swapPoints = randi([1,size(chromasome,2)],1,3);
    while numel(swapPoints)~=numel(unique(swapPoints))
        swapPoints = randi([1,size(chromasome,2)],1,3);
    end
    
    % Get 3 genes
    gene1 = chromasome(swapPoints(1));
    gene2 = chromasome(swapPoints(2));
    gene3 = chromasome(swapPoints(3));
    
    % Swap 3 genes
    mutatedChromasome = chromasome;
    mutatedChromasome(swapPoints(1)) = gene3;
    mutatedChromasome(swapPoints(2)) = gene1;
    mutatedChromasome(swapPoints(3)) = gene2;

%% Reverse a randomly gemerated section in the given chromasome
function mutatedChromasome = MutationRSM(chromasome)
    [lb,ub] = generateCutPoints(size(chromasome,2));
    section = chromasome(1,lb:ub);
    flippedSection = flip(section);
    mutatedChromasome = chromasome;
    mutatedChromasome(1,lb:ub) = flippedSection;
    
%% Generates two random points from a chromosome guaranteed to be 1 apart from each other
function [lb,ub] = generateCutPoints(chromosome_size)
    lb = 0;
    ub = 0;
    % Generate 2 numbers between 1 and 100
    cutPoints = randi([1,chromosome_size],1,2);
    % Make biggest upper bound and lower lower bound
    if cutPoints(1) < cutPoints(2)
        lb = cutPoints(1);
        ub = cutPoints(2);
    else 
        lb = cutPoints(2);
        ub = cutPoints(1);
    end
    % If numbers are 1 digit away master chromasome be empty so just redo
    if ub-lb == 1 || ub == lb
        [lb,ub] = generateCutPoints(chromosome_size);
    end