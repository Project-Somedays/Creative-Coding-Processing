// auto thumbnail generation script: https://timrodenbroeker.de/courses/sketching-with-code/thumbnails/
String sketchname = getClass().getName();
float globA = 0;
float swingPos = 0;
float swingRate = 0.017;
float globARate = 0.023;
float rX, rY;
// color[] colours = {#1f2041, #4b3f72, #417b5a, #d0ceba, #e9d2c0};
color[] colours = {#5f0f40, #9a031e, #fb8b24, #e36414, #0f4c5c};
float blotSize;
void setup(){
    size(1000,1000);
    background(0);
    fill(255);
    noStroke();
    background(0);
    rX = width/8;
    rY = 0.4*height;
}

void draw(){
  
  float dotChance = random(1);
  color col = colours[int(random(5))];
  fill(col);
  
  if(dotChance < 0.1){
    blotSize = 10;
  } else if(dotChance < 0.02){
    blotSize = 20;
  } else {
    blotSize = 2;
  }
  pushMatrix();
  translate(width/2, height/2);
  rotate(globA);
  float x = rX*cos(swingPos);
  float y = rY*sin(swingPos);
  ellipse(x, y, blotSize, blotSize);
  popMatrix();
  rX *= 0.9999999;
  rY *= 0.9999999;
  
  swingPos += swingRate;

  globA += globARate;
  if (frameCount ==  600) {
    saveFrame("../" + sketchname + ".png");
  }
}

void keyPressed(){
  if(keyCode == ' '){
    noLoop();
    saveFrame(sketchname + "_" + year()+"-"+month()+"-"+day()+"_"+hour()+"-"+minute()+"-"+second() + ".png");
  }
}

