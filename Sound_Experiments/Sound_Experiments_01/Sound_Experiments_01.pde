// auto thumbnail generation script: https://timrodenbroeker.de/courses/sketching-with-code/thumbnails/
String sketchname = getClass().getName();
float soundDropOffAmbient = 0.2;
float soundDropOffBoundary = 20;
float leftBoundary, rightBoundary, upperBoundary, lowerBoundary;
int maxOpacity = 25;
Particle[] particles;
int n = 1000;
ArrayList<SoundSource> sources;


void setup() {
  size(1000, 1000);
  leftBoundary = 0.2*width;
  rightBoundary = 0.8*width;
  upperBoundary = 0.2*height;
  lowerBoundary = 0.8*height;
  sources = new ArrayList<SoundSource>();
  background(0);
}

void draw() {
  //background(0);

  for(SoundSource s: sources){
    s.updateandshow();
  }

  if (frameCount ==  120) {
    saveFrame("../" + sketchname + ".png");
  }
}

void mousePressed() {
  if (mouseButton == LEFT) {
    if (mouseX > leftBoundary && mouseX < rightBoundary && mouseY >  upperBoundary && mouseY < lowerBoundary) {
      sources.add(new SoundSource(mouseX, mouseY));
    }
  }
}

void keyPressed() {
  if (keyCode == ' ') {
    noLoop();
    saveFrame(sketchname + "_" + year()+"-"+month()+"-"+day()+"_"+hour()+"-"+minute()+"-"+second() + ".png");
  }
}
