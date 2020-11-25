% 
%
% ---------------------------------------------------------
function population = FitnessFunction(population,distances_between_points)
    chromasome_size = size(population,2);
    population_size = size(population,1);
    
    % always have an extra column at the end for fitness score
    population = [population zeros(population_size,1)];
    
    for i = 1:population_size
        total_distance = 0;
        % Add distance from point j to point j+1 to total distance 
        % for points 1 to the second last point
        for j = 1:chromasome_size-1
            total_distance = total_distance + distances_between_points(population(i,j), population(i,j+1));
        end
        % add distance from last point back to point 1
        total_distance = total_distance + distances_between_points(population(i,end -1),population(i,1));
        % Add 1 / distance as fitness score 
        % As we are looking for the shortest path not the largest
        population(i,end) = 1 / total_distance;
    end