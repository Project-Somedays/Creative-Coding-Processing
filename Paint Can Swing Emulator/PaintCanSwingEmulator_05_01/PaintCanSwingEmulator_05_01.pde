/*
In this version, we introduce epicycles and increase the swing radius to disappear off the screen
Constant rotation of the epicycle
Blotsize 5 + 10*randomGaussian()
Epicycle: Sin with a period of 3
 */

// auto thumbnail generation script: https://timrodenbroeker.de/courses/sketching-with-code/thumbnails/
String sketchname = getClass().getName();
float globA = random(TWO_PI);
float swingPos = 0;
float ePos;
float swingRate = 0.017;
float globARate = 0.001;
float eRate = 0.02;
float rX, rY, rE;
// color[] colours = {#1f2041, #4b3f72, #417b5a, #d0ceba, #e9d2c0};
//color[] colours = {#5f0f40, #9a031e, #fb8b24, #e36414, #0f4c5c};
//color[] colours = {#4D5f0f40, #4D9a031e, #4Dfb8b24, #4De36414, #4D0f4c5c};
//color[] colours = {#d9ed92, #b5e48c, #99d98c, #76c893, #52b69a, #34a0a4, #168aad, #1a759f, #1e6091, #184e77};
color[] colours = {#80d9ed92, #80b5e48c, #8099d98c, #8076c893, #8052b69a, #8034a0a4, #80168aad, #801a759f, #801e6091, #80184e77};

float blotSize = 20;
void setup() {
  size(1000, 1000);
  //background(0);
  //background(255);
  background(153, 142, 116);
  fill(255);
  noStroke();
  rX = width/8;
  rY = 0.7*height;
  rE = width/8;
}

void draw() {
  blotSize = 2 + abs(randomGaussian()*5);
  pushMatrix();
  translate(width/2, height/2);
  rotate(globA);
  float x = rX*cos(swingPos+HALF_PI);
  float y = rY*sin(swingPos+HALF_PI);

  // for each colour, draw a line of paint
  for (int i = 0; i < colours.length; i++) {
    fill(colours[i]);
    float a = i*TWO_PI/colours.length + sin(ePos/3)*TWO_PI;
    ellipse(x + rE*cos(a), y + rE*sin(a), blotSize, blotSize);
  }

  popMatrix();
  rX *= 0.9999;
  rY *= 0.9999;

  swingPos += swingRate;
  ePos += eRate;
  globA += globARate;
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
