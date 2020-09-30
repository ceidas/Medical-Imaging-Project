%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 2018 - Medical Imaging Project		     %
% MSc Biomedical Engineering - UPatras       %
% Elissaios Petrai                           %
% petrai AT ceid.upatras.gr                  %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function [e ] = ROI_function( ROI_P )

imshow(ROI_P);
e=imread(ROI_P);

%Coordinates for ROIs
Bone=[372.908477842004 215.40795909293 39.9836515443452 40.5987846450274];
pr_Bone=[317.663776493256 237.263005780347;391.652215799615 237.263005780347]; 
water=[330.488439306358 137.923955835993 38.3705433920235 38.1752734510973];  
pr_water=[349.232177263969 158.342003853565;281.162813102119 158.342003853565]; 
Background=[180.538535645472 259.821258831086 38.8045209860358 38.6055234425175];

%presenting ROIs on the original image
%and creating the profiles
ROI_K = imellipse(gca, Bone);
PROFILE1 = imline(gca, pr_Bone);
ROI_W = imellipse(gca, water);
PROFILE2 = imline(gca, pr_water);
ROI_Y=imellipse(gca, Background);
