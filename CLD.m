function [ cld_coeffs ] = aapa_CLD( input_im )
%aapa_CLD Compute the CLD coefficients of the input image
% 
%   [ cld_coeffs ] = aapa_CLD( input_im )
% 
%   This function is input an image, and outputs its CLD coefficients. To
%   do this, this function wraps the YUV conversion, DCT computation,
%   Zig-Zag scan and non-uniform quantization. After that, this function
%   takes the first 6 coefficients of each component.

% Preallocate DCT, zigzag and CLD coefficients
dct_coeffs=zeros(8,8,3);
zigzag=zeros(64,1,3);
cld_coeffs=zeros(6,1,3);

% Read image
in_rgb=imread(input_im);

% Convert image into YUV color space
in_yuv=rgb2ycbcr(in_rgb);

% Block partition & representative color selection
[ avg_im ] = aapa_CLD_part_avg( in_yuv );

% DCT computation
dct_coeffs(:,:,1)=dct2(avg_im(:,:,1));
dct_coeffs(:,:,2)=dct2(avg_im(:,:,2));
dct_coeffs(:,:,3)=dct2(avg_im(:,:,3));

% Zig-zag scanning
zigzag(:,:,1) = aapa_zigzag( dct_coeffs(:,:,1) );
zigzag(:,:,2) = aapa_zigzag( dct_coeffs(:,:,2) );
zigzag(:,:,3) = aapa_zigzag( dct_coeffs(:,:,3) );

% Non-uniform quantization
[ zig_quant ] = aapa_CLD_DCT_quant( zigzag );

% Take 18 coefficients, 6 per component (Y, Cb, Cr)
cld_coeffs(:,1,1)=zig_quant(1:6,1,1);
cld_coeffs(:,1,2)=zig_quant(1:6,1,2);
cld_coeffs(:,1,3)=zig_quant(1:6,1,3);

end