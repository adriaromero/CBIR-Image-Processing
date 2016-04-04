function [ DistanceArray ] = aapa_CompareImages( QueryImage, Descriptor)
%aapa_CompareImages Loads two images and compares them
%   
%   [ DistanceArray ] = aapa_CompareImages( QueryImage, Descriptor)
%   
%   This function is the comparing module of the Prog02 LAB of PIV.
%   This function loads the passed image and according to the input descriptor,
%   turns it into BW or YUV and compares its  histogram, or computes CSD
%   or CLD coefficients, with the ones from the ProgLAB index. Then, it 
%   computes the distance between the image and all of the ones in the 
%   database, and returns the distances values, so the sorting module can 
%   return the most similar images.
% 
%   Descriptor can be:
%   
%   - "Hist" for image histogram
%   - "YUV"  for image YUV histogram
%   - "CSD"  for Color Structure Descriptor
%   - "CLD"  for Color Layout Descriptor

if strcmp(Descriptor,'Hist')
    % Read input image and compute its histogram
    hIn=imhist(rgb2gray(imread(QueryImage)));

    % Load histogram index
    load('Hist_DBIndex.mat','DBIndex');

    % Preallocate Distances array
    DistanceArray=zeros(2000,2);
    
    % Compute norm2 distances with the index's images.
    for j=1:length(DBIndex);
            DistanceArray(j,1)=norm(hIn-DBIndex(:,j));
            DistanceArray(j,2)=(j-1);
    end
    
elseif  strcmp(Descriptor,'YUV')
    
    % Read input image, convert it to YUV and compute each component's
    % histogram
    iRGB=imread(QueryImage);
    i=rgb2ycbcr(iRGB);
    hIn(:,1)=imhist(i(:,:,1));
    hIn(:,2)=imhist(i(:,:,2));
    hIn(:,3)=imhist(i(:,:,3));

    % Load histogram index
    load('YUV_DBIndex.mat','DBIndex');

    % Compute distances with the index's images. In this case, the
    % distances are computed by using the "norm" function on each
    % component, and then, summing these "partial" distances.
    AuxDistanceArray=zeros(2000,2,3);
    DistanceArray=zeros(2000,2);

        for j=1:length(DBIndex);
            AuxDistanceArray(j,1,1)=norm(hIn(:,1)-DBIndex(:,j,1));
            AuxDistanceArray(j,2,1)=(j-1);

            AuxDistanceArray(j,1,2)=norm(hIn(:,2)-DBIndex(:,j,2));
            AuxDistanceArray(j,2,2)=(j-1);

            AuxDistanceArray(j,1,3)=norm(hIn(:,3)-DBIndex(:,j,3));
            AuxDistanceArray(j,2,3)=(j-1);

            DistanceArray(j,1)=AuxDistanceArray(j,1,2)+AuxDistanceArray(j,1,3)+AuxDistanceArray(j,1,1);
            DistanceArray(j,2)=(j-1);

        end
    
elseif  strcmp(Descriptor,'CSD')
    % Read input image and compute its CSD coefficients
    [ c_hist ] = aapa_CSD( QueryImage );

    % Load histogram index
    load('CSD_DBIndex.mat','DBIndex');

    % Compute distances with the index's images.
    DistanceArray=zeros(2000,2);

    for j=1:length(DBIndex);
        DistanceArray(j,1)=norm(c_hist-DBIndex(:,j));
        DistanceArray(j,2)=(j-1);

    end
    
elseif strcmp(Descriptor,'CLD')
    % Read input image and compute its CLD coefficients
    [ cld_coeffs ] = aapa_CLD( QueryImage );

    % Load database index
    load('CLD_DBIndex.mat','DBIndex');

    % Compute distances with the index's images.
    AuxDistanceArray=zeros(2000,2,3);
    DistanceArray=zeros(2000,2);

    % CLD weighting values
    w1=0.05;
    w2=0.9;
    w3=0.9;

        for j=1:length(DBIndex);
    %       Y Component
            AuxDistanceArray(j,1,1)=norm(sqrt(w1)'.*(cld_coeffs(:,:,1)-DBIndex(:,j,1)));
            AuxDistanceArray(j,2,1)=(j-1);

    %       Cb Component
            AuxDistanceArray(j,1,2)=norm(sqrt(w2)'.*(cld_coeffs(:,:,2)-DBIndex(:,j,2)));
            AuxDistanceArray(j,2,2)=(j-1);

    %       Cr Component
            AuxDistanceArray(j,1,3)=norm(sqrt(w3)'.*(cld_coeffs(:,:,3)-DBIndex(:,j,3)));
            AuxDistanceArray(j,2,3)=(j-1);

            DistanceArray(j,1)=AuxDistanceArray(j,1,2)+AuxDistanceArray(j,1,3)+AuxDistanceArray(j,1,1);
            DistanceArray(j,2)=(j-1);

        end
    
end

end