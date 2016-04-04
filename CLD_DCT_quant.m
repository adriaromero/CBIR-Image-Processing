function [ zig_quant ] = aapa_CLD_DCT_quant( zigzag )
%aapa_CLD_DCT_quant Perform non-uniform quantization to zigzag-scanned DCT
%vector.
% 
%   [ zig_quant ] = aapa_CLD_DCT_quant( zigzag )
% 
%   This function performs a non-uniform quantization to the input vector.
%   This quantization is specified in the MPEG-7 standard as a uniform
%   quantization of 6 bits on the DC coefficients (first value of DCT) and
%   a 5 bit uniform one on the rest of the coefficients.
% 
%   In order to do this, first, the DCT vector must be normalized to [0,1].
%   Because of this vector not being uniform in value range, the
%   normalization is performed in two stages. The first one forces a 0 at
%   the minimum by substracting the minimum value of each component from
%   themselves. The second stage forces a 1 at the maximum by dividing each
%   component by its maximum value.
% 
%   Once normalized to [0,1], each component is quantized by use of the
%   ROUND function.
% 
%   The resulting quantized matrix's range is also [0,1], but with discrete
%   jumps between possible values.

% Force 0 at the minimum
cld_norm(:,:,1)=zigzag(:,:,1)-min(zigzag(:,:,1));
cld_norm(:,:,2)=zigzag(:,:,2)-min(zigzag(:,:,2));
cld_norm(:,:,3)=zigzag(:,:,3)-min(zigzag(:,:,3));

% Force 1 at the maximum
cld_norm(:,:,1)=cld_norm(:,:,1)/max(cld_norm(:,:,1));
cld_norm(:,:,2)=cld_norm(:,:,2)/max(cld_norm(:,:,2));
cld_norm(:,:,3)=cld_norm(:,:,3)/max(cld_norm(:,:,3));

% Preallocate quantized matrix
zig_quant=zeros(64,1,3);

% Quantized values computation
zig_quant(1,1,1)=round((64)*cld_norm(1,1,1));
zig_quant(2:64,1,1)=round((32)*cld_norm(2:64,1,1));

zig_quant(1,1,2)=round((64)*cld_norm(1,1,2));
zig_quant(2:64,1,2)=round((32)*cld_norm(2:64,1,2));

zig_quant(1,1,3)=round((64)*cld_norm(1,1,3));
zig_quant(2:64,1,3)=round((32)*cld_norm(2:64,1,3));

end

