---
layout: post
title: "Working with Dates in OSX Cocoa"
description: "A N00bz Experiments with XCode. Part Three: NSDate, NSArrays and moar."
category: Mac 
tags: [tutorial,OSX,Xcode]
image: "/images/date.jpg"
---

So now, since i managed to get a status bar application working kinda working. The next stage in my evil plan was to get the current date object in cocoa.

This proved pretty simple, So i have a pretty neat function now that i can use to extract the Date and Time in the format i want.

Behold,
{% highlight html %}
+ (NSArray *) returnDate{
    NSDate *myDate = [NSDate date];

    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"EEEE, dd MMMM HH:mm"];
    NSString *myDateString = [dateFormatter stringFromDate:myDate];

    NSLog(@"%@",myDateString);
    NSArray *listItems = [myDateString componentsSeparatedByString:@" "];
    return listItems;
}
{% endhighlight %}

Now, notice the `+` sign on the function? That means this is not an instance method, but rather a class method. It's kind of like a static method in other languages. What it means is that i do not have to create an instance of the class to call this method. 

so assuming that this class in in a class called `DImain`. (for the purposes of our discussion) we can call it by:

{% highlight html %}
[DIman returnDate]
{% endhighlight %}

Now, I'm returning it as an array as i find that's the best way the rest of my code feels comfortable using the date. So that's why the return type is `(NSArray *)`.

Coming to the function itself,

`[NSDate date]` creates a date object and populates it with the current date & time. That's pretty cool as you dont have to explicity say anywhere to get the current date.
I'm storing that in an object myDate of type `NSDate *`. Again, those familiar with pointers in C should be at home here, because as far as i can tell, pointers behave in kind of the same way. (dunno how memory management is handled)

### The DateFormatter

Of course, having a date object is really not enough. You need a particular way to get that to a string. Enter `NSDateFormatter`.

  {% highlight html %}
  [dateFormatter setDateFormat:@"EEEE, dd MMMM HH:mm"]
  {% endhighlight %}

This allows you to set the format to your liking. The abover format returns `Sunday, 07 July 12:12`

The [Technical Documentation](https://developer.apple.com/library/ios/#documentation/cocoa/Conceptual/DataFormatting/Articles/dfDateFormatting10_4.html) isn't very clear on what the string format is. But [apparently UNIX formats work](http://unicode.org/reports/tr35/tr35-6.html#Date_Format_Patterns).

## Strings and Arrays

{% highlight html %}
NSString *myDateString = [dateFormatter stringFromDate:myDate];
NSArray *listItems = [myDateString componentsSeparatedByString:@" "];
{% endhighlight %}

These two are simply utility operations.
`stringFromDate:`is kinda self explanatory. 
`componentsSeparatedByString:` is like a javascript/python .split() function for objectiveC. It takes the string, makes an array out of all the pieces seperated by space and returns it as an `NSArray` object.

Cheers,




