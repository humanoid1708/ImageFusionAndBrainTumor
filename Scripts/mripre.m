% Load the MRI image in .jpg format
mri_img = imread('15b.tif');

% Convert to grayscale if the image is in RGB
if size(mri_img, 3) == 3
    mri_img = rgb2gray(mri_img);
end

mri_img = imresize(mri_img, [224 224]);

% Display the original image
figure;
subplot(2,3,1), imshow(mri_img), title('Original MRI Image');

% Print the entropy, NIQE, and BRISQUE for the original image
fprintf('Original MRI Image:\n');
fprintf('Entropy: %.4f\n', entropy(mri_img));
fprintf('NIQE: %.4f\n', niqe(mri_img));  % Ensure niqe() is available
fprintf('BRISQUE: %.4f\n', brisque(mri_img));  % Ensure brisque() is available

% Step 1: Contrast Enhancement using CLAHE
mri_clahe = adapthisteq(mri_img, 'ClipLimit', 0.02);  % Apply CLAHE
subplot(2,3,2), imshow(mri_clahe), title('Contrast Enhanced (CLAHE)');

% Print the entropy, NIQE, and BRISQUE for the CLAHE enhanced image
fprintf('\nContrast Enhanced (CLAHE):\n');
fprintf('Entropy: %.4f\n', entropy(mri_clahe));
fprintf('NIQE: %.4f\n', niqe(mri_clahe));
fprintf('BRISQUE: %.4f\n', brisque(mri_clahe));

% Step 2: Z-Score Normalization
% Convert to double for accurate calculation
mri_double = double(mri_clahe);
mean_intensity = mean(mri_double(:));
std_intensity = std(mri_double(:));
mri_zscore = (mri_double - mean_intensity) / std_intensity;  % Z-score normalization
% Normalize to [0, 1] for display
mri_zscore_normalized = mat2gray(mri_zscore);
subplot(2,3,3), imshow(mri_zscore_normalized), title('Z-Score Normalized');

% Print the entropy, NIQE, and BRISQUE for the Z-Score normalized image
fprintf('\nZ-Score Normalized:\n');
fprintf('Entropy: %.4f\n', entropy(mri_zscore_normalized));
fprintf('NIQE: %.4f\n', niqe(mri_zscore_normalized));
fprintf('BRISQUE: %.4f\n', brisque(mri_zscore_normalized));

% Step 3: Edge Detection using Canny
edges_canny = edge(mri_zscore_normalized, 'Canny');  % Apply Canny edge detection
subplot(2,3,4), imshow(edges_canny), title('Edge Detection (Canny)');

% Step 4: Unsharp Masking for Sharpening
unsharp_img = imsharpen(mri_zscore_normalized, 'Radius', 2, 'Amount', 0.25);  % Apply unsharp masking
subplot(2,3,5), imshow(unsharp_img), title('Sharpened (Unsharp Masking)');

% Print the entropy, NIQE, and BRISQUE for the sharpened image
fprintf('\nSharpened (Unsharp Masking):\n');
fprintf('Entropy: %.4f\n', entropy(unsharp_img));
fprintf('NIQE: %.4f\n', niqe(unsharp_img));
fprintf('BRISQUE: %.4f\n', brisque(unsharp_img));

% Save the final processed image
imwrite(unsharp_img, '15bPre.jpg');

% Overall display layout for comparison
sgtitle('MRI Scan Pre-processing Stages');
