// auto thumbnail generation script: https://timrodenbroeker.de/courses/sketching-with-code/thumbnails/
String sketchname = getClass().getName();
/*
Author: Project Somedays
Date Started: 2023-12-14
3D perlin noise generated platforms
Get one layer happening first in 2D
*/
int n;
int s;
float zoomFactor = 200.0;

void setup(){
    size(1080,1080,P2D);
    n = 50;
    s = width/n;
    rectMode
}

void draw(){
  background(0);
  if (frameCount ==  120) {
    saveFrame("../" + sketchname + ".png");
  }
}

void keyPressed() {
  if (keyCode == ' ') {
    noLoop();
    saveFrame(sketchname + "_" + year()+"-"+month()+"-"+day()+"_"+hour()+"-"+minute()+"-"+second() + ".png");
  }
}
