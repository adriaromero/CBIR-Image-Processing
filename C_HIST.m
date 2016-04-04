function [ hist ] = aapa_C_HIST( input_im )
%aapa_ACC_HIST Compute cumulative histogram of input image in matrix form
%   
%   [ hist ] = aapa_C_HIST( input_im )
%
%   Assuming the image is quantified in a 256-cell space, this function
%   computes the cumulative histogram of the input image, as defined in 
%   the MPEG-7 image descriptor standard.
% 
%   The histogram is computed using an 8x8 structuring element.
% 
%   The idea behind this implementation is to iterate through the pixels
%   inside every structuring element iteration, called "chunk". Then, to 
%   put a 1 in the auxiliary vector if each position's color is present 
%   in these 64 pixels. Then, after the iteration, to sum this aux vector 
%   to the total histogram. Finally, the histogram is normalized to the
%   [0,1] range.

% Initialize cumulative histogram vector
hist=zeros(256,1);

% Initialize auxiliary vector
aux=zeros(256,1);

% Compute size of input image
s=size(input_im);

% Iterate through all the image with the structuring element
% START LOOPS -> k-kolumns, l-lines; from 1 to size-(size(struct_elem)-1)
for k=1:(s(2)/8)
    for l=1:(s(1)/8)
        
% Obtain chunk's pixels
        chunk=input_im((1+(l-1)*8):(1+(l-1)*8)+7,(1+(k-1)*8):(1+(k-1)*8)+7);

% Loop through chunk's pixels
        for j=1:8
            for i=1:8
                
% Compute the 1's and 0's of the image chunk                
                if aux(1+chunk(i,j))==0
                    aux(1+chunk(i,j))=1;
                end
            end
        end

% Sum auxiliary vector to histogram
        hist=hist+aux;

% Reinitialize aux vector
        aux=zeros(256,1);

% END LOOPS
    end
end

%Normalize to the range [0, 1)
hist = hist/255;

end

