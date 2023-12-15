// auto thumbnail generation script: https://timrodenbroeker.de/courses/sketching-with-code/thumbnails/
String sketchname = getClass().getName();
/*
Author: Project Somedays
 Date Started: 2023-12-14
 Crazy Escalators EVERYWHERE
 */
int n = 20;
Escalator e;
void setup() {
  size(1080, 1080, P2D);
  rectMode(CENTER);
  stroke(0);
  strokeWeight(5);
  e = new Escalator(0.25*width, 0.25*height, 0.75*width, 10);
}

void draw() {
  background(255);
  e.update();
  e.show();


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

class Escalator {
  PVector start;
  float xEnd;
  int stairCount;
  float stairSize;
  ArrayList<PVector> stairPoints;
  PVector dir;

  Escalator(float startX, float startY, float xEnd_, int stairCount_) {
    start = new PVector(startX, startY);
    xEnd = xEnd_;
    stairCount = stairCount_;
    stairSize = (xEnd - startX)/stairCount;
    stairPoints = new ArrayList<PVector>();

    for (int i = 0; i < stairCount; i++) {
      stairPoints.add(new PVector(start.x + i*stairSize, start.y+ i*stairSize));
      stairPoints.add(new PVector(start.x + (i+1)*stairSize, start.y + i*stairSize));
      stairPoints.add(new PVector(start.x + (i+1)*stairSize, start.y + (i+1)*stairSize));
    }
    dir = PVector.fromAngle(QUARTER_PI);
  }

  void update() {
    for(PVector p : stairPoints){
      p.add(dir);
    }
    
  }
  void show() {
    beginShape();
    for (int i = 0; i < stairPoints.size(); i++) {
      vertex(stairPoints.get(i).x, stairPoints.get(i).y);
    }


    endShape();
  }
}
