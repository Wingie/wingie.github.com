---
layout: post
title: "Coding ObjectiveC Apps on a Mac"
description: "A N00bz Experiments with XCode. Part One - Objective C, the language of the Mac."
category: Mac
tags: []
---
{% include JB/setup %}

So i've recently got my hands on a new macbook pro, and barring some minor flaws, it's been a serious pleasure to use. 
I've loved the awesome feel of the keyboard, and the mettalic finish of the trackpad makes even swiping pages on a pdf pretty awesome to use.
<div style="float: left" markdown="1">
![alt text](/images/griffin-meme.jpg "What Grinds my Gears.")
</div>

But yeah, maybe i'm cheap but i seriously hate the fact that a lot of cool apps on the app store have to be payed for. Not to bash any apple developers, i guess they're just trying to make some cash on some of the apps that they make suring their free time. 
But I come from an ubuntu background, and by far the only reason ubuntu is not already installed on my MBP is that its a company laptop and i cant afford any downtime, just because i screwed some random crap up.

So then I decided to find out just how hard this objective C programming thing would turn out to be. Turns out it wasn't that hard. But there was an impressive amount of googling and struggling so i thought i'd blog about some of the stuff at least.

So I guess the first thing I needed when starting developing was XCode. It was a humongous beast to download. but still smaller than Visual Studio so i guess that's a +1 for Apple.

It's got the standard features that we've come to expect from IDE's these days. (Although since my primary IDE has been sublime, i have found myself using some of those keyboard shortcuts and cursing the gods of yore repeatedly when they fail.) 

The one feature that i thought was awesome is the "Assistant Editor." If you set it to show counterparts, then if you are editing the .m file it automatically shows the class's .h file in a split window, so you can add functions names, variables and stuff pretty fast. If you have multiple files, the view in the split window changes automatically so you are always seeing the appropriate file. That is a real time saver.

## What the effing NS are you talking about?

So the wierdest thing that i found was that all classes (have to?) start with a prefix. Apple uses NS. for the why you can [take a look at this discussion on SO](http://stackoverflow.com/questions/473758/what-does-the-ns-prefix-mean);
Basically Apple is saying that `All class names in the whole wild universe` must be unique (at least the ones you want to use), none of that crappy namepsacing other new-fangled languages seem to have. If you use another person's library, you're f@#$ked if your class names clash. [This site](http://cocoadev.com/ChooseYourOwnPrefix) seems to have compiled a list of prefixes. 

`I decided to use WWS, because the two letter rule is retartded that's why.` 
(just kidding, i use WS. Never Ever anger the Apple.)

## SMS service for native OSX applications

So Apple (claims) they have an implementation called messaging. And it is used to call functions. So you don't `call` an object's method, you `send a message` to an object to tell it to execute that method. I guess this is definitive proof that Apple is part of an underground tech mafia.

anyway,

{% highlight html %}
id str = [NSString string];		
NSNumber* value = [[NSNumber alloc] initWithFloat:1.0];	
{% endhighlight %}

First line,

1. Here `id` is a type that is the same as `void *`. 
2. `[NSString string]` means that string is a ClassMethod (static for you C folks) on the `NSString` object. Basically it returns a tring object.
3. If you were programming in another language, NSString.string() would be the equivalent. But this is how apple rolls.

Second Line,

1. See the nested structure of the functions, sorry methods calling syntax? I guess one advantage would be that its a lot easier to read. 
2. So the first `[NSNumber alloc]` returns an NSNumber instance allocated in memory. Now we can tell that object to execute it's `initWithFloat` method with arguments 1.0. `[returnAnonObj initWithFloat:1.0]`
3. That returns a NSNumber object with value 1.0. This kinda makes life easier, you tend to be able to get rid of a lot of temp variable names. I like that because i hate thinking about what names to use for local vars.

## debugging messages.

{% highlight html %}
NSLog ( @"The current date and time is: %@", [NSDate date] );
{% endhighlight %}

That's straight out of a google search so i wont elaboarte on it.

## Learning Obj-C / Cocoa

[this is what i usually refer whenever i get confused about random stuff in objective C](http://cocoadevcentral.com/d/learn_objectivec/)

So when developing anything other than a command line app, When you need access to OS level features, you would need a framework. Windows has MFC, you can use Qt (amongst others) on linux.

For Apple it's cocoa. [And you can learn more about it here](http://cocoadevcentral.com/d/learn_cocoa/).

## Have fun.

I will be posting more about whatever i learnt from my experiences here. So stay tuned.

Cheers,




