function [ cell ] = aapa_HMMD_Q( hue, diff, sum )
% HMMD_Q Quantifies an HMMD pixel in a 256-cell space.
%   
%   [ cell ] = aapa_HMMD_Q( hue, diff, sum )
%
%   This function applies the HMMD 256-cell non-uniform quantification
%   specified in the MPEG-7 Image Descriptors standard, to be used to 
%   extract Color Structure Descriptor coefficients.

    if (diff>=0 && diff<6)
        cell=fix(sum/8);
    elseif (diff>=6 && diff<20)
        cell=32+8*(fix(hue/90))+fix(sum/32);
    elseif (diff>=20 && diff<60)
        cell=64+4*(fix(hue/22.5))+fix(sum/64);
    elseif (diff>=60 && diff<110)
        cell=128+4*(fix(hue/22.5))+fix(sum/64);
    elseif (diff>=110 && diff<256)
        cell=192+4*(fix(hue/22.5))+fix(sum/64);
    end

end