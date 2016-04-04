function [ Precision, Recall, PRIndex ] = aapa_PreRec( QueryImage, TopMatches, DBIndex )
%PreRec Computes the Precision and Recall of a given TopMatches group and a
%QueryImage
% 
%   [ Precision, Recall, PRIndex ] = aapa_PreRec( QueryImage, TopMatches, DBIndex )
%   
%   This function is passed a QueryImage and the TopMatches that CBIR gave
%   as a result. Using these two variables and an index List which is 
%   loaded from DBIndex.mat, this function computes the Precision and 
%   Recall values for the QueryImage.
% 
%   The computation is done by checking whether every TopMatch belongs to 
%   the 4 image group QueryImage belongs to. If it does, then an index
%   is incremented by 1, if not, the index remains the same. This results
%   in a count of how may images of the QueryImage group are present in
%   TopMatches. Then, dividing by 10 or 4, we can easily get Precision and
%   Recall values.

% Load List
load(DBIndex,'List');

% Preallocate PRIndex, Precision and Recall vectors
PRIndex=0;
Precision=zeros(10,1);
Recall=zeros(10,1);

% Extract index from query image and matches' names
QIndex=str2double(QueryImage(8:12));

% Convert TopMatches' cells to string array and extract indexes
MIndex=zeros(10,1);
for i=1:length(TopMatches)
    aux=TopMatches{i};
    MIndex(i)=str2double(aux(8:12));
end

% Compute the position matrix from which we get which row and column the
% query image is
PosIndex=List-QIndex;
[QRow,~]=find(PosIndex==0,1);

% Iterate over List to see whether or not every TopMatch index belongs to
% the 4 image group the QueryImage belongs to

p=1; % Counting variable for Precision computation

for i=1:length(MIndex)
    for Col=1:4
        if(MIndex(i)==List(QRow,Col))
            PRIndex = PRIndex + 1;
            
        end
       
    end
     
    Precision(p)=PRIndex/p;
    Recall(p)=PRIndex/4;
            
    p=p+1;
    
end