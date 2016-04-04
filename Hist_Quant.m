function [ csd_coeffs ] = arom_Hist_Quant( norm_hist )
% Hist_Quant Quantifies nonlinearly a normalized histogram of a 
% 256-cell space.
%   
%   [ csd_coeffs ] = arom_Hist_Quant( norm_hist )
%
%   This function applies the 256-cell non-uniform quantification
%   of a normalized histogram with a range of [0,1].

% Preallocate coefficients vector
csd_coeffs = zeros(length(norm_hist),1);

for j = 1:length( norm_hist )
    %Interval of norm_hist divided into six regions
    
    %Region 0
    if (0<=norm_hist(j))&&(norm_hist(j)<1e-9)
        %Quantify region into 1 level
        csd_coeffs(j) = round(j);
        
    %Region 1
    elseif (1e-9<=norm_hist(j))&&(norm_hist(j)<37e-3)
        %Quantify region into 25 levels
        csd_coeffs(j) = round(25*j)/25;
        
    %Region 2
    elseif (37e-3<=norm_hist(j))&&(norm_hist(j)<8e-2)
        %Quantify region into 20 levels
        csd_coeffs(j) = round(20*j)/20;
        
    %Region 3
    elseif (8e-2<=norm_hist(j))&&(norm_hist(j)<195e-3)
        %Quantify region into 35 levels
        csd_coeffs(j) = round(35*j)/35;
    
    %Region 4
    elseif (195e-3<=norm_hist(j))&&(norm_hist(j)<32e-2)
        %Quantify region into 35 levels
        csd_coeffs(j) = round(35*j)/35;
    
    %Region 5
    elseif (32e-2<=norm_hist(j))&&(norm_hist(j)<1)
        %Quantify region into 140 levels
        csd_coeffs(j) = round(140*j)/140;
        
    end 
end

