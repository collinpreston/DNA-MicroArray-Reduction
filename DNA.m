clc; % Clear command window.
clearvars; % Get rid of variables from prior run of this m-file.
fprintf('Running BlobsDemo.m...\n'); % Message sent to command window.
workspace; % Make sure the workspace panel with all the variables is showing.
imtool close all;  % Close all imtool figures.


originalImage = imread('DNA.tif');
imshow(originalImage);

normalizedThresholdValue = 0.9; % In range 0 to 1.
thresholdValue = normalizedThresholdValue * max(max(originalImage)); % Gray Levels.
binaryImage = im2bw(originalImage, .01);    % One way to threshold to binary
imshow(binaryImage);

labeledImage = bwlabel(binaryImage, 4);     % Label each blob so we can make measurements of it
% Let's assign each blob a different color to visually show the user the distinct blobs.
imshow(labeledImage);

% Get the intensity of the current blob.
    %thisBlobMeanIntensity = blobMeasurements(k).MeanIntensity;
    cc = bwconncomp(binaryImage);
    stats = regionprops(cc, 'all'); 
    centroids = cat(1, stats.Centroid);
    [row, col] = size(centroids);
    SINGLE_MATRIX = {true};
    for i = 1 : row
        %areaMatr(i) = stats(i).Area; % gives area for each blob in your image
        fprintf('%i', stats(i).Area);
        if (stats(i).Area > 4)
            tempStats = stats;
            tempStats(i) = [];
            %tempStatsImages = [tempStats.Image];
            for k=1 : size(tempStats)
                booleanTestIsMember = isequal(stats(i).Image, tempStats(k).Image);
                if booleanTestIsMember
                    fprintf('Found a match!\n');
                    fprintf('Index %i, matches index', i);
                    fprintf('%i', booleanTestIsMember);
                end
            end
        end
    end
