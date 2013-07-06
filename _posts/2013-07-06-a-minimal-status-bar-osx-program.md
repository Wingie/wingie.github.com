---
layout: post
title: "A minimal status bar OSX App"
description: "A N00bz Experiments with XCode. Part Two: Alerts and Menus and stuff."
category: Mac 
tags: [tutorial,OSX,Xcode]
image: "/images/xcode2.png"
---
{% include JB/setup %}

So when you start building a Mac OSX app, there are a bunch of different types of apps that you can build. The one i'm going to build would be basically like a background process. It would have an icon, in the status bar that would act like a medium of control. This appeals to me because basically i want to have the app running all the time.

[This Chap](http://cocoatutorial.grapewave.com/2010/01/creating-a-status-bar-application/) provides a very good intro into how to get started with a status bar application so i guess you can look through [this post](https://github.com/lepture/StatusBarApp/blob/master/README.md) also. It would be more detailed in anycase.

## Look around you. What do you see?

1. I've got a generic class called AppDelegate set up. Which means i can see AppDelegate.h and AppDelegate.m
2. Also i see MainMenu.xib. This is basically the interface buider file.
3. a main.m where i'm assuming my application starts.

So my main.m looks like this

{% highlight html %}
#import <Cocoa/Cocoa.h>

int main(int argc, char *argv[])
{
    return NSApplicationMain(argc, (const char **)argv);
}
{% endhighlight %}

That looks like what i would suspect any self respecting C program would look like. Only, wait. My code would live in AppDelegate.m. How does my main.m code know that that's the class to load.
Turns out that doesn't matter at all, your interfaces are basically compiled into `nib` (NextInterfaceBuilder) files. thats like some sort of archive as far as i can tell. [Technical Details can be seen here](https://developer.apple.com/library/mac/#DOCUMENTATION/Cocoa/Conceptual/LoadingResources/CocoaNibs/CocoaNibs.html#//apple_ref/doc/uid/10000051i-CH4-SW19)

In your class, you listen for a notification that OSX sends to all your classes when it has finished unpacking the app from the nib archive. It is usually implemented with the applicationDidFinishLaunching: method.

{% highlight html %}
- (void)applicationDidFinishLaunching:(NSNotification *)aNotification
{
	... code here to set up your class ...
}
{% endhighlight %}

This is interesting, because it means you can have multiple classes with each of them having this function. so all of them will be immediately set up (some init code for class variables) as soon as the OS starts the App up. cool!

## Interface Designing : Status menu, get the hell up there.

<div class="postImage" style="width:1200px;max-width:100%;"><a href="https://www.evernote.com/shard/s147/sh/d09b141e-33f1-4232-b17a-caebe89a6277/34162d1d70fb938ebeabcde6ab9d00e6"><img src="https://www.evernote.com/shard/s147/sh/d09b141e-33f1-4232-b17a-caebe89a6277/34162d1d70fb938ebeabcde6ab9d00e6/deep/0/Screen%20Shot%202013-07-06%20at%203.58.24%20PM.png?width=1300" alt="Screen%20Shot%202013-07-06%20at%203.58.24%20PM" /></a><br /></div>

So to create an actual menu, you have to go to the object library, find the `Menu` (NOT MenuItem). and drag and drop it onto the InterfaceDesigner space.

Now the thing is, you need to associate this menu with the class. So you need a variable on the AppDelegate class that you can manipulate and control this menu.

The easiest way is to find the Menu object in that central bar between the interfaceDesigner grid and the project list. That icon is called the placeholder for the menu object.
You have to enable the `Assistant Editor`. (top left corner, check tooltips. looks kind of like a butler suit.) Once the assistant editor is active, get it to show your class's .h file. (Appdelegate.h)
Then go over to the Menu PlaceHolder icon, drag and drop onto yout class definition in Appdelegate.h. The tooltip that shows would be insert outlet. Give it some name. mine was particularly unoriginal.

{% highlight html %}
@property (weak) IBOutlet NSMenu *Menu;
{% endhighlight %}

Now, you need to add an NSStatusItem class variable. This is used to set up and attach the class variable onto the header.
This is done on the class definition like:

{% highlight html %}
@interface AppDelegate : NSObject <NSApplicationDelegate>{
    NSStatusItem * statusItem;
}
{% endhighlight %}

finally, in the startup function, then following code actually connects the status_bar app to show the menu up.

{% highlight html %}
- (void)applicationDidFinishLaunching:(NSNotification *)aNotification
{
    statusItem = [[NSStatusBar systemStatusBar] statusItemWithLength:NSVariableStatusItemLength];
    [statusItem setMenu:self.Menu];
    [statusItem setTitle:@"*"];
    [statusItem setHighlightMode:YES];   
}
{% endhighlight %}

## WTF? I cant click anything?

Now if you have been actually following this blog post diligently and actually ran the code at the previous state, (well, some of you might..) you would have noticed something very interesting.
None of the damn buttons are clickable!
If you think about it, it makes perfect sense. because, they havent been really associated with anything now have they?

Associating a click event with a function is the same procedure as setting up an outlet. instead you set up an action.
Make sure the Assistant editor is showing the .h file, click on the menu item, drag onto the editor and release.
Now in the dialog box that you see, choose Action and give it a name. say you gave it `onclk`. (A bad name, but it'll do)

now, in AppDelegate.h, you should see:

{% highlight html %}
- (IBAction)onclk:(id)sender;
{% endhighlight %}

and in AppDelegate.m,

{% highlight html %}
- (IBAction)onclk:(id)sender {
}
{% endhighlight %}

One is the function decaration, and the other is the implementation. lets create an alert box there.

{% highlight html %}
- (IBAction)onclk:(id)sender {
	NSAlert *alert = [[NSAlert alloc] init];
	[alert setMessageText:@"Hi there."];
	[alert runModal];
}
{% endhighlight %}

Run the code, and you should see this magnificent piece of work. if you are too lazy, [Get the code here](https://github.com/Wingie/DeskImage/tree/status_bar_setup) to run the app exactly at this stage from Xcode.

## To summarize

1. ctr-click and drag creates connection between UI elemnt in the interface designer and the code.
2. Outlets define variables, and actions are used to connect event (like onClick).
3. google mailing lists to find out more about osx wierdness.

and of course, let me know if you have any queries or stuff.
