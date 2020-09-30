%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 2018 - Medical Imaging Project		     %
% MSc Biomedical Engineering - UPatras       %
% Elissaios Petrai                           %
% petrai AT ceid.upatras.gr                  %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

clear all
close all;

%% Task 1: projection of the initial image
f1 = figure('NumberTitle', 'off', 'name', 'Original Image: test4.tif');
OriginalImage = imshow('test4.tif');
title(sprintf('test4.tif'))

x = input('***Task 1 completed**\n***Press << Enter >> to continue***');
close(f1);

%% Task 2: Projection of ROIs and Profiles
f2 = figure('NumberTitle', 'off', 'name', 'ROIs and Profiles');
[e] = ROI_function('test4.tif')
title(sprintf('ROIs and Profiles'))
ESF_LSF(e, 1, 1, 1)

x = input('***Task 2 completed****\n***Press << Enter >> to continue***');
close all;

%% Task 3 and 4: Projection of sine chart, ESF, LSF and of reconstructed image for hanning filter and combination of parameters
P1 = imread('test4.tif');
P = mat2gray(P1)

R = 380; %% R > = image size / 2
filter = 'Hann'; % Filter: 'Ram-Lak', 'Shepp-Logan', 'Cosine', 'Hamming', 'Hann‘
filter_cutoff = 0.95; %% cut-off frequency: 95%
FanCoverage1 = 'cycle'; %'minimal', 'cycle', no difference exists
FanSensorGeometry1 = 'arc'; % 'arc' and 'line'
method_inter = 'cubic'; % Interpolation: 'nearest', 'linear', 'cubic', 'spline'
Dr = [0.8 0.5 0.2]; %Δr

%for all combination of values: Δr=0.8,0.5,0.2 and Δθ=1,2,3
for counter = 1:3

    if counter == 1 %Δr=0.8
        X = {'Reconstruction for Δr=0.8 - Δθ=3', 'Reconstruction for Δr=0.8 - Δθ=2', 'Reconstruction for Δr=0.8 - Δθ=1'}
    elseif counter == 2
        X = {'Reconstruction for Δr=0.5 - Δθ=3', 'Reconstruction for Δr=0.5 - Δθ=2', 'Reconstruction for Δr=0.5 - Δθ=1'}
    elseif counter == 3
        X = {'Reconstruction for Δr=0.2 - Δθ=3', 'Reconstruction for Δr=0.2 - Δθ=2', 'Reconstruction for Δr=0.2 - Δθ=1'}
    end

    Ds = [3 2 1]%Δθ

    for j = 1:length(X)

        %estimation of fan-beam projection
        FanSensorSpacing1 = Dr(counter); % Sensor spacing (which means distance between sensors) (Δr): 0.8 , 0.5 , 0.2
        FanRotationIncrement3 = Ds(j); % Rotation Increment values (Δθ):3,2,1 (in other words 120, 180 and 360 projections)
        [F3, sensor_pos3, fan_rot_angle3] = fanbeam(P, R, 'FanRotationIncrement', FanRotationIncrement3, 'FanSensorGeometry', FanSensorGeometry1, 'FanSensorSpacing', FanSensorSpacing1);
        %Projection of data projection (ie sinogram)
        f3 = figure('NumberTitle', 'off', 'name', 'Sinogram');
        imagesc(fan_rot_angle3, sensor_pos3, F3)
        colormap(hot); colorbar
        xlabel('Fan Rotation Angle (degrees)')
        ylabel('Fan Sensor Position (degrees)')
        title(sprintf('Hanning 95 - Δr=%.2f and Δθ=%.2f', Dr(counter), Ds(j)))
        % Projection of reconstructed image
        output_size = max(size(P));
        a3 = figure('NumberTitle', 'off', 'name', X{j});
        Ifan3 = ifanbeam(F3, R, 'FanRotationIncrement', FanRotationIncrement3, 'FanSensorGeometry', FanSensorGeometry1, 'FanSensorSpacing', FanSensorSpacing1, 'Filter', filter, 'FrequencyScaling', filter_cutoff, 'Interpolation', method_inter, 'OutputSize', output_size);
        [a, b, c, d, e] = CreateRois(Ifan3);
        title(sprintf('Hanning filter, cut-off 95'))

        figure('NumberTitle','off','name', X{j}), imshow(Ifan3) %remove this comment if only you want to call the ESF_LSF.m function
        title( sprintf('Hanning filter, cutoff 95')) %remove this comment if only you want to call the ESF_LSF.m function

        %Calculation and projection of ESF and LSF
        ESF_LSF(Ifan3, FanSensorSpacing1, FanRotationIncrement3, 2)

    end

