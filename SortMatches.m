function [ TopMatches ] = aapa_SortMatches( DistanceArray )
%SortImages Sorts the 10 best results of CompareImages and returns their filenames
% 
%   [ TopMatches ] = aapa_SortMatches( DistanceArray )

% Sort distances matrix by distances' column
[~,I]=sort(DistanceArray(:,1));
S=DistanceArray(I,:); % S is the sorted matrix

% Extract 10 best results' index names
Index=zeros(10,1); % Preallocate space to speed up performance
    for i = 1:10
        Index(i)=S(i,2);
    end

% Construct array of 10 best results' filenames
TopMatches=cell(10,1);

    for i=1:10
        TopMatches{i}=strcat('ukbench',sprintf('%05d',Index(i)),'.jpg');
    end
end

