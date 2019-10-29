# ViewExperiments

## Rubber band effect?
I tried out this just for fun, and then I realized I need to add some words on how does this work. Here it goes.

<p align="center">
 <img src="https://user-images.githubusercontent.com/18760280/67090158-599fe780-f1e4-11e9-9f61-12dca1f6ee2e.gif">
 </p>

### What is a mask? What does that do?
If you create a mask and put it on the view, the masked area only is visible. Why does this fact matter? I will create a shapelayer of the size of the rectangle, only one of the edge is a curved path. The masked view will look like that.
<p align="center">
 <img src="https://user-images.githubusercontent.com/18760280/67783136-247d7a00-faad-11e9-9ed0-2853697e8734.png">
 </p>

What if that shape layer is updated in response to the gesture in real time? What does that look like?
It will create an effect that acts as if a rubber band is stretched and back.

### What is a curve made of? How does the given pan gesture data lead to drawing the curve?
What do I need to know to draw up the curve programmatically?
<p align="center">
 <img src="https://user-images.githubusercontent.com/18760280/67783135-23e4e380-faad-11e9-8c7f-97b8b70e759c.png">
 </p>

A curve is made of startpoint, endpoint, controlpoint.With these three parameters, you can create a UIBezierPath instance. For implementation purpose, I defined control value(normalized value), curve size to interpret the controlpoint.
Also, I defined curve direction. By this I mean the direction that the curve forms from the view frame.
<p align="center">
 <img src="https://user-images.githubusercontent.com/18760280/67783134-23e4e380-faad-11e9-94cd-5cb9a5b80db5.png">
 </p>

There’s gotta be a way to know which direction the user is panning off from the view so that the curve parameters(curve size, control value) are read correctly.
There’s a long way to go from the pan gesture recognition to updating the mask.
Each step and task that takes place in it is individual and independent to each other so that each task is taken for being fully tested programmatically.
In a simpler form, it takes these three steps and I can accomplish the rubber band stretch effect.
<p align="center">
 <img src="https://user-images.githubusercontent.com/18760280/67783133-23e4e380-faad-11e9-9b79-661b8bc3fe55.png">
 </p>

### How do I accomplish the snapping back animation when the pan gesture ends?
By constantly redrawing the path following the dragged gesture point; renewing the mask; I can accomplish the rubber band effect. And, as I drop the tap off from the display, I want it the curve to snap back with a nice spring animation. How do I do that?
Given that spring animation doesn’t support path-based animation, I need to create a bunch of path and make a sort of a key frame animation so that the curve looks like it’s springing back to where it was before the pan gesture had begun.
The control point overshoots the mid point of the startpoint and endpoint with smaller size. It overshoots over and over until it is halted.
<p align="center">
 <img src="https://user-images.githubusercontent.com/18760280/67783132-234c4d00-faad-11e9-970f-e2ba141228eb.png">
 </p>

For example, it starts with control point c1. It overshoots to c2, and then c3, c4, c5. I created (c1,c2,c3,c4,c5) from the given c1.
And, given (c1,c2,c3,c4,c5), I created five paths, and then five animations. I chained them together so that it makes one big animation.
The result is the above gjf as you see.
