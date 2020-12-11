% Offers differnt types of strategies to crossover two parent chromasomes
% to produce to child chromasomes
% ---------------------------------------------------------
function [child1,child2] = Crossover(chromosome_1,chromosome_2,crossoverProbability,crossoverChoice)
    % Methods taken from: https://www.hindawi.com/journals/cin/2017/7430125/
    
    child1 = zeros(1,size(chromosome_1,2));
    child2 = zeros(1,size(chromosome_2,2));
 
    if (rand < crossoverProbability)
        switch crossoverChoice
            case 'cx2'
                % NEW CYCLE CROSSOVER(CX2) OPERATOR
                [child1,child2] = CrossoverCX2(chromosome_1,chromosome_2);
            case 'ox'
                % ORDER BASED CROSSOVER - 
                [child1,child2] = CrossoverOX(chromosome_1,chromosome_2);
            case 'pmx'
                % PARTIALLY MATCHED CROSSOVER (PMX)
                [child1,child2] = CrossoverPMX(chromosome_1,chromosome_2);
        end
    else
        child1 = chromosome_1;
        child2 = chromosome_2;
    end
    
    
function [child1,child2] = CrossoverCX2(parent1,parent2)
    
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
    
function [child1,child2] = CrossoverOX(parent1,parent2)
    [lb,ub] = generateCutPoints(size(parent1,2));
   
    t = parent1;
    s = parent2;
    
    for loop=1:2
        child1 = zeros(size(t));
        child1(1,lb:ub) = t(1,lb:ub);
        for k=1:lb-1
            for i=1:size(s,2)
                if ~ismember(s(i),child1)
                    child1(k) = s(i);
                    break;
                end
            end
        end

        for k=ub+1:size(parent1,2)
            for i=1:size(s,2)
                if ~ismember(s(i),child1)
                    child1(k) = s(i);
                    break;
                end
            end
        end
        if loop ==1
            child2 = child1;
            
            temp = t;
            t = s;
            s =temp;
        end
    end
    
    
function [child1,child2] = CrossoverPMX(parent1,parent2)
    cutPoint = randi([1,size(parent1,2)]);
   
    s = parent1;
    t= parent2;
    
    for k=1:2 
        for i=1:cutPoint
            numToSwap = s(i);
            numToInsert = t(i);

            idx = find(s==numToInsert); %search for numToInsert in s
            s(idx) = numToSwap; % set it equal to numToSwap

            s(i) = numToInsert;
        end
        if k == 1 % First time round set child1 to s and swap s and t
            child1 = s;
            s = parent2;
            t = parent1;
        else 
            child2= s; % Second time round set child2 to s
        end
    end

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
    if ub-lb == 1
        [lb,ub] = generateCutPoints(chromosome_size);
    end