end

x = input('***Task 3 and 4 completed.***\n***For all combination of values were projected:\n 1. Sinograms\n 2. reconstructed images\n 3. ESF and ELS ***\n***Press << Enter >> to continue***');
close all;

%% Task 5: Reconstructed image for the optimal value combination Δr=0.2 and Δθ=1, with Ram-Lak, Cosine and Hamming filter with cut-off frequency 100%
Y = {'Ram-Lak', 'Cosine', 'Hamming'}

for i = 1:length(Y)

    [F51, sensor_pos1, fan_rot_angle1] = fanbeam(P, R, 'FanRotationIncrement', 1, 'FanSensorGeometry', FanSensorGeometry1, 'FanSensorSpacing', 0.2);
    output_size = max(size(P));
    figure('NumberTitle', 'off', 'name', 'Reconstruction for Δr=0.2 - Δθ=1 ');
    Ifan51 = ifanbeam(F51, R, 'FanRotationIncrement', 1, 'FanSensorGeometry', FanSensorGeometry1, 'FanSensorSpacing', 0.2, 'Filter', Y{i}, 'FrequencyScaling', 1, 'Interpolation', 'cubic', 'OutputSize', output_size);
    CreateRois(Ifan51);
    title(sprintf('Cut-off 100 with %s filter', Y{i}));

    %ESF Bone
    figure('NumberTitle', 'off', 'name', Y{i})
    x1 = [317.663776493256 391.652215799615];
    y1 = [237.263005780347 237.263005780347];
    improfile(Ifan51, x1, y1)
    title(sprintf('ESF Bone - cutoff 100 - Δr=0.2 - Δθ=1'))

    %LSF Bone
    figure('NumberTitle', 'off', 'name', Y{i})
    x = diff(improfile(Ifan51, x1, y1));
    plot(x)
    title(sprintf('LSF Bone - cutoff 100 - Δr=0.2 - Δθ=1'))

    %ESF plastic water
    figure('NumberTitle', 'off', 'name', Y{i})
    x2 = [349.232177263969 281.162813102119];
    y2 = [281.162813102119 158.342003853565];
    improfile(Ifan51, x2, y2)
    title(sprintf('ESF Plastic Water - cutoff 100 - Δr=0.2 and Δθ=1'))

    %LSF plastic water
    figure('NumberTitle', 'off', 'name', Y{i})
    y = diff(improfile(Ifan51, x2, y2));
    plot(y)
    title(sprintf('LSF Plastic Water - cutoff 100 - Δr=0.2 and Δθ=1'))

end

x = input('***Task 5 completed*** \n***Press <<Enter>> to continue***');
close all;

%% Task 6: Reconstructed images for Hamming Filter and frequency scaling 1, 0.9 and 0.8 with Δr=0.2 and Δs=1
Z = [1 0.9 0.8]

for i = 1:3

    [F61, sensor_pos1, fan_rot_angle1] = fanbeam(P, R, 'FanRotationIncrement', 1, 'FanSensorGeometry', FanSensorGeometry1, 'FanSensorSpacing', 0.2);
    output_size = max(size(P));
    figure('NumberTitle', 'off', 'name', 'Reconstruction for Δr=0.2 - Δθ=1 ');
    Ifan61 = ifanbeam(F61, R, 'FanRotationIncrement', 1, 'FanSensorGeometry', FanSensorGeometry1, 'FanSensorSpacing', 0.2, 'Filter', filter, 'FrequencyScaling', Z(i), 'Interpolation', 'cubic', 'OutputSize', output_size);
    CreateRois(Ifan61);
    title(sprintf('Hamming filter and FrequencyScaling %.2f', Z(i)))

    %Calculation of ESF and LSF calling the corresponding function
    ESF_LSF(Ifan61, FanSensorSpacing1, Z(i), 3);

end

x = input('***Task 6 completed*** \n***Press <<Enter>> to terminate the program***');
close all;
