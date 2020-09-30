%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 2018 - Medical Imaging Project		     %
% MSc Biomedical Engineering - UPatras       %
% Elissaios Petrai                           %
% petrai AT ceid.upatras.gr                  %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function [] = ESF_LSF(Ifa, counterr, jjj, idd)

    if idd == 1
        %ESF Bone
        figure('NumberTitle', 'off', 'name', 'ESF Bone')
        x1 = [317.663776493256 391.652215799615];
        y1 = [237.263005780347 237.263005780347];
        improfile(Ifa, x1, y1)
        title(sprintf('ESF Bone - Original Image'))

        %LSF Bone
        figure('NumberTitle', 'off', 'name', 'LSF Bone')
        x = diff(improfile(Ifa, x1, y1));
        plot(x)
        title(sprintf('LSF Bone - Original Image'))

        %ESF plastic water
        figure('NumberTitle', 'off', 'name', 'ESF P.Water')
        x2 = [349.232177263969 281.162813102119];
        y2 = [281.162813102119 158.342003853565];
        improfile(Ifa, x2, y2)
        title(sprintf('ESF P. Water - Original Image'))

        %LSF plastic water
        figure('NumberTitle', 'off', 'name', 'LSF P. Water')
        y = diff(improfile(Ifa, x2, y2));
        plot(y)
        title(sprintf('LSF P. Water - Original Image'))

    elseif idd == 2
        %ESF Bone
        figure('NumberTitle', 'off', 'name', 'ESF Bone - Hanning filter')
        x1 = [317.663776493256 391.652215799615];
        y1 = [237.263005780347 237.263005780347];
        improfile(Ifa, x1, y1)
        title(sprintf('ESF Bone - Hanning 0.95 - Δr=%.2f - Δθ=%.2f', counterr, jjj))

        %LSF Bone
        figure('NumberTitle', 'off', 'name', 'LSF Bone - Hanning filter')
        x = diff(improfile(Ifa, x1, y1));
        plot(x)
        title(sprintf('LSF Bone - Hanning 0.95 - Δr=%.2f - Δθ=%.2f', counterr, jjj))

        %ESF plastic water
        figure('NumberTitle', 'off', 'name', 'ESF P. Water - Hanning filter')
        x2 = [349.232177263969 281.162813102119];
        y2 = [281.162813102119 158.342003853565];
        improfile(Ifa, x2, y2)
        title(sprintf('ESF P. Water - Hanning 0.95 - Δr=%.2f - Δθ=%.2f', counterr, jjj))

        %LSF plastic water
        figure('NumberTitle', 'off', 'name', 'LSF P. Water - Hanning filter')
        y = diff(improfile(Ifa, x2, y2));
        plot(y)
        title(sprintf('LSF P. Water - Hanning 0.95 - Δr=%.2f - Δθ=%.2f', counterr, jjj))

    elseif idd == 3%for task 6. Hamming filter with cutoff 1, 0.9, 0.8 and for Δr=02, Δθ=1
        %ESF Bone
        figure('NumberTitle', 'off', 'name', 'ESF Bone - Hamming filter')
        x1 = [317.663776493256 391.652215799615];
        y1 = [237.263005780347 237.263005780347];
        improfile(Ifa, x1, y1)
        title(sprintf('ESF Bone - cutoff%.2f - Δr=0.2 - Δθ=1', jjj))

        %LSF Bone
        figure('NumberTitle', 'off', 'name', 'LSF Bone - Hamming filter')
        x = diff(improfile(Ifa, x1, y1));
        plot(x)
        title(sprintf('LSF Bone - cutoff%.2f- Δr=0.2 - Δθ=1', jjj))

        %ESF Plastic Water
        figure('NumberTitle', 'off', 'name', 'ESF P.Water Hamming filter')
        x2 = [349.232177263969 281.162813102119];
        y2 = [281.162813102119 158.342003853565];
        improfile(Ifa, x2, y2)
        title(sprintf('ESF P. Water - cutoff%.2f - Δr=0.2 kai Δθ=1', jjj))

        %LSF plastic water
        figure('NumberTitle', 'off', 'name', 'LSF P.Water - Hamming filter')
        y = diff(improfile(Ifa, x2, y2));
        plot(y)
        title(sprintf('LSF Plastic Water - cutoff %.2f - Δr=0.2 kai Δθ=1', jjj))

    end
