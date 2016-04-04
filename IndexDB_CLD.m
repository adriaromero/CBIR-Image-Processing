function aapa_IndexDB_CLD( Folder )
%aapa_IndexDB_CLD Index the Kentucky image database with the CLD descriptor.
% 
%   aapa_IndexDB_CLD( Folder )
% 
%   This function is one of the indexing modules of the Prog02 LAB of PIV.
%   This function reads the passed directory, and computes the CLD
%   coefficients of all images found in it and saves them in a file so the
%   comparing module can load it.

% The "ispc" function is called to ensure OS independence. This is
% required because the result of the "ls" function is different depending
% if we are using a Windows OS or a Mac/Linux OS.
% 
% In case we are in a Unix-based OS, the "dir" function must be used 
% instead of "ls" 

if ispc
    % Read directory files
    directory=ls(Folder);

    % Preallocate histIndex array
    DBIndex(6,(length(directory)-2),3)=0;

    
    % Check if Parallel Computing Toolbox is installed
    v = ver;
    if(any(strcmp('Parallel Computing Toolbox' , {v.Name})))
        % Iterate through directory, compute histograms and add them to index
        parfor j=3:length(directory);
            DBIndex(:,j-2,:) = aapa_CLD(directory(j,:));
            disp(j-2)
        end
    else
        % Iterate through directory, compute histograms and add them to index
        for j=3:length(directory);
            DBIndex(:,j-2,:) = aapa_CLD(directory(j,:));
            disp(j-2)
        end
    end
    
else
    % Read directory files
    directory=dir(Folder);

    % Preallocate histIndex array
    DBIndex(6,(length(directory)-2),3)=0;
    
    v = ver;
    if(any(strcmp('Parallel Computing Toolbox' , {v.Name})))
    % Iterate through directory, compute histograms and add them to index
        parfor j=3:length(directory);
            DBIndex(:,j-2,:) = aapa_CLD(directory(j,:).name);
            disp(j-2)
        end
    else
        for j=3:length(directory);
            DBIndex(:,j-2,:) = aapa_CLD(directory(j,:).name);
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

save('CLD_DBIndex.mat', 'DBIndex', 'List');
end

