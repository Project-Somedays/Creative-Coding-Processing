/*
Author: Project Somedays
Started: 2023-10-16
Inspired by Matt Pearson's Book, "Generative Art: A Practical Guide using Processing"
Auto thumbnail generation script: https://timrodenbroeker.de/courses/sketching-with-code/thumbnails/
Perlin noise on the radius and rotation variables
*/
String sketchname = getClass().getName();
float aOffset, rOffset, aSeed, rSeed, aInc, rInc;
int fillVal = 360;
boolean fillValIncreasing = false;

void setup() {
  size(1080, 1080); 
  rSeed = random(10000);
  aSeed = random(10000);
  aOffset = aSeed;
  rOffset = rSeed;
  aInc = 0.008;
  rInc = 0.01;
  background(0);
  colorMode(HSB, 360, 100, 100);
  
  strokeWeight(5);
  noFill();
  
  }


void draw() {
  pushMatrix();
  translate(width/2, height/2);
  float a = TWO_PI * noise(aOffset);
  float r = 0.9*0.5*width*noise(rOffset);
  stroke(fillVal, 100, 100, 25);
  line(r*cos(a), r*sin(a), r*cos(a+PI), r*sin(a+PI));
  popMatrix();
  
  
  aOffset += aInc;
  rOffset += rInc;
  
  if(fillValIncreasing){
    fillVal ++;
    if(fillVal == 360){
      fillValIncreasing = false;
    }
  } else {
    fillVal --;
    if(fillVal == 0){
      fillValIncreasing = true;
    }
  }
  
  if (frameCount ==  1200) {
    saveFrame("../" + sketchname + ".png");
  }
}

void keyPressed(){
  if(keyCode == ' '){
    saveFrame(sketchname + "_" + year() + "-" + month() + "-" + day() + "_" + hour() + "-" + minute() + "-" + second() + ".png");
  }
}
