// auto thumbnail generation script: https://timrodenbroeker.de/courses/sketching-with-code/thumbnails/
String sketchname = getClass().getName();

int n;
float d;
void setup() {
  size(1080, 720);
  //angleMode("DEGREES");
  n = 10;
  d = 71;
  stroke(255);
  strokeWeight(1);
  noFill();
}

void draw() {
  background(0);
  translate(width/2, height/2);
  stroke(255, 200);
  strokeWeight(1);
  beginShape();
  for (int i = 0; i < 361; i++) {
    float k = i*d;
    float r = 300*sin(n*radians(k));
    float x = r*cos(radians(k));
    float y = r*sin(radians(k));
    vertex(x, y);
  }
  endShape();
  
  stroke(255, 0, 255);
  strokeWeight(5);
  // second pass so you can see the actual things
  beginShape();
  for (int i = 0; i < 361; i++) {
    float k = i;
    float r = 300*sin(n*radians(k));
    float x = r*cos(radians(k));
    float y = r*sin(radians(k));
    vertex(x, y);
  }
  endShape();
  
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
