// auto thumbnail generation script: https://timrodenbroeker.de/courses/sketching-with-code/thumbnails
// Reverse engineering this: https://openprocessing.org/sketch/2049149
// This version involves 2D perlin noise to get a perfect loop
String sketchname = getClass().getName();
ArrayList<Shape> shapes;
float yOffset, aOffset, sepOffset, dOffset; //perlin noise offsets
float hMin, hMax, sepMin, sepMax, yMax, yMin, wMin, wMax;
// adjustment parameters
float currentY, currentD, currentSep, currentA; // to load into each shape
float globA = 0;
float[] yField;
float[] sepField;
float[] hField;
float[] wField;
float[] aField;

int ySpan;
int currentIx;
// colour sets
//color[] colours = {#26547c, #ef476f, #ffd166};
//color[] colours = {#9381ff, #b8b8ff, #f8f7ff};
//color[] colours = {#565554, #2e86ab, #f6f5ae, #f5f749, #f24236};
color[] colours = {color(255,0,0), color(0,0,255)};
int loopLength;
boolean isLooping = false;
float spreadMultiplier = 1.5;


void setup() {
  size(1000, 500, P2D);
  stroke(0, 50);
  //noStroke();
  hMax = height/5;
  hMin = height/25;
  wMax = height/25;
  wMin = height/50;
  
  sepMin = height/50;
  sepMax = height/5;
  yMax = 0.75*height;
  yMin = 0.25*height;
  ySpan = int(yMax - yMin);
  loopLength = int(width + hMax + sepMax);


  shapes = new ArrayList<Shape>();
  background(0);
  yField = initField(loopLength, 0.25*height, 0.75*height);
  hField = initField(loopLength, hMin, hMax);
  wField = initField(loopLength, wMin, wMax);
  sepField = initField(loopLength, sepMin, sepMax);
  aField = initField(loopLength, -TWO_PI, TWO_PI);
  rectMode(CENTER);
  
  fill(255);
  strokeWeight(1);
}

void draw() {
  background(0);

  if (frameCount%1 == 0) {
    //shapes.add(new Shape(width + dMax + sepMax, yField[currentIx], dField[currentIx], sepField[currentIx], aField[currentIx]));
    shapes.add(new Shape(width*0.9, yField[currentIx], wField[currentIx], hField[currentIx], sepField[currentIx], aField[currentIx]));

    currentIx = (currentIx + 1)%loopLength; // loops
  }

  for (Shape s : shapes) {
    s.update();
    s.show();
  }

  // cleaning up
  for (int i = shapes.size() - 1; i >= 0; i--) {
    if (shapes.get(i).isOffScreen) {
      shapes.remove(i);
    }
  }


  if (frameCount == 1.1*width) {
    saveFrame("../" +sketchname + ".png");
  }


  globA += 0.01;
}

float[] initField(int vals, float min, float max) {
  float yOffstart = random(10000);
  float xOffstart = random(10000);
  float[] field = new float[vals];
  for (int i = 0; i < vals; i++) {

    float sampleA = i*TWO_PI/vals;
    float sampleX = spreadMultiplier*cos(sampleA) + 1; // make it
    float sampleY = spreadMultiplier*sin(sampleA) + 1; // make it always positive
    field[i] = map(noise(xOffstart + sampleX, yOffstart + sampleY), 0, 1, min, max);
  }
  return field;
}

void keyPressed() {
  if (keyCode == ' ') {
    saveFrame(sketchname + "_" + year()+"-"+month()+"-"+day()+"_"+hour()+"-"+minute()+"-"+second() + ".png");
  }
}
