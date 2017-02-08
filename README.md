# AS3 Parallaxbox Class
a simple as3 parallax box class to help you develop cool parallax sites. Did I mention parallax? 

There's thousands of sites out there, where you can notice a certain bitmap parallax effect, elements in a image that moves differently, responding to mouse movements, with different speeds. Just like this, but imagine it stagewide.

Now you can set your parallax using the ParallaxBox class. 

Simply:

Create your parallax movieclips, and put them on the stage.
On your timeline, write this (or similar, adjusted to your needs)

````actionscript3
  pc.addItem("level1", 200, 30, false);
  pc.addItem("level2", 120, 10, false);
  pc.addItem("level3", 70, 2, false);pc.xrate = 6;
  pc.yrate = 8;pc.mode = ParallaxBox.BOTH;
  pc.blurred = true;pc.start();
````

At last, test!
Check, play and steal free!

#WARNING:#
Guess what? High use of this class, in different instances, can be CPU-intensive.

Be careful, but have fun!
