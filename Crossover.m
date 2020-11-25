% 
%
% ---------------------------------------------------------
function [chromosome_1,chromosome_2] = Crossover(chromosome_1,chromosome_2)
    
    crossoverProbability = 0.8;
    choice = 'PMX';

    %% crossover prob 0.8 and random pick cross point
    if (rand < crossoverProbability)
        switch choice
            case 'CX2'
    %         % NEW CYCLE CROSSOVER(CX2) OPERATOR
    %         [chromosome_1,chromosome_2] = CrossoverCX2(chromosome_1,chromosome_2);
            case 'OB'
    %         % ORDER BASED CROSSOVER - 
    %         [chromosome_1,chromosome_2] = CrossoverOB(chromosome_1,chromosome_2);
            case 'CX'
    %         % CYCLE CROSSOVER (CX) -
    %         [chromosome_1,chromosome_2] = CrossoverCX(chromosome_1,chromosome_2);
            case 'PMX'
                % PARTIALLY MATCHED CROSSOVER (PMX)
                [chromosome_1,chromosome_2] = CrossoverPMX(chromosome_1,chromosome_2);
        end
    end