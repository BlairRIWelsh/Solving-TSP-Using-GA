% Takes in a population and calculates each chromosomes fitness score
% adding it as the last collumn and returning it
% ---------------------------------------------------------
function population = FitnessFunction(population,xy)
    chromasome_size = size(population,2);
    population_size = size(population,1);
    
    % Add extra column at the end for fitness score
    population = [population zeros(population_size,1)];
    
    for i = 1:population_size % For every chromasome
        
        total_distance = 0; % Reset Distance every chromasome
        
        % for points 1 to the second last point, add distance from point j to point j+1 to total distance 
        for j = 1:chromasome_size-1
            
            currentPointNumber = population(i,j);
            currentPointX = xy(currentPointNumber,1);
            currentPointY = xy(currentPointNumber,2);
            nextPointNumber = population(i,j+1);
            nextPointX = xy(nextPointNumber,1);
            nextPointY = xy(nextPointNumber,2);
            
            distanceBetweenPoints = sqrt((currentPointX-nextPointX)^2 + (currentPointY-nextPointY)^2);
            total_distance = total_distance + distanceBetweenPoints;
            
        end
        
        % Add distance from last point back to point 1
        currentPointNumber = population(i,chromasome_size);
        currentPointX = xy(currentPointNumber,1);
        currentPointY = xy(currentPointNumber,2);
        nextPointNumber = population(i,1);
        nextPointX = xy(nextPointNumber,1);
        nextPointY = xy(nextPointNumber,2);
        
        distanceBetweenPoints = sqrt((currentPointX-nextPointX)^2 + (currentPointY-nextPointY)^2);
        total_distance = total_distance + distanceBetweenPoints;
            
        % Add 1 / distance as fitness score As we are looking for the shortest path not the largest
        population(i,end) = 1 / total_distance;
    
    end