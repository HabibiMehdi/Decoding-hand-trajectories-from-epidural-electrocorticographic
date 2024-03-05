# Decoding-hand-trajectories-from-epidural-electrocorticographic
Overview
This repository implements the decoding of continuous three-dimensional hand trajectories from epidural electrocorticographic (eECoG) signals. The method is based on the research paper titled "Decoding continuous three-dimensional hand trajectories from epidural electrocorticographic signals in Japanese macaques."

Paper Reference
Title: Decoding continuous three-dimensional hand trajectories from epidural electrocorticographic signals in Japanese macaques
Authors: [Kentaro Shimoda]

**Dataset**
The dataset used in this project involves two adult Japanese macaques (monkeys B and C) implanted with customized 64-channel ECoG electrodes in the epidural space of the left hemisphere. The electrodes cover the area from the prefrontal cortex (PFC) to the primary somatosensory cortex (S1). Detailed information about the electrode specifications, locations, and surgical procedures can be found in Section 2.1 of the paper.

**Preprocessing**

Subjects and Surgical Procedure
Electrode Information: Customized 64-channel ECoG electrodes.
Implantation Area: Left hemisphere from PFC to S1.
Reference Electrode: Rectangular platinum plate in the epidural space.
Ground Electrode: Rectangular platinum plate above the skull.
Surgical Details: [Provide relevant surgical details mentioned in the paper]
Data Processing
Paradigm for Off-line Decoding: Follows the proposed paradigm for off-line decoding mentioned in Section 2.1.
Signal Processing:
Band-pass filtering from 0.3 to 500 Hz.
Common average referencing for data analyses.
Hand Position Prediction:
Prediction of the instantaneous 3D hand position at time t from brain signals during the previous 1 s.
Conversion of hand positions to body-centered coordinates (X: left–right, Y: forward–backward, Z: up–down).
Time–Frequency Representation:
Morlet wavelet transformation at ten different center frequencies ranging from 10 to 120 Hz.
Generation of a 10x10 scalogram matrix.
Decoding Model:
Multivariate partial least-squares (PLS) regression on the training data.
Ten-fold cross-validation to determine the optimal number of PLS components.
Validation:
Performance quantification based on correlation coefficients between predicted and observed hand trajectories using data recorded during the last 5 minutes.
That's project about decoding hand trajectories from epidural electrocorticographic(ECoG)

we using dataset from this paper"Decoding continuous three-dimensional hand trajectories from epidural electrocorticographic signals in Japanese macaques" with DOI: 10.1088/1741-2560/9/3/036015.

![image](https://github.com/thehabibimm/Decoding-hand-trajectories-from-epidural-electrocorticographic/assets/123571190/74ba04e3-b26f-49ea-be96-8bcc92e7befa)


![image](https://github.com/thehabibimm/Decoding-hand-trajectories-from-epidural-electrocorticographic/assets/123571190/e93eb059-f373-4c3d-a4a8-52a96866c1dc)


**Result for channel 11**


![result_reg](https://github.com/thehabibimm/Decoding-hand-trajectories-from-epidural-electrocorticographic/assets/123571190/15df146a-34cc-4b5b-bc1d-87933448fcd4)


