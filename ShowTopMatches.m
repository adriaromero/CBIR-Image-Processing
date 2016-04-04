function [ ] = aapa_ShowTopMatches( QueryImage, TopMatches )
%ShowBestImages Shows the top 10 results of the Content-Based Image Retrieval 
% 
%   [ ] = aapa_ShowTopMatches( QueryImage, TopMatches )
% 
%   This function is input the query image and the top 10 images' cell
%   array. Then it constructs a 3x5 subplot with the query and the top
%   results. These images are plot with their filenames to help evaluate
%   the correctness of the matching.

subplot(3,5,1), imshow(QueryImage), title(QueryImage)

    for i=1:10
        subplot(3,5,i+5),imshow(TopMatches{i}), title(TopMatches{i})
    end

end