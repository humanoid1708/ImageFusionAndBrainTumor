% MATLAB code for post-processing a fused image with CLAHE, Anisotropic Diffusion, and Gaussian Filter

% Read the fused grayscale image
fused_img = imread('Fused2.jpg'); % Replace with the fused image path
if size(fused_img, 3) == 3
    fused_img = rgb2gray(fused_img);
end

% Original Metrics
disp('Metrics for Original Fused Image:');
entropy_original = entropy(fused_img);
niqe_original = niqe(fused_img);
brisque_original = brisque(fused_img);

fprintf('Entropy: %.4f\n', entropy_original);
fprintf('NIQE: %.4f\n', niqe_original);
fprintf('BRISQUE: %.4f\n', brisque_original);

% Step 1: CLAHE (Contrast Limited Adaptive Histogram Equalization)
clahe_img = adapthisteq(fused_img, 'ClipLimit', 0.03, 'Distribution', 'rayleigh');

% Metrics after CLAHE
disp('Metrics after CLAHE:');
entropy_clahe = entropy(clahe_img);
niqe_clahe = niqe(clahe_img);
brisque_clahe = brisque(clahe_img);

fprintf('Entropy: %.4f\n', entropy_clahe);
fprintf('NIQE: %.4f\n', niqe_clahe);
fprintf('BRISQUE: %.4f\n', brisque_clahe);

% Step 2: Anisotropic Diffusion for Noise Reduction
% Using 'imdiffuse' function for anisotropic diffusion
diffusion_img = imdiffusefilt(clahe_img, 'NumberOfIterations', 18, 'GradientThreshold',7);

% Metrics after Anisotropic Diffusion
disp('Metrics after Anisotropic Diffusion:');
entropy_diffusion = entropy(diffusion_img);
niqe_diffusion = niqe(diffusion_img);
brisque_diffusion = brisque(diffusion_img);

fprintf('Entropy: %.4f\n', entropy_diffusion);
fprintf('NIQE: %.4f\n', niqe_diffusion);
fprintf('BRISQUE: %.4f\n', brisque_diffusion);

% Step 3: Gaussian Filter for Noise Reduction
% Apply Gaussian filter with a kernel size of 5x5 and sigma of 1.5
gaussian_filtered_img = imgaussfilt(diffusion_img, 0.3);

% Metrics after Gaussian Filter
disp('Metrics after Gaussian Filter:');
entropy_gaussian = entropy(gaussian_filtered_img);
niqe_gaussian = niqe(gaussian_filtered_img);
brisque_gaussian = brisque(gaussian_filtered_img);

fprintf('Entropy: %.4f\n', entropy_gaussian);
fprintf('NIQE: %.4f\n', niqe_gaussian);
fprintf('BRISQUE: %.4f\n', brisque_gaussian);

% Display all images in subplots
figure;

subplot(2, 3, 1);
imshow(fused_img);
title('Original Fused Image');

subplot(2, 3, 2);
imshow(clahe_img);
title('After CLAHE');

subplot(2, 3, 3);
imshow(diffusion_img);
title('After Anisotropic Diffusion');

subplot(2, 3, 4);
imshow(gaussian_filtered_img);
title('After Gaussian Filter');
