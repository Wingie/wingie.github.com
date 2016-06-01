---
layout: post
title: "Requirements for OpenCV Workshop at Droidcon2013"
description: "So the good news is that i've just been confirmed as a speaker for Droidcon 2013. Here are some notes for prospective attendees."
category: 
tags: []
---

If you are coming here from a google search investigating a particularly suspicious looking entry in the droidcon2013 speakers page, i've made this little note just for you!

So if you are guys who've been attending some of the past workshops that were done by the same team in bangalore. I think you know the guys who work really hard on making these events a reality. [I've spoken at one of them before.](https://github.com/Wingie/AndroidOpenCV_Presentation). It should give you an idea of what to to expect.

Hmm i just tried to make that presentation a link to this post via a github page and i just got this.

![y](/images/github.png "TODO: see if github issue fixes it self in 10 minutes.")

a quick look around and i find that the page can be accessed [here](http://wingie.github.io/AndroidOpenCV_Presentation/). maybe i should report this bug.. theres 5 minutes of my life that i'm not getting back

I'm planning (hopefully) for this to be a more-practical-than-theory session. And since actually setting up opencCv for Android is as simple as following instruction [hidden within the free interweb](http://opencv.org/platforms/android.html), i thought we could make this a sort of interactive session.

I'm assuming that a lot of developers who attend these sessions have some probably have unsolved problem haunting them from the past. Trust me, whatever the problem is.. openCV will have a solution for it. The library is not just about image processing examples anymore. I've started quite a few works of programming art (that are gathering dust somewhere in my dropbox) that use opencv. 

The trick is to treat everything as a signal. From text processing (a 1 Dimensional Signal), Sound (also 1D) and audio / video etc.. (you get the drift.) It has a hidden machine learning api that you can levergae from c/java or from any of your android application.

Now, i don't want to bore people so the session will be all excercise based. I'll be waiting 15 mins for you guys to solve the problem i've laid out. Like the first one will be to get both the openCV SDK and NDK hello world compiling.

If you want to play around with openCV, following the instructions given on a link on this page try and get to these files in your eclipse workspace.

![i_y_tech](/images/eclips1.png "Eclipse project window")

the error that you see (you might get that issue..) you just have to make sure,

1. that you've set up the path for the `NDK` *in the ADT preferences pane manually*. The NDK is downloaded seperately and the Android SDK plugin needs to know where it is.
2. That the build path in the project preferences is correctly names. It usually uses a PATH variable that eclipse needs. Eclipse apparently hasn't heard of the terminal's PATH variable. [use this SO as reference to fix](http://stackoverflow.com/questions/17639478/opencv-ndk-build-not-found)

So if you've got that all set up congrats. you are ready for the session.

Also, feel free to give me a shout out on twitter if you are running into any issues.


