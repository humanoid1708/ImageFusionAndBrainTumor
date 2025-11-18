% Load the CT image in .jpg format
ct_img = imread('source14A.bmp');

% Convert to grayscale if the image is in RGB
if size(ct_img, 3) == 3
    ct_img = rgb2gray(ct_img);
end

% Resize the image to 224x224 (suitable for VGG19)
ct_img = imresize(ct_img, [224 224]);

% Display the original resized image
figure;
subplot(2,3,1), imshow(ct_img), title('Original Resized CT Image');

% Print the entropy, NIQE, and BRISQUE for the original resized image
fprintf('Original Resized Image:\n');
fprintf('Entropy: %.4f\n', entropy(ct_img));
fprintf('NIQE: %.4f\n', niqe(ct_img));  % Ensure niqe() is available
fprintf('BRISQUE: %.4f\n', brisque(ct_img));  % Ensure brisque() is available

% Step 1: Contrast Enhancement using CLAHE
ct_contrast = adapthisteq(ct_img, 'ClipLimit', 0.02);
subplot(2,3,2), imshow(ct_contrast), title('Contrast Enhanced (CLAHE)');

% Print the entropy, NIQE, and BRISQUE for the contrast enhanced image
fprintf('\nContrast Enhanced (CLAHE):\n');
fprintf('Entropy: %.4f\n', entropy(ct_contrast));
fprintf('NIQE: %.4f\n', niqe(ct_contrast));
fprintf('BRISQUE: %.4f\n', brisque(ct_contrast));

% Step 2: Intensity Normalization with Min-Max Normalization
ct_norm = mat2gray(ct_contrast);  % Normalize intensities to [0, 1]
subplot(2,3,3), imshow(ct_norm), title('Intensity Normalized');

% Print the entropy, NIQE, and BRISQUE for the intensity normalized image
fprintf('\nIntensity Normalized:\n');
fprintf('Entropy: %.4f\n', entropy(ct_norm));
fprintf('NIQE: %.4f\n', niqe(ct_norm));
fprintf('BRISQUE: %.4f\n', brisque(ct_norm));

% Step 3: Edge Enhancement using Unsharp Masking
ct_edge_enhanced = imsharpen(ct_norm, 'Radius', 2, 'Amount', 4);
subplot(2,3,4), imshow(ct_edge_enhanced), title('Edge Enhanced (Unsharp Mask)');

% Print the entropy, NIQE, and BRISQUE for the edge enhanced image
fprintf('\nEdge Enhanced (Unsharp Mask):\n');
fprintf('Entropy: %.4f\n', entropy(ct_edge_enhanced));
fprintf('NIQE: %.4f\n', niqe(ct_edge_enhanced));
fprintf('BRISQUE: %.4f\n', brisque(ct_edge_enhanced));

% Step 4: Noise Reduction using Gaussian Filter (simulating Anisotropic Diffusion)
ct_denoised = imgaussfilt(ct_edge_enhanced, 0.5);
subplot(2,3,5), imshow(ct_denoised), title('Noise Reduced (Gaussian Filter)');

% Print the entropy, NIQE, and BRISQUE for the noise reduced image
fprintf('\nNoise Reduced (Gaussian Filter):\n');
fprintf('Entropy: %.4f\n', entropy(ct_denoised));
fprintf('NIQE: %.4f\n', niqe(ct_denoised));
fprintf('BRISQUE: %.4f\n', brisque(ct_denoised));

% Save the final processed image
imwrite(ct_denoised, 'final_ct_image.jpg');

% Overall display layout for comparison
sgtitle('CT Scan Pre-processing Stages');
