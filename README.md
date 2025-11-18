# Fusion of CT and MRI Images using VGG-19

This project provides the MATLAB implementation for the research paper:  
**"Fusion of CT and MRI Images using VGG-19 with Preprocessing and Edge Enhancement".**

The model fuses **Computed Tomography (CT)** and **Magnetic Resonance Imaging (MRI)** scans to produce a single, composite image. This fused image combines:

- High-density structural details (e.g., bone) from **CT**
- Detailed soft-tissue information from **MRI**

The primary goal is to **enhance edge and contour features**, which is critical for applications like **medical diagnosis** and **tumor detection**.

---

## 📋 Methodology

The core of this project is a **three-stage image processing pipeline**.  
You can see a detailed flowchart of this entire process in **Figure 1** and **Figure 2** of the included PDF.

---

### 1. Pre-processing

Before fusion, the CT and MRI source images are processed through **separate, specialized pipelines** to enhance key features and normalize intensities.

#### 🔹 CT Image Pipeline — `ctpre.m`

1. **CLAHE**  
   Contrast Limited Adaptive Histogram Equalization for local contrast enhancement.

2. **Min-Max Normalization**  
   Rescales pixel intensities to a `[0, 1]` range.

3. **Unsharp Masking**  
   Enhances edges and fine details.

4. **Gaussian Filter**  
   Reduces noise while preserving important structures.

#### 🔹 MRI Image Pipeline — `mripre.m`

1. **CLAHE**  
   Applied for contrast enhancement.

2. **Z-Score Normalization**  
   Standardizes image intensities to have zero mean and unit variance.

3. **Unsharp Masking**  
   Sharpens edges and anatomical structures.

---

### 2. VGG-19 Feature Fusion — `enhancefuse.m`

This is the **fusion stage**. The two pre-processed images are fed into a **pre-trained VGG-19** convolutional neural network.

1. **Feature Extraction**  
   Deep features are extracted from the last convolutional layer, **`conv5_4`**.  
   This layer is chosen because it captures **high-level semantic information** and **spatial context**.

2. **Fusion**  
   The extracted feature maps from the CT and MRI images are combined using a **maximum selection strategy**.

3. **Image Reconstruction**  
   The fused features are then used to construct the **final fused grayscale image**.

---

### 3. Post-processing — `PostProcess.m`

The newly fused image undergoes a final **refinement pipeline** to reduce any artifacts from the fusion process and further enhance visual quality.

1. **CLAHE**  
   Applied again to improve the overall contrast of the fused image.

2. **Anisotropic Diffusion**  
   Reduces noise while preserving important edges and contours.

3. **Gaussian Filter**  
   A final smoothing step to reduce any subtle, residual noise.

---

## ⚙️ Project Files

- `ctpre.m`  
  MATLAB script for the complete pre-processing pipeline for the **CT** image.

- `mripre.m`  
  MATLAB script for the complete pre-processing pipeline for the **MRI** image.

- `enhancefuse.m`  
  MATLAB script that:
  - Loads the pre-processed CT and MRI images  
  - Fuses them using **VGG-19**  
  - Calculates **quality metrics** for the fused image

- `PostProcess.m`  
  MATLAB script that:
  - Applies the post-processing pipeline to the fused image  
  - Calculates metrics at each step of the enhancement process

- `Fusion_Of_CT_And_MRI_Images.pdf`  
  The complete research paper detailing:
  - Methodology  
  - Quantitative results (**Tables 1–3**)  
  - Qualitative analysis and visual comparisons

---

## 🚀 How to Run

### ✅ Prerequisites

- **MATLAB**
- **MATLAB Image Processing Toolbox**
- **MATLAB Deep Learning Toolbox** (for VGG-19)

### ▶️ Execution Order

1. Place your source **CT** and **MRI** images (e.g., `.bmp`, `.tif`, `.jpg`) in the project directory.

2. Run **`ctpre.m`** to pre-process your CT image.  
   - This will save a new CT image (e.g., `final_ct_image.jpg`).

3. Run **`mripre.m`** to pre-process your MRI image.  
   - This will save a new MRI image (e.g., `15bPre.jpg`).

4. Open **`enhancefuse.m`** and **update the `imread` paths** to load the two pre-processed images you just created.

5. Run **`enhancefuse.m`**.  
   - This will generate the initial fused image (e.g., `Fusedtrial.jpg`).  
   - It will also **print its quality metrics** (Entropy, NIQE, BRISQUE).

6. Open **`PostProcess.m`** and **update the `imread` path** to load the fused image from the previous step.

7. Run **`PostProcess.m`** to:
   - Apply the final enhancement pipeline  
   - View the **updated fused image** and the **corresponding metrics**

---

## 📊 Evaluation Metrics

The quality of the images at each stage is measured using three standard **no-reference (blind) image quality evaluators**:

1. **Entropy (EN)**  
   - Measures the **information content** and **textural detail**.  
   - **Higher value is better.**

2. **NIQE (Naturalness Image Quality Evaluator)**  
   - Assesses the **perceptual naturalness** of the image.  
   - **Lower score is better.**

3. **BRISQUE (Blind/Referenceless Image Spatial Quality Evaluator)**  
   - Measures quality based on **artifacts** and **distortions**.  
   - **Lower score is better.**

As shown in the paper, the proposed model:

- **Increases** image **entropy (EN)**  
- **Decreases** **NIQE** and **BRISQUE** scores  

This indicates a **high-quality fusion** that preserves important details while reducing artifacts.

---

## 📄 Reference

This repository is the official implementation for the paper:

> **Nikhil V. Soniminde and Ajay Kaushal.**  
> *"Fusion of CT and MRI Images using VGG-19 with Preprocessing and Edge Enhancement."*

