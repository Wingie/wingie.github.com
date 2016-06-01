---
layout: post
title: "Features on le EEG data with Python"
description: ""
category: EngineeringTales
tags: []
---


So now we are going to train our classifier with our data which is series1_data.csv

we now need to decide what features to train our model with. 

Large number of feaures isn't an issue per-se. but more features can lead to overfitting and such to it is important to decide what features are actually important.

we have 32 channels of EEG data. obviously some of these channels are going to be irrelevant for our needs. to decide which ones we are going to do 'feature selection'

the one i have deciced to use is called linearSVC; its just trial and error to find a good one

```
svc = LinearSVC(C=0.1, penalty="l2", dual=False).fit(d['data'], d['targets'])
print svc.transform(d['data']).shape
```
once we call 'fit' on it this model learns which features are important and we can call on it to transform future data into the model we need.

we use 'pickle' to save this model onto disk to that it can be loaded and called later.

boom, from 32 it reduces it to 12 (or) 15 depending on the params i gave it.
i saved both these models for now. and shall organize them later.

but the thing with time series data is that you cant just look at data at each second.
you have to average them out.

so i opted for a moving window classifier of 100 points with a delta of 50 points.
this means i take 100 points starting from 0 and will do some time series and frequency series analysis of this data into one feature. and the next window i'll start from 50 and take the same lenth of 100. 
the decision target to train for is taken at the end of the 100 point window.

now we train our data. which is actually pretty simple

```
    clf = svm.SVC()
    print 'fitting'
    clf.fit(full_data['features'], full_data['targets'])
    joblib.dump(clf, MODEL_FILE) 
```

this will train and save out model down to a file; i got pretty good results with the first kernel so i dodnt bother doing any firther optimizations..

you mileage may vary..

although the cruz of my algorithm seemed to be how i incremented the window offset..
too less and it took freaking ages and created tons of training data..
too much and it starting missing some events as the window moved.
by looking at the event windows, i decided on a compromise of 5..

but for testing i always use 1 because i want every data point's prediction.

 