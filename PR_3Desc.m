% This script has been prepared to compute all result values from the 4
% available descriptors and display the Precision-Recall values easily.

% Compute Precision and Recall values for the four descriptors
[ TopMatchesH, PrecisionH, RecallH ] = aapa_CBIR_PrecRec_FILE( 'input.txt','outputH.txt', 'Hist');
[ TopMatchesY, PrecisionY, RecallY ] = aapa_CBIR_PrecRec_FILE( 'input.txt','outputY.txt', 'YUV');
[ TopMatchesS, PrecisionS, RecallS ] = aapa_CBIR_PrecRec_FILE( 'input.txt','outputS.txt', 'CSD');
[ TopMatchesL, PrecisionL, RecallL ] = aapa_CBIR_PrecRec_FILE( 'input.txt','outputL.txt', 'CLD');

% Plot Precision and Recall results 
plot(RecallH, PrecisionH,'-ok', RecallY, PrecisionY,'-og', RecallS, PrecisionS,'-or', RecallL, PrecisionL,'-ob')
legend('Black-> BW Histogram', 'Green -> YUV Histogram', 'Red -> CSD', 'Blue-> CLD')

% Compute F function values for all four descriptors
F_Hist=max(2*(PrecisionH./RecallH)/(PrecisionH+RecallH))
F_YUV =max(2*(PrecisionY./RecallY)/(PrecisionY+RecallY))
F_CSD =max(2*(PrecisionS./RecallS)/(PrecisionS+RecallS))
F_CLD =max(2*(PrecisionL./RecallL)/(PrecisionL+RecallL))