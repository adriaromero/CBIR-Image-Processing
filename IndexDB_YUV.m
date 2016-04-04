function aapa_IndexDB_YUV( Folder )
%aapa_IndexDB_YUV Index the Kentucky image database with the YUV descriptor.
% 
%   aapa_IndexDB_YUV( Folder )
% 
%   This function reads the passed directory, and computes the YUV
%   histograms of all images found in it and saves them in a file so the
%   comparing module can load it.

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
    DBIndex(256,(length(directory)-2),3)=0;

    % Iterate through directory, compute histograms and add them to index
    for j=3:length(directory);
%       Read RGB image
        iRGB=imread(directory(j,:).name);
%       Convert to YUV
        i=rgb2ycbcr(iRGB);
        
        DBIndex(:,j-2,1)=imhist(i(:,:,1));
        DBIndex(:,j-2,2)=imhist(i(:,:,2));
        DBIndex(:,j-2,3)=imhist(i(:,:,3));
        
        disp(j-2)
    end
    
else
    % Read directory files
    directory=ls(Folder);

    % Preallocate histIndex array
    DBIndex(256,(length(directory)-2),3)=0;

    % Iterate through directory, compute histograms and add them to index
        for j=3:length(directory);
    %         Read RGB image
            iRGB=imread(directory(j,:));
    %         Convert to YUV
            i=rgb2ycbcr(iRGB);
            DBIndex(:,j-2,1)=imhist(i(:,:,1));
            DBIndex(:,j-2,2)=imhist(i(:,:,2));
            DBIndex(:,j-2,3)=imhist(i(:,:,3));
            disp(j-2)
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

save('YUV_DBIndex.mat', 'DBIndex', 'List');
end

