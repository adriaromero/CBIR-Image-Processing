function [ output ] = rgb2hmmd( input )
%rgb2hmmd Convert RGB input image to HMMD color space.
% 
%   [ output ] = rgb2hmmd( input )
% 
%   Compute Hue, Sum and Diff values for the input pixel R,G,B values.
% 
%   Code by nathanj439. Covered by 
% 
%   Available at:
%   https://code.google.com/p/matlab-cbir/source/browse/trunk/rgb2hmmd.m?r=2
% 
%   Covered by the New BSD License.
%   (http://opensource.org/licenses/BSD-3-Clause)
% 
%   Copyright (c) 2008, nathanj439
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

[x, y, ~] = size(input);
output = zeros(size(input));

for i = 1:x
    for j = 1:y
        a = zeros([1 3]);
        a(:) = input(i, j, :);
        r = a(1); g = a(2); b = a(3);
        themax = max([r g b]);
        themin = min([r g b]);
        if (themax == themin)
            hue = 0;
        elseif (themax == r && g >= b)
            hue = 60 * (g -b ) / (themax - themin);
        elseif (themax == r && g < b)
            hue = 360 + 60 * (g - b) / (themax - themin);
        elseif (g == themax)
            hue = 60 * (2.0 + (b - r) / (themax - themin));
        else
            hue = 60 * (4.0 + (r - g) / (themax - themin));
        end
        
        diff = themax - themin;
        sum = (themax + themin) / 2;
        
        output(i, j, 1) = hue;
        output(i, j, 2) = diff;
        output(i, j, 3) = sum;
    end
end

end