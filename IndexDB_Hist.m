function aapa_IndexDB_Hist( Folder )
%aapa_IndexDB_Hist Index the Kentucky image database
% 
%   aapa_IndexDB_Hist( Folder )
% 
%   This function is the indexing core of the Prog0 LAB of PIV.
%   This function reads the passed directory, and computes the BW
%   histograms of all images found in it and saves them in a file so the
%   comparing core can load it.

% The "isunix" function is called to ensure OS independence. This is
% required because the result of the "ls" function is different depending
% if we are using a Windows OS or a Mac/Linux OS.
% 
% In case we are in a Unix-based OS, the "dir" function must be used 
% instead of "ls" 
if isunix
    % Read directory files
    directory=dir(Folder);

    % Preallocate histIndex array
    DBIndex(256,(length(directory)-2))=0;
    
    % Check if Parallel Computing Toolbox is installed. If it is, then the
    % database iterations are done in a parallel manner, significantly
    % improving the function's performance.
    v = ver;
    if(any(strcmp('Parallel Computing Toolbox' , {v.Name})))
        
    % Iterate through directory, compute histograms and add them to index
        parfor j=3:length(directory);
            DBIndex(:,j-2)=imhist(rgb2gray(imread(directory(j,:).name)));
            disp(j-2)
        end
    else
        for j=3:length(directory);
            DBIndex(:,j-2)=imhist(rgb2gray(imread(directory(j,:).name)));
            disp(j-2)
        end
    end
else
   % Read directory files
    directory=ls(Folder);

    % Preallocate histIndex array
    DBIndex(256,(length(directory)-2))=0;

    v = ver;
    if(any(strcmp('Parallel Computing Toolbox' , {v.Name})))
    % Iterate through directory, compute histograms and add them to index
        parfor j=3:length(directory);
            DBIndex(:,j-2)=imhist(rgb2gray(imread(directory(j,:))));
            disp(j-2)
        end 
    else
        for j=3:length(directory);
            DBIndex(:,j-2)=imhist(rgb2gray(imread(directory(j,:))));
            disp(j-2)
        end 
    end
end

% Compute List values for Precision and Recall computation.
List=zeros(500,4);

List(1,2)=1;
List(1,3)=2;
List(1,4)=3;

for i=1:500
    List(i,1)=(List(1,1))+((i-1)*4);
    List(i,2)=(List(1,2))+((i-1)*4);
    List(i,3)=List(1,3)+(i-1)*4;
    List(i,4)=List(1,4)+(i-1)*4;
end
    
save('Hist_DBIndex.mat', 'DBIndex', 'List');
end

