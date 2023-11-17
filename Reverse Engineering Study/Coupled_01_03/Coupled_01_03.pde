// auto thumbnail generation script: https://timrodenbroeker.de/courses/sketching-with-code/thumbnails
// Reverse engineering this: https://openprocessing.org/sketch/2036461
String sketchname = getClass().getName();
ArrayList<Shape> shapes;
float y, a;
float yOffset, aOffset, sepOffset, dOffset, xOffset;
float dMin,dMax;
float sep;
Shape test;
float currentY, currentX, currentD, currentSep;
float sepMin, sepMax;
float currentA;
float rOffset;
//color[] colours = {#26547c, #ef476f, #ffd166};
color[] colours = {#ffbc42, #d81159, #8f2d56, #218380, #73d2de};

void setup(){
    size(1080,1080);
    yOffset = random(100000);
    aOffset = random(100000);
    sepOffset = random(100000);
    xOffset = 0;
    rOffset = random(1000000);
    stroke(0,25);
    dMax = height/10;
    dMin = height/20;
    sepMin = height/20;
    sepMax = height/10;
    currentY = map(noise(yOffset), 0, 1, 0, height);
    currentX = map(noise(xOffset), 0, 1, 0, width);
    currentD = map(noise(dOffset), 0, 1, dMin, dMax);
    currentSep = map(noise(dOffset), 0, 1, sepMin, sepMax);
    currentA = map(noise(aOffset), 0, 1, 0, TWO_PI);
    
    //test = new Shape(width/2, currentY);
    background(0);
    
}

void draw(){
  yOffset += 0.01;
  xOffset += 0.01;
  aOffset += 0.01;
  sepOffset += 0.01;
  rOffset += 0.01;
  dOffset += 0.01;
  currentY = map(noise(yOffset), 0, 1, 0, height);
  currentX = map(noise(xOffset), 0, 1, 0, width);
  currentD = map(noise(dOffset), 0, 1, dMin, dMax);
  currentSep = 0.8*map(noise(sepOffset), 0, 1, sepMin, sepMax);
  currentA = map(noise(aOffset), 0, 1, 0, 3*TWO_PI);

  
  pushMatrix();
    translate(currentX, currentY);
    rotate(currentA);
    for(int i = 0; i < colours.length; i++){
      fill(colours[i]);
      ellipse(currentSep*cos(i*TWO_PI/colours.length), currentSep*sin(i*TWO_PI/colours.length), currentD, currentD);
    }
  popMatrix();
  
  
  if(frameCount == 1000){
    saveFrame("../" +sketchname + ".png");
  }

  
}

void keyPressed() {
  if (keyCode == ' ') {
    noLoop();
    saveFrame(sketchname + "_" + year()+"-"+month()+"-"+day()+"_"+hour()+"-"+minute()+"-"+second() + ".png");
  }
}
