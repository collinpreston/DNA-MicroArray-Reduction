clc; % Clear command window.
clearvars; % Get rid of variables from prior run of this m-file.
fprintf('Running BlobsDemo.m...\n'); % Message sent to command window.
workspace; % Make sure the workspace panel with all the variables is showing.
imtool close all;  % Close all imtool figures.

% Read in the original image.
originalImage = imread('DNA.tif');

% Just display the original image.  This is just for debuging.
imshow(originalImage);

% This is a variable which can be used for setting the threshold.
% + Right now it's not being used.  
normalizedThresholdValue = 0.9; % In range 0 to 1.
thresholdValue = normalizedThresholdValue * max(max(originalImage)); % Gray Levels.

% As you can see, I've hardcoded the threshold value. (bad but I was
% hacking away).
binaryImage = im2bw(originalImage, .01);    % One way to threshold to binary
% Now we will display the binary image.  This is an image of any pixel which
% had an original value above the threshold value.  Now all those values above
% the threshold value are being set to 1 (pure white).
imshow(binaryImage);

% Now we will label the image.  This will allow us to identify each blob.
labeledImage = bwlabel(binaryImage, 4);     % Label each blob so we can make measurements
imshow(labeledImage);

% Get the intensity of the current blob.
%thisBlobMeanIntensity = blobMeasurements(k).MeanIntensity;

% I'm not completely familiar with the next two lines.  However, they are
% similar in function to bwlabel I think.  Eitherway, we use these two
% lines to get all of the information about the blobs in the binary image.
% Note that we are no longer using the labeledImage from bwlabel.
cc = bwconncomp(binaryImage);
% TODO: Later, we should change the second argument to not be 'all' and
% instead just specify the fields that we absolutely need.  This will
% hopefully speed up our program.
stats = regionprops(cc, 'all');

% We don't use this line but it might be helpful in the future.
centroids = cat(1, stats.Centroid);
% This matrix contains a row for each blob in the image.
[row, col] = size(centroids);

% We don't use this variable.
SINGLE_MATRIX = {true};

% Now we will loop through each blob in the image.
for i = 1 : row
    %areaMatr(i) = stats(i).Area; % gives area for each blob in your image
    fprintf('%i', stats(i).Area);
    % Right now I'm only interested in blobs with an area larger than 4
    % pixels.  Anything smaller does not reduce much data since we still
    % need to determine how much data needs to be saved in order to
    % reproduce the image in the end.  I'm guessing this number will grow.
    % Also, the 4 should not be hard coded like this but instead should be
    % a static variable.
    if (stats(i).Area > 4)
        % I'm creating a copy of the struct of stats.
        tempStats = stats;
        % Now I'll remove the current blob from the temp struct since we
        % don't want to compare the current blob in the stats struct with
        % the same exact blob in the temp struct.
        tempStats(i) = [];
        %tempStatsImages = [tempStats.Image];
        
        % And now we will loop through every blob in the temp struct.
        for k=1 : size(tempStats)
            % We are looking to find a blob in the temp struct which
            % matches the blob we are focused on in the stats struct.
            booleanTestIsMember = isequal(stats(i).Image, tempStats(k).Image);
            
            % If we find a match, we should be recording information about
            % each struct.  This is where I need your help in tesing to
            % make sure we are correctly identifying matching structs and
            % how we will save off those pieces of redundant data.
            if booleanTestIsMember
                fprintf('Found a match!\n');
                fprintf('Index %i, matches index', i);
                fprintf('%i', booleanTestIsMember);
            end
        end
    end
end
