Getting and Cleaning Data Course Project
==============================================

Daniel Bell
----------------------------------------------

### Samsung Galaxy S acceleramotor data - Codebook


#### Variables contained in the tidy dataset
Name             | Description
-----------------|------------
subject          | The ID of the subject who was studied
activity         | name of the activity the subject is currently performing
featDomain       | Boolean indicating indicating either time or frequency
featInstrument   | Instrument used to measure signal
featAcceleration | Acceleration signal
featVariable     | Either the mean or standard deviation of observation
featJerk         | Jerk signal
featMagnitude    | Magnitude of the signals
featAxis         | 3-axial signals in the X, Y and Z directions (X, Y, or Z)
featCount        | Count of data points used to compute average
featAverage      | Average of each variable for each activity and each subject

#### Summary of Variables

```r
summary(dataTidy)
```

```
##     subject                   activity    featDomain  featAcceleration
##  Min.   : 1.0   LAYING            :1980   Time:7200   NA     :4680    
##  1st Qu.: 8.0   SITTING           :1980   Freq:4680   Body   :5760    
##  Median :15.5   STANDING          :1980               Gravity:1440    
##  Mean   :15.5   WALKING           :1980                               
##  3rd Qu.:23.0   WALKING_DOWNSTAIRS:1980                               
##  Max.   :30.0   WALKING_UPSTAIRS  :1980                               
##        featInstrument featJerk      featMagnitude  featVariable featAxis 
##  Accelerometer:7200   NA  :7200   NA       :8640   Mean:5940    NA:3240  
##  Gyroscope    :4680   Jerk:4680   Magnitude:3240   SD  :5940    X :2880  
##                                                                 Y :2880  
##                                                                 Z :2880  
##                                                                          
##                                                                          
##      count          average        
##  Min.   :36.00   Min.   :-0.99767  
##  1st Qu.:49.00   1st Qu.:-0.96205  
##  Median :54.50   Median :-0.46989  
##  Mean   :57.22   Mean   :-0.48436  
##  3rd Qu.:63.25   3rd Qu.:-0.07836  
##  Max.   :95.00   Max.   : 0.97451
```

#### A sample of the Data

```r
head(dataTidy)
```

```
##    subject activity featDomain featAcceleration featInstrument featJerk
## 1:       1   LAYING       Time               NA      Gyroscope       NA
## 2:       1   LAYING       Time               NA      Gyroscope       NA
## 3:       1   LAYING       Time               NA      Gyroscope       NA
## 4:       1   LAYING       Time               NA      Gyroscope       NA
## 5:       1   LAYING       Time               NA      Gyroscope       NA
## 6:       1   LAYING       Time               NA      Gyroscope       NA
##    featMagnitude featVariable featAxis count     average
## 1:            NA         Mean        X    50 -0.01655309
## 2:            NA         Mean        Y    50 -0.06448612
## 3:            NA         Mean        Z    50  0.14868944
## 4:            NA           SD        X    50 -0.87354387
## 5:            NA           SD        Y    50 -0.95109044
## 6:            NA           SD        Z    50 -0.90828466
```

#### Structure of the Tidy Dataset

```r
str(dataTidy)
```

```
## Classes 'data.table' and 'data.frame':	11880 obs. of  11 variables:
##  $ subject         : int  1 1 1 1 1 1 1 1 1 1 ...
##  $ activity        : Factor w/ 6 levels "LAYING","SITTING",..: 1 1 1 1 1 1 1 1 1 1 ...
##  $ featDomain      : Factor w/ 2 levels "Time","Freq": 1 1 1 1 1 1 1 1 1 1 ...
##  $ featAcceleration: Factor w/ 3 levels NA,"Body","Gravity": 1 1 1 1 1 1 1 1 1 1 ...
##  $ featInstrument  : Factor w/ 2 levels "Accelerometer",..: 2 2 2 2 2 2 2 2 2 2 ...
##  $ featJerk        : Factor w/ 2 levels NA,"Jerk": 1 1 1 1 1 1 1 1 2 2 ...
##  $ featMagnitude   : Factor w/ 2 levels NA,"Magnitude": 1 1 1 1 1 1 2 2 1 1 ...
##  $ featVariable    : Factor w/ 2 levels "Mean","SD": 1 1 1 2 2 2 1 2 1 1 ...
##  $ featAxis        : Factor w/ 4 levels NA,"X","Y","Z": 2 3 4 2 3 4 1 1 2 3 ...
##  $ count           : int  50 50 50 50 50 50 50 50 50 50 ...
##  $ average         : num  -0.0166 -0.0645 0.1487 -0.8735 -0.9511 ...
##  - attr(*, "sorted")= chr  "subject" "activity" "featDomain" "featAcceleration" ...
##  - attr(*, ".internal.selfref")=<externalptr>
```

#### Keys

```r
key(dataTidy)
```

```
## [1] "subject"          "activity"         "featDomain"      
## [4] "featAcceleration" "featInstrument"   "featJerk"        
## [7] "featMagnitude"    "featVariable"     "featAxis"
```

#### Output Dataset
The tidy dataset was created in the run_analysis.R script and is saved in the same location as the script.


 
