% 
%
% ---------------------------------------------------------
function [chromosome_1,chromosome_2] = Crossover(chromosome_1,chromosome_2,crossoverProbability,crossoverChoice)
    %% crossover prob 0.8 and random pick cross point
    % https://www.hindawi.com/journals/cin/2017/7430125/
    if (rand < crossoverProbability)
        switch crossoverChoice
            case 'cx2'
    %         % NEW CYCLE CROSSOVER(CX2) OPERATOR
                [chromosome_1,chromosome_2] = CrossoverCX2(chromosome_1,chromosome_2);
            case 'ox'
    %         % ORDER BASED CROSSOVER - 
    %         [chromosome_1,chromosome_2] = CrossoverOB(chromosome_1,chromosome_2);
            case 'pmx'
                % PARTIALLY MATCHED CROSSOVER (PMX)
                [chromosome_1,chromosome_2] = CrossoverPMX(chromosome_1,chromosome_2);
        end
    end
    
    
function [child1,child2] = CrossoverCX2(parent1,parent2)
    
%%% HARDCODING
%     parent1 = [3,4,8,2,7,1,6,5];
%     parent2 = [4,2,5,1,6,8,3,7];
%     parent1 = [1,2,3,4,5,6,7,8];
%     parent2 = [2,7,5,8,4,1,6,3];
    
    chromasome_size = size(parent1,2);
    child1 = zeros(1,chromasome_size);
    child2 = zeros(1,chromasome_size);
    
    numberToAddToChild2 = parent1(1); % Start off with parent2's first digit
    
    i = 1;
    while i <= chromasome_size
        
        position = find(numberToAddToChild2==parent1);  % Find digits position in parent1
        numberToAddToChild1 = parent2(position);        % Find the number at that position in parent2   
        if ~ismember(numberToAddToChild1, child1)       
            child1(i) = numberToAddToChild1;            % Add it to child1
        else
            for k=1:chromasome_size                     % If we have done a cycle, find the first unused gene
                tempc = parent2(k);                     % in parent2 and add that instead, restarting the algorithim
                if ~ismember(tempc,child1)
                    numberToAddToChild1 = parent2(k);
                    child1(i) = numberToAddToChild1;
                    break;
                end
            end
        end
        
        position2 = find(numberToAddToChild1==parent1); % Find digits position in parent1
        tempDigit = parent2(position2);                 % Find the number at that position in parent2
        position3 = find(tempDigit==parent1);           % Find digits position in parent1
        numberToAddToChild2 = parent2(position3);       % Find the number at that position in parent2
        child2(i) = numberToAddToChild2;                % add it to child2
        
        i = i + 1; % increment
    end