function [ avg_color ] = aapa_CLD_avg( chunk )
%aapa_CLD_avg Compute average color of input image chunk
% 
%   [ avg_color ] = aapa_CLD_avg( chunk )
% 
%   This function finds the dominant color value of the input image matrix 
%   by averaging its color values, as specified in the MPEG-7 paper.   

% Preallocate averaged pixel
avg_color=zeros(1,1,3);

% Compute average value of each color component
avg_color(1)=round(mean2(chunk(:,:,1)));
avg_color(2)=round(mean2(chunk(:,:,2)));
avg_color(3)=round(mean2(chunk(:,:,3)));

end