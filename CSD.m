function [ csd_coeffs ] = aapa_CSD( input_im )
%aapa_CSD Obtain Color Structure Descriptor coefficients of input image
%   
%   [ csd_coeffs ] = aapa_CSD( input_im )
%
%   This function is a function wrapper. It wraps the 2x
%   subsampling, the RGB->HMMD conversion, the 256-cell quantization, the 
%   cumulative histogram computation and its non-linear quantization.

% Read input image
in_image=imread(input_im);

% Downsample input image by a factor 2
d_im=imresize(in_image, 1/2, 'nearest');

% Transform input into HMMD color space
[HSD]=rgb2hmmd(d_im);

% Re-quantify into 256-cell space
[Q_im]=aapa_HMMD_IM_Q(HSD);

% Compute cumulative histogram
[ c_hist ] = aapa_C_HIST( Q_im );

%Nonlinear quantization of normalized histogram
[ csd_coeffs ] = arom_Hist_Quant( c_hist );

end

