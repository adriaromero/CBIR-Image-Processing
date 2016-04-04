function [ avg_im ] = aapa_CLD_part_avg( input_im )
%aapa_CLD_part_avg Partition image and compute block's average color value
%   
%   [ avg_im ] = aapa_CLD_part_avg( input_im )
% 
%   This function does the first part of the CLD coefficient computation.
%   It partitions the input image in 64 (8x8) blocks and then averages the
%   pixel values of each of them to find the dominant color value.

% Preallocate averaged image
avg_im=zeros(8,8,3);

% Compute input image size
s=size(input_im);

% Loop on picture pixels, take 80x60 chunks and average its colors
for k=1:(s(2)/80)
    for l=1:(s(1)/60)
        
% Obtain chunk's pixels
        chunk=input_im(((1+(l-1)*60):(1+(l-1)*60)+7),((1+(k-1)*80):(1+(k-1)*80)+7),:);
        
% Perform color averaging
        avg_im(l,k,:)=aapa_CLD_avg(chunk);

    end
end

end