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

void setup(){
    size(1080,720);
    yOffset = random(100000);
    aOffset = random(100000);
    sepOffset = random(100000);
    rOffset = random(1000000);
    dMax = height/5;
    dMin = height/20;
    sepMin = height/20;
    sepMax = height/5;
    currentY = map(noise(yOffset), 0, 1, 0, height);
    currentD = map(noise(dOffset), 0, 1, dMin, dMax);
    currentSep = map(noise(dOffset), 0, 1, sepMin, sepMax);
    currentA = map(noise(aOffset), 0, 1, 0, TWO_PI);
    
    test = new Shape(width/2, currentY);
    background(0);
    
}

void draw(){
  
  yOffset += 0.01;
  aOffset += 0.01;
  sepOffset += 0.01;
  rOffset += 0.01;
  dOffset += 0.01;
  currentY = map(noise(yOffset), 0, 1, 0, height);
  currentD = map(noise(dOffset), 0, 1, dMin, dMax);
  currentSep = map(noise(sepOffset), 0, 1, sepMin, sepMax);
  currentA = map(noise(aOffset), 0, 1, 0, 2*TWO_PI);
  noStroke();
  
  pushMatrix();
    translate(width/2, currentY);
    rotate(currentA);
    fill(255,0,0,10);
    ellipse(0,currentSep, currentD, currentD);
    fill(0,255,0, 10);
    ellipse(0,-currentSep, currentD, currentD);
  popMatrix();
  

  
}

void keyPressed() {
  if (keyCode == ' ') {
    noLoop();
    saveFrame(sketchname + "_" + year()+"-"+month()+"-"+day()+"_"+hour()+"-"+minute()+"-"+second() + ".png");
  }
}
