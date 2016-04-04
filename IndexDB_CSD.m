function aapa_IndexDB_CSD( Folder )
%aapa_IndexDB_CSD Index the Kentucky image database with the CSD descriptor.
% 
%   aapa_IndexDB_CSD( Folder )
% 
%   This function is one of the indexing modules of the Prog02 LAB of PIV.
%   This function reads the passed directory, and computes the CSD
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
    s=size(directory);
    % Preallocate csdIndex array
    DBIndex(256,(s(1)-2))=0;

    % Check if Parallel Computing Toolbox is installed. If it is, then the
    % database iterations are done in a parallel manner, significantly
    % improving the function's performance.
    %
    % In this indexing function, the parallel computation is nearly
    % essential, because it is a heavy function to compute, regarding
    % processing power.
    v = ver;
    if(any(strcmp('Parallel Computing Toolbox' , {v.Name})))
        
    % Iterate through directory, compute coefficients and add them to index
        parfor j=3:s(1);

    % Read image and compute CSD coefficients
            DBIndex(:,j-2)=aapa_CSD(directory(j,:));
            disp(j-2)
        end
    else
        for j=3:s(1);

    % Read image and compute CSD coefficients
            DBIndex(:,j-2)=aapa_CSD(directory(j,:));
            disp(j-2)
        end
    end
    
else
    directory=dir(Folder);
    s=size(directory);
    % Preallocate csdIndex array
    DBIndex(256,(s(1)-2))=0;

    v = ver;
    if(any(strcmp('Parallel Computing Toolbox' , {v.Name})))
    % Iterate through directory, compute coefficients and add them to index
        parfor j=3:s(1);

    % Read image and compute CSD coefficients
            DBIndex(:,j-2)=aapa_CSD(directory(j,:).name);
            disp(j-2)
        end
    else
        for j=3:s(1);

    % Read image and compute CSD coefficients
            DBIndex(:,j-2)=aapa_CSD(directory(j,:).name);
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

save('CSD_DBIndex.mat', 'DBIndex', 'List');
end

