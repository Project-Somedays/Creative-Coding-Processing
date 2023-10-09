/*
Physics Sim for this one
Implementing Daniel's Shiffman's code: https://www.youtube.com/watch?v=9iaEqGOh5WM
Firstly, I'll go in the xz plane to see it's working properly
*/

// auto thumbnail generation script: https://timrodenbroeker.de/courses/sketching-with-code/thumbnails/
String sketchname = getClass().getName();
PVector gravity;
Pendulum pend;
float gravStrength = 0.001;
float groundLevel;
ArrayList<PaintBlob> blobs;


// color[] colours = {#1f2041, #4b3f72, #417b5a, #d0ceba, #e9d2c0};
color[] colours = {#5f0f40, #9a031e, #fb8b24, #e36414, #0f4c5c};
//color[] colours = {#4D5f0f40, #4D9a031e, #4Dfb8b24, #4De36414, #4D0f4c5c};

void setup() {
  size(1500, 1000);
  background(0);
  fill(255);
  stroke(255);
  strokeWeight(5);
  pend = new Pendulum(width/2, height/4, 0.5*height, QUARTER_PI);
  textAlign(CENTER, CENTER);
  textSize(20);
  gravity = new PVector(0, gravStrength*100);
  groundLevel = 0.9*height;
  blobs = new ArrayList<PaintBlob>();

}

void draw() {
  background(0);
  pend.update();
  pend.show();
  if(frameCount % 20 == 0){
    blobs.add(new PaintBlob(pend.pos.x, pend.pos.y, pend.vel.x/1000, pend.vel.y/1000));
    //blobs.add(new PaintBlob(pend.pos.x, pend.pos.y, 1, 0));
  }
  for(PaintBlob blob : blobs){
    blob.update();
    blob.show();
  }
  
 
  if (frameCount ==  600) {
    saveFrame("../" + sketchname + ".png");
  }
}

void keyPressed() {
  if (keyCode == ' ') {
    noLoop();
    saveFrame(sketchname + "_" + year()+"-"+month()+"-"+day()+"_"+hour()+"-"+minute()+"-"+second()+".png");
  }
}
