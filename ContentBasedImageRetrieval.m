function [ TopMatches ] = aapa_ContentBasedImageRetrieval( QueryImage, Descriptor )
%aapa_ContentBasedImageRetrieval Retrieves the top 10 matches of the queried
%image from the indexed database
% 
%   [ TopMatches ] = aapa_ContentBasedImageRetrieval( QueryImage, Descriptor )
% 
%   This function is input the query image and the desired descriptor to use.
%   It returns the list of the top matches and a subplot of the
%   query and matches.
% 
%   It is made by calling the different modules of the CBIR system

[ DistanceArray ] = aapa_CompareImages( QueryImage, Descriptor );

[ TopMatches ] = aapa_SortMatches( DistanceArray );

aapa_ShowTopMatches( QueryImage, TopMatches );

end