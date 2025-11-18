% Load the pre-trained VGG19 network
net = vgg19;

% Read the CT and MRI images (JPG format)
ct_img = imread('FinalCT1.jpg');   % Load your CT image (JPG)
mri_img = imread('trialmri.jpg'); % Load your MRI image (JPG)

% Resize the images to the input size required by VGG19 (224x224)
inputSize = net.Layers(1).InputSize(1:2);
ct_img_resized = imresize(ct_img, inputSize);
mri_img_resized = imresize(mri_img, inputSize);

% Convert images to RGB if they are grayscale
if size(ct_img_resized, 3) == 1
    ct_img_resized = cat(3, ct_img_resized, ct_img_resized, ct_img_resized);
end
if size(mri_img_resized, 3) == 1
    mri_img_resized = cat(3, mri_img_resized, mri_img_resized, mri_img_resized);
end

% Extract features from the CT and MRI images using VGG19's convolutional layers
layer = 'conv5_4';  % Select the last convolutional layer
ct_features = activations(net, ct_img_resized, layer);
mri_features = activations(net, mri_img_resized, layer);

% Feature Fusion using maximum selection (can use other methods like averaging)
fused_features = max(ct_features, mri_features);

% Perform inverse transformation (upscaling to original size)
fused_img_resized = (double(ct_img_resized) + double(mri_img_resized)) / 2;

% Convert the fused image back to grayscale
fused_img_gray = rgb2gray(uint8(fused_img_resized));

% Display the original images and the grayscale fused image
figure;
subplot(1, 3, 1);
imshow(ct_img);
title('Original CT Image');

subplot(1, 3, 2);
imshow(mri_img);
title('Original MRI Image');

subplot(1, 3, 3);
imshow(fused_img_gray);
title('Fused Image (Grayscale)');

% Save the grayscale fused image
imwrite(fused_img_gray, 'Fusedtrial.jpg');

% Calculate and print metrics for fused_img_gray
disp('Metrics for Fused Image (Grayscale):');
entropy_gray = entropy(fused_img_gray);
niqe_gray = niqe(fused_img_gray);
brisque_gray = brisque(fused_img_gray);

fprintf('Entropy: %.4f\n', entropy_gray);
fprintf('NIQE: %.4f\n', niqe_gray);
fprintf('BRISQUE: %.4f\n', brisque_gray);
