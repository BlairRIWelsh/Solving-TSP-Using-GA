% 
%
% ---------------------------------------------------------
function [child_chromosome_1,child_chromosome_2] = CrossoverPMX(chromosome_1,chromosome_2)

chromosome_size = size(chromosome_1,2);

% Select two numbers between 1 and chromasome size which will be the two cut points
[lowerBound,upperBound] = generateCutPoints(chromosome_size);

%% HARDCODING
% n=100;
% chromosome_1 = (1:n);
% chromosome_2 = ((1:n)-100)*(-1);
% lowerBound = 10;
% upperBound = 15;

%% Split the two chromosomes into 3 parts each based on the cuttoff points
chromasome1Part1 = chromosome_1(1:lowerBound);
chromasome1Part2 = chromosome_1(lowerBound+1:upperBound);
chromasome1Part3 = chromosome_1(upperBound+1:chromosome_size);

chromasome2Part1 = chromosome_2(1:lowerBound);
chromasome2Part2 = chromosome_2(lowerBound+1:upperBound);
chromasome2Part3 = chromosome_2(upperBound+1:chromosome_size);

% Set up temporary chromosomes with just the portion between the cut points and the rest 0s
temp_chromasome_1 = [zeros(1,lowerBound) chromasome2Part2 zeros(1,chromosome_size-upperBound)];
temp_chromasome_2 = [zeros(1,lowerBound) chromasome1Part2 zeros(1,chromosome_size-upperBound)];

% Set up mappings
mappings = [chromasome1Part2; chromasome2Part2];

% Crossover using PMX
child_chromosome_1 = crossoverParts(temp_chromasome_1,chromasome1Part1,chromasome1Part3,mappings);
child_chromosome_2 = crossoverParts(temp_chromasome_2,chromasome2Part1,chromasome2Part3,mappings);

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
        [lb,ub] = generateCutPoints();
    end

function masterChromosome = crossoverParts(masterChromosome,chromosomePart1,chromosomePart3,mappings)

    val = 0; % val will increase to be the upper bound after part = 1 so we can access the 3rd part of masterChromosome
    chromosomePart = chromosomePart1;
    
    for parts = 1: 2
        for i=1:size(chromosomePart,2) % for every item in this part
%             disp("");
%             disp(chromosomePart(i));
%             disp(masterChromosome);
%             disp("");
            if ~ismember(chromosomePart(i),masterChromosome) % if it isn't a member of masterChromosome add it to it
                masterChromosome(i+val) = chromosomePart(i);
            else % if it is a memebr of MC
                num = chromosomePart(i);
                mapfound = false; % varibale to break out of loop quickly when map found
                % Loop through mapping to find that values mapped value
                for j=1 : 2 % for the two rows of mapping
                    k = 1; % have to set k=1 and use a while loop here because matlab doesnt let you change loop counter within a for loop
                    while (k <= size(mappings,2)) % for every item in mapping
                        if num == mappings(j,k) % if the number is found in mapping
                                if ~ismember(mappings((j-3)*(-1),k),masterChromosome) % check its opposite / mapped number isn't in MC
                                    masterChromosome(i+val) = mappings((j-3)*(-1),k); % if it isn't, add it to MC, then break out to the next item in part
                                    mapfound = true;
                                    break;
                                else % if that opposite / mapped number is in MC, we have to search for THAT values mapping
                                    num = mappings((j-3)*-1,k); % so THAT value become the new num
                                    k = 0; % and we set k = 0 (which in line 84 will be k=1) so we can look at all the mappings again to find it
                                    % notice how we dont change j. If j = 1, the opposite mapping will be found on j = 2. That mappings mapping will always be found on j =1, so no need to change j
                                end
                        end
                        k = k + 1; % increment k for while loop
                    end
                    if mapfound == true % quick break if mapping is found
                        break
                    end
                end
            end
        end
        val = size(masterChromosome,2) - size(chromosomePart3,2); % once part 1 is done, value becomes upper bound to add part3 to MC
        chromosomePart = chromosomePart3; % and the part in quesiton becomes part3 obviously.
    end
