---
layout: post
title: "Exploring EEG data with Python"
description: ""
category: EngineeringTales
tags: []
---



given resources:

```
    https://www.kaggle.com/c/grasp-and-lift-eeg-detection
    www.nature.com/articles/sdata201447
    https://github.com/luciw/way-eeg-gal-utilities.
```

to at the zip file that you can download from kaggle,
this results in this subset of files

```
17M     subj1_series1_data.csv
3.7M    subj1_series1_events.csv
39M     subj1_series2_data.csv
8.5M    subj1_series2_events.csv
31M     subj1_series3_data.csv
6.8M    subj1_series3_events.csv
....
```

Now they are all csvs, i took one subjects data and started looking through it.
will need to only concentrate on *subj1_series1_data.csv* and *subj1_series1_events.csv*.

subj1_series1_events.csv looks like

```
id,HandStart,FirstDigitTouch,BothStartLoadPhase,LiftOff,Replace,BothReleased
subj1_series1_0,0,0,0,0,0,0
subj1_series1_1,0,0,0,0,0,0
subj1_series1_2,0,0,0,0,0,0
subj1_series1_3,0,0,0,0,0,0
subj1_series1_4,0,0,0,0,0,0
subj1_series1_5,0,0,0,0,0,0
subj1_series1_6,0,0,0,0,0,0
......
```

subj1_series1_data.csv looks like

```
id,Fp1,Fp2,F7,F3,Fz,F4,F8,FC5,FC1,FC2,FC6,T7,C3,Cz,C4,T8,TP9,CP5,CP1,CP2,CP6,TP10,P7,P3,Pz,P4,P8,PO9,O1,Oz,O2,PO10
subj1_series1_0,-31,363,211,121,211,15,717,279,35,158,543,-166,192,230,573,860,128,59,272,473,325,379,536,348,383,105,607,289,459,173,120,704
subj1_series1_1,-29,342,216,123,222,200,595,329,43,166,495,-138,201,233,554,846,185,47,269,455,307,368,529,327,369,78,613,248,409,141,83,737
subj1_series1_2,-172,278,105,93,222,511,471,280,12,177,534,-163,198,207,542,768,145,52,250,452,273,273,511,319,355,66,606,320,440,141,62,677
```

basically, the events file describes the events i.e HandStart,FirstDigitTouch,BothStartLoadPhase,LiftOff,Replace,BothReleased
the second file gives the raw EEG data (as a time series or a electric wavefeform) of the various channels being recorded. (which is quite a fucklot)

hmm. interesting.

so its fair to assume that only one event would happen at a time and a search for ,1, in the events text file confirms it.

first thing is to write a script to study this events table.
questions i need to answer

1. How long is each event?
2. what is the start and end id of each event?


a quick python script (@read_events.py on my github)

```
$ python read_events.py                                                                                            
subj1_series1_0 [0, 0, 0, 0, 0, 0] 0
subj1_series1_1068 [1, 0, 0, 0, 0, 0] 1068
subj1_series1_1218 [0, 0, 0, 0, 0, 0] 150
subj1_series1_1720 [0, 0, 0, 0, 1, 0] 502
subj1_series1_1766 [0, 0, 0, 1, 1, 0] 46
subj1_series1_1870 [0, 0, 0, 1, 0, 0] 104
subj1_series1_1916 [0, 0, 0, 0, 0, 0] 46
subj1_series1_1920 [0, 1, 0, 0, 0, 0] 4
subj1_series1_2070 [0, 0, 0, 0, 0, 0] 150
subj1_series1_3532 [0, 0, 1, 0, 0, 0] 1462
subj1_series1_3659 [0, 0, 1, 0, 0, 1] 127
subj1_series1_3682 [0, 0, 0, 0, 0, 1] 23
subj1_series1_3809 [0, 0, 0, 0, 0, 0] 127
subj1_series1_4708 [1, 0, 0, 0, 0, 0] 899
subj1_series1_4858 [0, 0, 0, 0, 0, 0] 150
subj1_series1_5110 [0, 0, 0, 0, 1, 0] 252
subj1_series1_5139 [0, 0, 0, 1, 1, 0] 29
subj1_series1_5217 [0, 1, 0, 1, 1, 0] 78
subj1_series1_5260 [0, 1, 0, 1, 0, 0] 43
subj1_series1_5289 [0, 1, 0, 0, 0, 0] 29
subj1_series1_5367 [0, 0, 0, 0, 0, 0] 78
subj1_series1_6786 [0, 0, 1, 0, 0, 0] 1419
subj1_series1_6906 [0, 0, 1, 0, 0, 1] 120
subj1_series1_6936 [0, 0, 0, 0, 0, 1] 30
subj1_series1_7056 [0, 0, 0, 0, 0, 0] 120
subj1_series1_7947 [1, 0, 0, 0, 0, 0] 891
subj1_series1_8097 [0, 0, 0, 0, 0, 0] 150
subj1_series1_8328 [0, 0, 0, 0, 1, 0] 231
subj1_series1_8349 [0, 0, 0, 1, 1, 0] 21
subj1_series1_8407 [0, 1, 0, 1, 1, 0] 58
...
```

hmm, now we are getting somewhere.
also the previous assumption that only one event can happen at a time is bullcrap.

these points where the events change are what we are going to define as inflection points or as my python script says -timepoints. yes, fancy words are a must when you are experimenting in the data science field.

timepoints (or inflection points) are important points of time that the algorithm needs to be aware of.

the [0, 1, 0, 1, 1, 0] seems kinda random so i decided to treat it like a binary string and convert it into an it.
this proved interesting..

the following table is id, class, delta

```
7947 32 891
8097 0 150
8328 16 231
8349 24 21
8407 28 58
8478 12 71
8499 4 21
8557 0 58
9833 2 1276
9983 0 150
9998 1 15
10148 0 150

10905 32 757
11055 0 150
11242 16 187
11294 24 52
11352 28 58
11392 12 40
11444 4 52
11502 0 58
12838 2 1336
12973 3 135
12988 1 15
13123 0 135

13872 32 749
14022 0 150
14236 16 214
14260 24 24
14308 28 48
14386 12 78
14410 4 24
14458 0 48
15834 2 1376
15912 3 78
15984 1 72
16062 0 78

17175 32 1113
17325 0 150
17546 16 221
17575 24 29
17630 28 55
17696 12 66
17725 4 29
17780 0 55
19107 2 1327
19235 3 128
19257 1 22
19385 0 128

20532 32 1147
[...]
```

class is determined by [0, 0, 1, 0, 0, 0] -> '001000' -> int('001000',2) -> 8

and you can now see that there is a 12 number pattern marked by 32!

32 is the answer. we can split the input series data into windows based on this!!

now a few points to note on the approach. (in case i forgets later)

1. We cannot use data from the future to test, hence we shall not use data from the future to train also. 
# but we have the window, the pattern of test cases being run is as per the window!
2. Every TimePoint is what we are trying to get the classifier to train for.
3. so the input to the classifier will be
    a. the previous detected state (or current state)
    b. the length of the data points from the last timepoint to the current one
    c. feature selection to decide important feature points that represent 
    d. building wavelet coefficients of time windows as features instead of raw points
4. I've decided to use an SVM model to train and predict which classes it belongs to.

// it is important to note that the points a & b are inherently error prone in a production environment so they should be given less weightage than the other methods.
