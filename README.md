## Data-drive High-dimensional Uncertainty Quantification for Combustion Instability Prediction

<img src="./Images/Highlight.png" width=500 height=300 />

### 1. Highlight

- This work developed data-driven strategies to efficiently calculate combustion instability risk given a high-dimensional uncertain flame model.
- The Active Subspace approach is firstly used to reduce the problem dimensionality, followed by training a supervised learning model to map from the low-dimensional manifold to the target risk indices.
- The proposed solution led to 50 times faster risk calculation while achieving state-of-the-art accuracy.

This work was firstly presented in [ASME Turbo Expo 2018](https://archive.asme.org/events/turbo-expo2018) conference, and was later published in the journal:

Guo S., Silva C. F., Ghani A., Polifke W., [Quantification and Propagation of Uncertainties in Identification of Flame Impulse Response for Thermoacoustic Stability Analysis](https://asmedigitalcollection.asme.org/gasturbinespower/article-abstract/141/2/021032/476450/Quantification-and-Propagation-of-Uncertainties-in?redirectedFrom=fulltext). *Journal of Engineering for Gas Turbines and Power*, 2019, 141(2), pp. 021032.

### 2. Motivation

Accurately predicting the combustion instability is crucial for the industry to design reliable gas turbine systems. However, the flame model employed in the predicting pipeline usually contains uncertain parameters, thus compromising the reliability of the instability prediction. 

In practice, a flame model's uncertainty stems from the noisy measured/simulated time-series data, from which the flame model is identified. Since an identified flame model usually contains a large number of parameters, accurately and efficiently quantify the instability risk induced by the high-dimensional uncertain parameters is challenging.

### 3. Methodology

To solve this problem, we first developed a pipeline to construct a regression model, which takes in flame model parameters and outputs the instability index. Based on this regression model, we can then perform accelerated Monte Carlo simulations to quantify the instability risk:

- We first used Active Subspace to reduce the problem dimensionality. Active Subspace is a supervised dimensionality reduction technique, which can uncover a low-dimensional manifold that along the direction of this manifold the output of interest varies the most.

- We trained a polynomial regression model to map the identified low-dimensional manifold to the instability index (i.e., modal growth rate.)

- We applied Monte Carlo approach to the trained regression model to quantify the likelihood of instability occurrence, i.e., instability risk.

<img src="./Images/Workflow.png" width=500 height=300 />

### 4. Results

- The Active Subspace approach managed to identify a 1D subspace, such that the output varies the most along this direction.

<img src="./Images/Subspace.png" width=500 height=300 />

- Thanks to the reduced problem dimensionality, the overall cost for calculating the instability risk reduced 50-fold, without compromising the accuracy.

<img src="./Images/Results.png" width=500 height=300 />

### 5. Folder structure

**1. Presentation**: the slides presented in [ASME Turbo Expo 2018](https://archive.asme.org/events/turbo-expo2018) conference.

**2. MatlabScripts**: MATLAB source code and data to reproduce the results. The code and data are organized in individual folders corresponding to different sections in the paper. A step-by-step implementation of Active Subspace approach can be found in **AS_Simulation_Sec5**
