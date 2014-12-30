---
layout: post
title: "My New Android Thingy: RadioIndya"
description: "My First play store app is here! "
category: android
tags: []
image: "/images/radioindya.png"
---


You would be forgiven for missing about the debut of my Android App on the app store. 

[It's called RadioIndya](https://play.google.com/store/apps/details?id=com.wingie.myradio)

{% img figure /images/app_1.png 300px 300px %}

I do reserve the right to change the name sometime.

I learnt quite a bit of android doing it.

An interesting feature that i built into it is a floating media player.

Ooo right? It seemed kinda obvious to me. We have a platform at www.radioindya.com for audio content creators who want a private space for their audio content. 
the app is to supplement our offerings onto the mobile environment also.



Remember facebook messenger's chathead feature? those annoying bobbles of your friends visages that used to stay at the edge of your screen somewhere and let you do multitasking thingies with your smartphone whilst chatting with friends.

since my users would be primarily consuming audio content, i thought the chathead was a neat idea to put a player onto.

How did i do it? Turns out there are sample projects on github that can help you out there.

But in a nutshell, you have to make a service. and in that service you have to bind yourself to android's window manager and then you can insert a view into the screen and keep it there.

i guess this is how Qslide Apps by LG work. There are quite a few apps that make use of this functionality.

{% img figure /images/app_2.png 300px 300px %}


it all starts with me extending a Service class,

{% highlight html %}
public class FloatingPlayerService extends Service {
{% endhighlight %}

`WindowManager` let's me access the actual window of the android device. 
`CircularNetworkImageView` let's me give just a url to it and it will download, queue and cache the image for me. (i hope) [it's an interesting gist](https://gist.github.com/bkurzius/99c945bd1bdcf6af8f99) though.
`bobble_close` and `bobble_close` are two areas on the screen that i want to use as controls.
eg, if you drag the main bobble onto the close icon, the media player closes.

{% highlight html %}
private WindowManager mWindowManager;
private CircularNetworkImageView main_player;
private ImageView bobble_close,bobble_pause;
static MediaPlayer mediaPlayer;
{% endhighlight %}

This set's up the two variables to keep a track of the content in the window.

{% highlight html %}
mWindowManager = (WindowManager) getSystemService(WINDOW_SERVICE);
mRootLayout = (RelativeLayout) LayoutInflater.from(this).inflate(R.layout.service_player, null);
{% endhighlight %}

we need to manually create the params used to direct the position of our content.

{% highlight html %}
params = new WindowManager.LayoutParams(
                WindowManager.LayoutParams.TYPE_PHONE,
                WindowManager.LayoutParams.FLAG_NOT_FOCUSABLE,
                PixelFormat.TRANSLUCENT);

params.gravity = Gravity.TOP | Gravity.LEFT;
params.x = (screenWidth);
params.y = (0);
params.width = 230;
params.height = 230;
{% endhighlight %}



lastly, we can set up a touch listener and add this view to the window manager.

{% highlight html %}
main_player.setOnTouchListener(new TrayTouchListener());
mWindowManager.addView(mRootLayout, params);
{% endhighlight %}

now the next challenge would be to let this bobble be dragged around. 
we use the below code to intercept the 4 events we care about and handle them in `dragTray()`

{% highlight html %}
 // Listens to the touch events on the tray.
    private class TrayTouchListener implements View.OnTouchListener {
        @Override
        public boolean onTouch(View v, MotionEvent event) {
            final int action = event.getActionMasked();

            switch (action) {
                case MotionEvent.ACTION_DOWN:
                case MotionEvent.ACTION_MOVE:
                case MotionEvent.ACTION_UP:
                case MotionEvent.ACTION_CANCEL:
                    // Filter and redirect the events to dragTray()
                    dragTray(action, (int) event.getRawX(), (int) event.getRawY());
                    break;
{% endhighlight %}

anytime you want to update the view inside it, (position, size etc..) you have to call `updateViewLayout` after modifying the `params` object.

you'll have to call this manually after doing any updates to params. in order to force the view to update in the window manager.

{% highlight html %}
mWindowManager.updateViewLayout(mRootLayout, params);
{% endhighlight %}

i added in two `touch` areas that can be used for pausing/playing and stopping the floating player.
Also a progress bar to see music progress was also done.

{% img figure /images/app_3.png 300px 300px %}

{% include JB/setup %}