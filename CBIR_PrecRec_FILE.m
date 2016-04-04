function [ TopMatches, PrecisionM, RecallM ] = aapa_CBIR_PrecRec_FILE( QueryFile,OutputFile, Descriptor)
%aapa_CBIR_PrecRec_FILE This function computes the Precision and Recall of 
%the result of the CBIR system from a query .txt file. It also writes the
%resulting images into the Output .txt file.
% 
%   [ TopMatches, PrecisionM, RecallM ] = aapa_CBIR_PrecRec_FILE( QueryFile,OutputFile, Descriptor)
% 
%   This function just runs the function ContentBasedImageRetrieval and
%   PreRec and outputs the Precision and Recall values and the top values
%   for the 1st 20 images of the Query .txt file.
% 
%   Descriptor can be:
%   
%   - "Hist" for image histogram
%   - "YUV"  for YUV image histogram
%   - "CSD"  for Color Structure Descriptor
%   - "CLD"  for Color Layout Descriptor

if (strcmp(Descriptor,'Hist') || strcmp(Descriptor,'YUV') || strcmp(Descriptor,'CSD') || strcmp(Descriptor,'CLD'))
%   Allocate Precision and Recall matrixes
%   The allocation is made so that Precision and Recall values for each
%   picture are assigned in rows. This way, when averaging the values,
%   MATLAB has to iterate them by columns, resulting in a faster code.
    Precision=zeros(20,10);
    Recall=zeros(20,10);
    
%   Open input file and read its contents. Then, close it.
    fileID=fopen(QueryFile);
    C=textscan(fileID,'%s');
    fclose(fileID);

%   Open output file
    fileID2=fopen(OutputFile,'w');

%   Iterate through the first 20 elements of the input file and compute top
%   ten matches and Precision-Recall values.
        for i=1:20


            QueryImage=C{1}{i};

            [ TopMatches ] = aapa_ContentBasedImageRetrieval_NoShow( QueryImage, Descriptor);
            
%   This If-Else structure allows to compute the resulting values using
%   whichever descriptor we want from the available ones.
            if strcmp(Descriptor,'Hist')
                [ Precision(i,:), Recall(i,:) ] = aapa_PreRec( QueryImage, TopMatches, 'Hist_DBIndex.mat' );
            elseif strcmp(Descriptor,'YUV')
                [ Precision(i,:), Recall(i,:) ] = aapa_PreRec( QueryImage, TopMatches, 'YUV_DBIndex.mat' );
            elseif strcmp(Descriptor,'CSD')
                [ Precision(i,:), Recall(i,:) ] = aapa_PreRec( QueryImage, TopMatches, 'CSD_DBIndex.mat' );
            elseif strcmp(Descriptor,'CLD')
                [ Precision(i,:), Recall(i,:) ] = aapa_PreRec( QueryImage, TopMatches, 'CLD_DBIndex.mat' );
            end
            
%   Write results in output file
            formatSpec = 'Retrieved list for query image %1$s\n';
            fprintf(fileID2,formatSpec,QueryImage);

            for j=1:10

                TM=TopMatches{j};
                formatSpec2 = '%1$s\n';
                fprintf(fileID2,formatSpec2,TM);

            end


        end
        
%   Compute Precision and Recall average values
        PrecisionM=mean(Precision);
        RecallM=mean(Recall);

%   Close output file
        fclose(fileID2);
else
    
%   In case the user inputs a descriptor that is not available, display
%   this message.
    disp('Error: descriptor not found. Only Hist, YUV, CSD and CLD are available.')
end

end