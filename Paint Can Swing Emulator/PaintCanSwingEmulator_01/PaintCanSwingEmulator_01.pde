// auto thumbnail generation script: https://timrodenbroeker.de/courses/sketching-with-code/thumbnails/
String sketchname = getClass().getName();
float globA = 0;
float swingPos = 0;
float swingRate = 0.01;
float globARate = 0.0075;
// color[] colours = {#1f2041, #4b3f72, #417b5a, #d0ceba, #e9d2c0};
color[] colours = {#5f0f40, #9a031e, #fb8b24, #e36414, #0f4c5c};
float blotSize;
void setup(){
    size(1000,1000);
    background(0);
    fill(255);
    noStroke();
    background(0);
}

void draw(){
  
  if(frameCount%10 == 0){
    blotSize = 20;
    if(frameCount%3 ==0){
      blotSize = 10;
    }
    fill(colours[int(random(colours.length))]);
    
    ellipse((1+ cos(globA))*width/2, (1 + sin(globA + swingPos))*height/2, blotSize, blotSize);
  }
  
  
  
  swingPos += swingRate;

  globA += globARate;
  if (frameCount ==  1500) {
    saveFrame("../" + sketchname + ".png");
  }
}

void keyPressed(){
  if(keyCode == ' '){
    noLoop();
    saveFrame(sketchname + "_" + year()+"-"+month()+"-"+day()+"_"+hour()+"-"+minute()+"-"+second() + ".png");
  }
}
