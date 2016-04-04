function [ zigzag ] = aapa_zigzag( input_im )
%aapa_zigzag Zig-zag scan of 2D matrix into 1D vector
%
%   [ zigzag ] = aapa_zigzag( input_im )
%
%   Scan in zig-zag motion a 2D matrix, starting at (1,1), then (1,2), then
%   (2,1), and so on.
% 
%   Code by Ketul Shah and Sagar Shah, from Nirma University.
%   
%   Available at: 
%   https://www.mathworks.com/matlabcentral/fileexchange/46029-zigzag-scanning-of-a-matrix
% 
%   Covered by the BSD License.  
% 
%   Copyright (c) 2014, Ketul Shah
%   All rights reserved.
% 
%   Redistribution and use in source and binary forms, with or without
%   modification, are permitted provided that the following conditions are
%   met:
% 
%       * Redistributions of source code must retain the above copyright
%         notice, this list of conditions and the following disclaimer.
%       * Redistributions in binary form must reproduce the above copyright
%         notice, this list of conditions and the following disclaimer in
%         the documentation and/or other materials provided with the distribution
%   
%   THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS"
%   AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
%   IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE
%   ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT OWNER OR CONTRIBUTORS BE
%   LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR
%   CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF
%   SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS
%   INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN
%   CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE)
%   ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE
%   POSSIBILITY OF SUCH DAMAGE.


t=0;
l=size(input_im);
sum=l(2)*l(1);  %calculating the M*N

zigzag=zeros(sum,1); % Preallocate result vector to speed up code

for d=2:sum
 c=rem(d,2);  %checking whether even or odd
    for i=1:l(1)
        for j=1:l(2)
            if((i+j)==d)
                t=t+1;
                if(c==0)
                zigzag(t)=input_im(j,d-j);
                else          
                zigzag(t)=input_im(d-j,j);
                end
             end    
         end
     end
end

end