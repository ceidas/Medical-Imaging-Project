%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 2018 - Medical Imaging Project		     %
% MSc Biomedical Engineering - UPatras       %
% Elissaios Petrai                           %
% petrai AT ceid.upatras.gr                  %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% In this way we found the coordinates of ROIs
% imshow('test4.tif')
% h1=imellipse;
% h2=imellipse;
% h3=imellipse;
% h4=imline;
% h5=imline;

function [SNR_Background, SNR_Bone, SNR_PWater, CNR_Bone, CNR_PWater] = CreateRois(eik)
    eikona = imshow(eik);
    e1 = eik;
    e2 = eik;
    e3 = eik;

    %Coordinates for ROIs
    Bone = [372.908477842004 215.40795909293 39.9836515443452 40.5987846450274];
    pr_Bone = [317.663776493256 237.263005780347; 391.652215799615 237.263005780347];
    water = [330.488439306358 137.923955835993 38.3705433920235 38.1752734510973];
    pr_water = [349.232177263969 158.342003853565; 281.162813102119 158.342003853565];
    ypovathro = [180.538535645472 259.821258831086 38.8045209860358 38.6055234425175];

    %% Presenting ROIs on the original image
    %and creating the profiles
    ROI_K = imellipse(gca, Bone);
    PROFILE1 = imline(gca, pr_Bone);
    ROI_W = imellipse(gca, water);
    PROFILE2 = imline(gca, pr_water);
    ROI_Y = imellipse(gca, ypovathro);

    %%Creating mask on the original image for each ROI
    mask_Background = createMask(ROI_Y, eikona);
    mask_Bone = createMask(ROI_K, eikona);
    mask_PWater = createMask(ROI_W, eikona);

    %% Calculating SNR only for pixels in ROIS
    e1(~mask_Background) = nan;
    SNR_Background = (mean2(e1(mask_Background))) / (std2(e1(mask_Background)));
    fprintf('SNR_Background=%f\n', SNR_Background);

    e2(~mask_Bone) = nan;
    SNR_Bone = (mean2(e2(mask_Bone))) / (std2(e1(mask_Background)));
    fprintf('SNR_Bone=%f\n', SNR_Bone);

    e3(~mask_PWater) = nan;
    SNR_PWater = (mean2(e3(mask_PWater))) / (std2(e1(mask_Background)));
    fprintf('SNR_PWater=%f\n', SNR_PWater);

    %Calculating CNR
    CNR_Bone = abs(SNR_Bone - SNR_Background);
    fprintf('CNR_Bone=%f\n', CNR_Bone);

    CNR_PWater = abs(SNR_PWater - SNR_Background);
    fprintf('CNR_PWater=%f\n\n', CNR_PWater);
