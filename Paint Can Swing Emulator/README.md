# Paint Can Swing Emulator
[Inspired by these kinds of things]("https://www.instagram.com/p/B6qn2NyBdEd/?utm_source=ig_web_button_share_sheet")
## Iteration 01
Got the math wrong here, but I wasn't too sad with the result. Draws a paint dot every 5 frames with some randomness to the blotSize

<img src="PaintCanSwingEmulator_01/PaintCanSwingEmulator_01_2023-10-3_23-23-6.png" width=100>



## Iteration 02
Switched to using relative coordinates
```
pushMatrix();
translate(width/2, height/2);
rotate(globA);
popMatrix();
```
<img src="PaintCanSwingEmulator_02/PaintCanSwingEmulator_02_2023-10-3_23-49-3.png" width=100>



## Iteration 03
Found a good ratio of swing rate to global ratio to get less circular paint dots

<img src="PaintCanSwingEmulator_03.png" width=100>

