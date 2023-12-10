/*
Author: Project Somedaysd
Started: 2023/12/11 for a WCCC Challenge, prompt: "Improbable Architecture"
I like the idea of a series of procedurally generated sillouhettes in a building in the shape of a boab tree
*/
// auto thumbnail generation script: https://timrodenbroeker.de/courses/sketching-with-code/thumbnails/
String sketchname = getClass().getName();
Star[] starField;
int starN = 1000;
color sky = #0B1022;
color tree = #3b3f4e;
Building b;
float mountainzoomFactor = 500;
float treezoomFactor = 400;
Mountains mountains;
color mountainsCol = #232738;


void setup(){
    size(1080,720);
    pixelDensity(1);
    starField = new Star[starN];
    for(int i = 0; i < starN; i++){
      starField[i] = new Star(random(width), random(0, height*0.75));
    }
    mountains = new Mountains(height*0.75);
    b = new Building(width/2, int(0.5*height), int(0.3*width));
}

void draw(){
  background(sky);
  //background(255);
  drawStarField();
  mountains.show();
  b.show();

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

void drawStarField(){
  fill(255);
  noStroke();
  for(Star s : starField){
    s.show();
  }
}
