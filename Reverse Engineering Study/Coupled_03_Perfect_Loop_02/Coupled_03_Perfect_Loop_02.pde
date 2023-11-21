// auto thumbnail generation script: https://timrodenbroeker.de/courses/sketching-with-code/thumbnails
// Reverse engineering this: https://openprocessing.org/sketch/2036461
// This version involves 2D perlin noise to get a perfect loop
String sketchname = getClass().getName();
ArrayList<Shape> shapes;
float yOffset, aOffset, sepOffset, dOffset; //perlin noise offsets
float dMin, dMax, sepMin, sepMax, yMax, yMin;
; // adjustment parameters
float currentY, currentD, currentSep, currentA; // to load into each shape
float globA = 0;
float[] yField;
float[] sepField;
float[] dField;
float[] aField;
int ySpan;
int currentIx;
// colour sets
//color[] colours = {#26547c, #ef476f, #ffd166};
//color[] colours = {#9381ff, #b8b8ff, #f8f7ff};
color[] colours = {#565554, #2e86ab, #f6f5ae, #f5f749, #f24236};
int loopLength;
boolean isLooping = false;


void setup() {
  size(1080, 480, P2D);
  stroke(0, 50);
  //noStroke();
  dMax = height/10;
  dMin = height/20;
  sepMin = 2*height/20;
  sepMax = 2*height/10;
  yMax = 0.75*height;
  yMin = 0.25*height;
  ySpan = int(yMax - yMin);
  loopLength = int(width + dMax + sepMax);


  shapes = new ArrayList<Shape>();
  background(0);
  yField = initField(loopLength, 0.25*height, 0.75*height);
  dField = initField(loopLength, dMin, dMax);
  sepField = initField(loopLength, sepMin, sepMax);
  aField = initField(loopLength, 0, 3*TWO_PI);
}

void draw() {
  background(0);

  if (frameCount%1 == 0) {
    shapes.add(new Shape(width + dMax + sepMax, yField[currentIx], dField[currentIx], sepField[currentIx], aField[currentIx]));
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
  float yOffstart = random(1000000);
  float xOffstart = random(1000000);
  float[] field = new float[vals];
  for (int i = 0; i < vals; i++) {

    float sampleA = i*TWO_PI/vals;
    float sampleX = cos(sampleA) + 1; // make it
    float sampleY = 1.05*sin(sampleA); // make it always positive
    field[i] = map(noise(xOffstart + sampleX, yOffstart + sampleY), 0, 1, min, max);
  }
  return field;
}

void keyPressed() {
  if (keyCode == ' ') {
    saveFrame(sketchname + "_" + year()+"-"+month()+"-"+day()+"_"+hour()+"-"+minute()+"-"+second() + ".png");
  }
}
