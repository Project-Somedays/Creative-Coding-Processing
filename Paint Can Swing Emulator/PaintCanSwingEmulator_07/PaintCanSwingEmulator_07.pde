/*
In this version, we introduce epicycles and increase the swing radius to disappear off the screen
Epicycle now rotating with perlin noise
Blotsize: perlin noise
 */

// auto thumbnail generation script: https://timrodenbroeker.de/courses/sketching-with-code/thumbnails/
String sketchname = getClass().getName();
float globA = random(TWO_PI);
float swingPos = 0;
float ePos;
float swingRate = 0.017;
float globARate = 0.002;
float eRate = 0.002;
float blotOffset = 0;
float blotSmoothness = 0.02;
float rX, rY, rE;
// color[] colours = {#1f2041, #4b3f72, #417b5a, #d0ceba, #e9d2c0};
color[] colours = {#5f0f40, #9a031e, #fb8b24, #e36414, #0f4c5c};
//color[] colours = {#4D5f0f40, #4D9a031e, #4Dfb8b24, #4De36414, #4D0f4c5c};

float blotSize = 20;
void setup() {
  size(1000, 1000);
  background(0);
  fill(255);
  noStroke();
  background(0);
  rX = width/8;
  rY = 0.7*height;
  rE = width/8;
}

void draw() {
  blotSize = 5 + noise(blotOffset)*20;
  pushMatrix();
  translate(width/2, height/2);
  rotate(globA);
  float x = rX*cos(swingPos+HALF_PI);
  float y = rY*sin(swingPos+HALF_PI);

  // for each colour, draw a line of paint
  for (int i = 0; i < colours.length; i++) {
    fill(colours[i]);
    float a = i*TWO_PI/colours.length + TWO_PI*noise(ePos);
    ellipse(x + rE*cos(a), y + rE*sin(a), blotSize, blotSize);
  }

  popMatrix();
  rX *= 0.9999;
  rY *= 0.9999;

  swingPos += swingRate;
  ePos += eRate;
  globA += globARate;
  blotOffset += blotSmoothness;
  if (frameCount ==  600) {
    saveFrame("../" + sketchname + ".png");
  }
}

void keyPressed() {
  if (keyCode == ' ') {
    noLoop();
    saveFrame(sketchname + "_" + year()+"-"+month()+"-"+day()+"_"+hour()+"-"+minute()+"-"+second() + "_eRate" + str(eRate) +".png");
  }
}
