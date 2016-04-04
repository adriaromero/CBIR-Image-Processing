function [ Q_im ] = aapa_HMMD_IM_Q( input )
%aapa_HMMD_IM_Q Re-quantify the input image non-uniformly in the 256-cell HMMD space 
%
%   [ Q_im ] = aapa_HMMD_IM_Q( input )
%   
%   This function reads the input image, transforms it into the HMMD color
%   space and re-quantifies is in a 256-cell space to be used later as the
%   input of an accumulative histogram.
%
%   The image can be represented with imread as a grey level image, but
%   needs to be normalized to 1 and converted into uint8.

% Read input image
im_size=size(input);

% Preallocate quantified image matrix
Q_im=zeros(im_size(1), im_size(2));

% Iterate through input image pixels and quantify them one by one
for j=1:im_size(2)
    for i=1:im_size(1)
        Q_im(i,j)=aapa_HMMD_Q(input(i,j,1), input(i,j,2), input(i,j,3));
    end
end

% Convert to uint8 if desired
% The image needs to be normalized in order to be converted
% Q_im8=im2uint8(Q_im/255); 

end

