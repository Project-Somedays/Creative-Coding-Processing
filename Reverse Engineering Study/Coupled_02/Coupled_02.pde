// auto thumbnail generation script: https://timrodenbroeker.de/courses/sketching-with-code/thumbnails
// Reverse engineering this: https://openprocessing.org/sketch/2036461
String sketchname = getClass().getName();
ArrayList<Shape> shapes;
float y, a;
float yOffset, aOffset, sepOffset, dOffset;
float dMin,dMax;
float sep;
Shape test;
float currentY = 0;
float currentD;
float currentSep;
float sepMin, sepMax;
float currentA;
float rOffset;
//color[] colours = {#26547c, #ef476f, #ffd166};
color[] colours = {#9381ff, #b8b8ff, #f8f7ff};


void setup(){
    size(1080,720);
    yOffset = random(100000);
    aOffset = random(100000);
    sepOffset = random(100000);
    rOffset = random(1000000);
    stroke(0,50);
    dMax = height/10;
    dMin = height/20;
    sepMin = height/10;
    sepMax = height/5;
    currentY = map(noise(yOffset), 0, 1, 0, height);
    currentD = map(noise(dOffset), 0, 1, dMin, dMax);
    currentSep = map(noise(dOffset), 0, 1, sepMin, sepMax);
    currentA = map(noise(aOffset), 0, 1, 0, TWO_PI);
    shapes = new ArrayList<Shape>();
    background(0);
    
}

void draw(){
  background(0);
  yOffset += 0.01;
  aOffset += 0.01;
  sepOffset += 0.01;
  rOffset += 0.01;
  dOffset += 0.01;
  currentY = map(noise(yOffset), 0, 1, 0, height);
  currentD = map(noise(dOffset), 0, 1, dMin, dMax);
  currentSep = map(noise(sepOffset), 0, 1, sepMin, sepMax);
  currentA = map(noise(aOffset), 0, 1, 0, 3*TWO_PI);
  
  if(frameCount%2 == 0){
    shapes.add(new Shape(0.8*width, currentY, currentD, currentSep, currentA));
  }

  for(Shape s: shapes){
    s.update();
    s.show();
  }
  
  // cleaning up
  for(int i = shapes.size() - 1; i >= 0; i--){
    if(shapes.get(i).isOffScreen){
      shapes.remove(i);
    }
  }
  
  
  if(frameCount == 500){
    saveFrame("../" +sketchname + ".png");
  }

  
}

void keyPressed() {
  if (keyCode == ' ') {
    noLoop();
    saveFrame(sketchname + "_" + year()+"-"+month()+"-"+day()+"_"+hour()+"-"+minute()+"-"+second() + ".png");
  }
}
