---
layout: post
title: "Beginning Firmware Development on the Pebble"
description: "My reference for the stuff that i am doing on the pebble community firmware"
category: EngineeringTales
tags: [Pebble,Firmware]
---

So the news has broken, Pebble has gone bankrupt and the HR issues related with my brand new fucking Pebble 2 HR will never have a software fix.
But of course i love my pebble so this is the beginning of my journey to understand the pebble firmware and do my part for the community.

```
DISCLAIMER: I DO NOT KNOW ANYTHING ABOUT FIRMWARE DEVELOPMENT!!
```
This is interesting as if you are a beginner, then yeah you might find some information here that i learnt along the way.

so the first thing i did was set up QEMU (which is like a hardware emulator for the pebble)


Once i cloned [pebble/qemu](https://github.com/pebble/qemu), following the instructions worked until the "Waf" step. Of course, you have to provide a firmware to the emulator which you can get from [qemu-tintin-images](https://github.com/pebble/qemu-tintin-images)
and these managed to sucessfully boot the emulator.
Waf requires the build scripts that the pebble team used to build their firmware, and now since fitbit isn't sharing any of that cake, we gotta bake our own.

but of course, the main aim of this is to get the community to write our own firmware of course. Which we will do.

Before one can begin, one needs something called a toolchain. A toolchain is basically exactly like it sounds, a chain of tools that your computer can use to build source code for another hardware device.

Again, you should not face much difficulty to follow the instructions over here
[pebble/arm-eabi-toolchain](https://github.com/pebble/arm-eabi-toolchain)

the one thing to remember is to use GCC~4.8 as on ubuntu as having >5 failed for me, but your mileage may vary.

one you've completed the step do keep a note of the location where the toolchain got installed. 

this is the beginning of the community firmware that is being worked on the pebble. [pebble-dev/ufq](https://github.com/pebble-dev/ufw)

again it's pretty simple to do, just edit the Makefile to put the path to the location of the toolchain that you've managed to sucessfully compile.
and then run

```
make qemu
```

this should let that itsy bitsy bit of code working on the emulator. dont do shit on your pebble with this though, you might just brick it. 