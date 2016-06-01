---
layout: post
title: "A First Look @ React Native on Android"
description: "An Analysis of the New React Native Library.
			Native Code bridging and more experiments to come.
"
category: EngineeringTales
tags: [ReactNative, Android]
image: "/images/react.png"
---


So I started programming react-native-android today. Any new programming languages always get my attention and since i wanted to build a new app for [my pet project](http://wingztv.com). 

Starting with the react stuff was deceptively simple, all I had to do was follow the Facebook tutorial and guide. About couple of hours later I had a sample of the react app running on my phone.

There was a little wierdness and clunkiness with getting used to this as i'm not really a front end programmer and had like no experience with front end react.
It's so wierd to be returning HTML templates without having to put a quotation mark aroung them. seriously something inside me cringes.

Anyway, other than a couple of bugs where i had to delete my `.node_modules` folder and run `npm install` once and a little struggling before i realise to run this magic command to fix it. (which was convieniently told to me via the logcat..) 

```
    adb reverse tcp:8081 tcp:8081
```

its seiously my post painless hello world setup yet. Things are looking good.

# The Good 

* Simple View Declaration

```
// return this view...
renderLoadingView: function() {
    return (
      <View style={styles.container}>
        <Text>
          Loading movies...
        </Text>
      </View>
    );
  },
```

It's so simple it should be illegal. Now of course how do we add more complicated styling to this?

```
// and style it here...
	container: {
    flex: 1,
    flexDirection: 'row',
    justifyContent: 'center',
    alignItems: 'center',
    backgroundColor: '#F5FCFF',
  },
```

Freaking css on android. Eff you AndroidViewManagerLayoutParameters. 


* Seriously Painless Way of managing Native Applications

i did not belive that it worked on the first go.
Seriously. I shit you not. It worked on the first go.

let me take a breath here. So React Native for Android doesnt support throwing intents in android. Thats a pretty huge thing the fb chaps missed out on for some reason. (maybe to make the community sing for their supper?)

so anyway, after hanging out on slack a bit and reading the react-native github sources for a little bit, i felt confident enough that to do this.

i'll even run you by the steps if you dont believe me.

A) Add the two classes next to your android activity, you can find [mine over here](https://github.com/chaimedia/chai-android/tree/master/android/app/src/main/java/com/awesomeproject)
one is basically a bridger class and another contains the function that you decorate to let react know you want to call it via javascript.
done and done -> added just a Log.V('x','y') to see what happpens.

B) Add this line into the application bootstrapping section. you cant miss it, its in the mainactivity.java

```
.addPackage(new RNIntent())
```

since my "new" module is imaginatively called RNIntent.

C) In Javascript, just use it and call that java method like a boss.

and it worked. Like wow. From a guy who used to swear constantly while developing for android.. that's kind of an achievement. 3 hours and not one swear words about the sister of the guy who developed the library i'm trying to get working.

Now granted, it's a lot less painfull doing android dev now with all these fancy gradle tools you kids have these days.. But i'm still impressed. 
I've only just scratched the surface and right now, i would totally invest the time into learning this wierd react methodology of thinking.

but first, gotta immerse myself in React source code. 

# The Bad

Umm, CSS? for layouting? yeah like that worked so well on mobile. I shouldnt complain not having to do the wierd layouting thing anymore.. but seriously what does this mean to my custom class holding a scrollview and a recycler view over a 0 width grid layout inside a linear layout.
cuhmon do i just have to throw all that code away? i sweated blood to make them!

# The Ugly

You have to write shit for iOS and Android if Facebook hasn't done already.
Let me repeat this.
If FB no likey the feature you want, you have to write it yourself.
which is ugly cuz all those custom overriden classes that we all have hiding inside the cruft is going to rear it's ugly head now. They all have to be written as React Components.

Want a circular image view, Eff off and write your own component.
Want a surface view to show a live camera feed. Eff off and write your own component.
Want a cardview...

well you get the gist.

