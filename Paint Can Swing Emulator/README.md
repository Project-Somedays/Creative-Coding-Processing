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

## Iteration 04

Set it to draw an ellipse every frame

<img src="PaintCanSwingEmulator_04.png" width=100>

## Iteration 05

Playing with transparency and also using a gaussian random number for the size of the blot

<img src="PaintCanSwingEmulator_05.png" width=100>

## Iteration 05_01

Introduce epicycles

<img src="PaintCanSwingEmulator_05_01.png" width=100>

## Iteration 06

Perlin noise for the size of the blots and increased epicycle rotation

<img src="PaintCanSwingEmulator_06/PaintCanSwingEmulator_06_2023-10-7_10-40-36_eRate0.03.png" width=100>

## Iteration 07

Perlin noise for the rotation of the epicycle

<img src="PaintCanSwingEmulator_07/PaintCanSwingEmulator_07_2023-10-8_14-21-29_eRate0.002.png" width=100>

## Iteration 08

A naive attempt at a physics simulation - Vector addition too imprecise? It either reels in or spools out. Feel free to fork and fix if you please =)

<img src="PaintCanSwingEmulator_08.png" width=100>

## Iteration 08_01

Borrowed from Daniel Shiffman. More work required on the initial velocity, but I think it's a pretty interseting place to start.

<img src="PaintCanSwingEmulator_08_01.png" height=100>
