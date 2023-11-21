// auto thumbnail generation script: https://timrodenbroeker.de/courses/sketching-with-code/thumbnails
// Reverse engineering this: https://openprocessing.org/sketch/2036461
String sketchname = getClass().getName();
ArrayList<Shape> shapes;
float yOffset, aOffset, sepOffset, dOffset; //perlin noise offsets
float dMin, dMax, sepMin, sepMax; // adjustment parameters
float currentY, currentD, currentSep, currentA; // to load into each shape
float globA = 0;

// colour sets
//color[] colours = {#26547c, #ef476f, #ffd166};
//color[] colours = {#9381ff, #b8b8ff, #f8f7ff};
color[] colours = {#565554, #2e86ab, #f6f5ae, #f5f749, #f24236};

boolean isLooping = false;


void setup() {
  size(1080, 480, P2D);
  yOffset = random(100000);
  aOffset = random(100000);
  sepOffset = random(100000);
  dOffset = random(1000000);
  stroke(0, 50);
  dMax = height/10;
  dMin = height/20;
  sepMin = 2*height/20;
  sepMax = 2*height/10;
  shapes = new ArrayList<Shape>();
  background(0);
  
}

void draw() {
  background(0);

  currentY = map(noise(yOffset), 0, 1, 0.25*height, 0.75*height);
  currentD = map(noise(dOffset), 0, 1, dMin, dMax);
  currentSep = map(noise(sepOffset), 0, 1, sepMin, sepMax);
  currentA = map(noise(aOffset), 0, 1, 0, 3*TWO_PI);

  if (frameCount%2 == 0) {
    shapes.add(new Shape(0.8*width, currentY, currentD, currentSep, currentA));
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


  if (frameCount == 500) {
    saveFrame("../" +sketchname + ".png");
  }

  yOffset += 0.005;
  aOffset += 0.01;
  sepOffset += 0.01;
  dOffset += 0.01;
  globA += 0.01;
}

void keyPressed() {
  if (keyCode == ' ') {
    if (isLooping) {
      saveFrame(sketchname + "_" + year()+"-"+month()+"-"+day()+"_"+hour()+"-"+minute()+"-"+second() + ".png");
      noLoop();
    } else
      noLoop();
  }
}
