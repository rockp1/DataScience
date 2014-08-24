# Codebook for "Getting & Cleaning Data" Project
-----
---
## The Data
The objective is to predict "type of activity" (outcome variable), given measurements taken from a mobile device (Samsung Galaxy II). The activity is also video-recorded, and is used as an observed value of the outcome variable (activity).

The device measures both linear and 3-D signals. Each 3-D signal is a composite of three signals in X, Y and Z directions. 

##### 1 Filtering of raw signals
  * Time-domain signals from Accelerometer & Gyroscope were double-filtered with a median filter & noise reduction filter
  * Time-domain 3-D signals such as Body Acceleration and Gravity Acceleration were filtered with a low pass Butterworth filter
  * To get Jerk 3-D signals, Body Acceleration Jerk & Body Gyro Jerk, the derivative was applied to Body Linear Acceleration & Angular Velocity.
  * The magnitude of 3-D signals was calculated using the Euclidean Norm
  * Frequency-domain signals has the Fast Fourier Transform applied.

##### 2 Sampling of filtered signals
  * The filtered signals were sampled 128 times over 2.56 seconds, with an overlap of 50%

##### 3 Signal statistics of sampled signals
  * Mean, Standard deviation, Median absolute deviation, Largest & smallest values in the array, Signal magnitude area (sma), Energy, Interquartile range (iqr), Signal entropy, Autoregression coefficients, Mean Frequency, Skewness, Kurtosis, Bands energy & angle were calculated.

  * For this analysis only mean and standard deviation were kept for the time-domain signals. Only mean frequency was kept for the frequency-domain signals.

Base Variable | Derived Measures | Count | Description | Domain
---------- | ------------------- | ------ | -----------------
Body Acc | (Mean, SD)x(X,Y,Z, Mag) | 8 | Body Accelerometer | Time
Gravity Acc | (Mean, SD)x(X,Y,Z, Mag) | 8 | Gravity Accelerometer | Time
Body AccJerk | (Mean, SD)x(X,Y,Z, Mag) | 8 | Body Acc Jerk | Time
Body Gyro | (Mean, SD)x(X,Y,Z, Mag) | 8 | Body Gyrometer | Time
Body GyroJerk | (Mean, SD)x(X,Y,Z, Mag) | 8 | Body Gyro Jerk | Time
FFT Body Acc | (Mean, SD, MeanFreq)x(X,Y,Z, Mag) | 12 | Body Accelerometer | Frequency
FFT Body AccJerk | (Mean, SD, MeanFreq)x(X,Y,Z, Mag) | 12 | Body Acc Jerk | Frequency
FFT Body Gyro | (Mean, SD, MeanFreq)x(X,Y,Z, Mag) | 12 | Body Gyrometer | Frequency
FFT Body GyroJerk | (Mean, SD, MeanFreq) | 3 | Body Gyro Jerk | Frequency


