function [training, test] = splitDataSets(data, holdoutPer)
% Splitting the table <data> into training and test set, holding out <holdoutPer>
% Expecting the class labels in the field "class" of data

    rng(1)
    
    splitData = cvpartition(data.class, 'Holdout', holdoutPer);
    
    % use this split to divvy up the data
    training = data(splitData.training, :);
    test = data(splitData.test, :);

end