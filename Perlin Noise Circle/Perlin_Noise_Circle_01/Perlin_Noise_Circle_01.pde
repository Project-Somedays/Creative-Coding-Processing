// auto thumbnail generation script: https://timrodenbroeker.de/courses/sketching-with-code/thumbnails/
// Happy accident: accidentally got weird matrix effects
String sketchname = getClass().getName();
PVector[][] ff;
Brush[] painters;
float xOff = 0;
float yOff = 0;
float step = 0.02;
Brush test;
PVector c;
float r;
int n = 2000;

void setup() {
  size(1080, 1080);
  r = 0.9*width/2;

  ff = new PVector[width][height];
  
  c = new PVector(width/2, height/2);

  // initialise ff
  for (int x = 0; x < height; x++) {
    xOff += step;
    yOff = 0;
    for (int y = 0; y < width; y++) {
      xOff += step;
      float dir = noise(xOff, yOff);
      ff[x][y] = PVector.fromAngle(dir*TWO_PI).setMag(1);
    }
  }
  
  painters = new Brush[n];
  for(int i = 0; i < n; i++){
    painters[i] = new Brush(color(255,0,0,2));
  }

  background(0);
}

PVector generateSpawnPoint() {
  float a = random(TWO_PI);
  float x = width/2  + r*cos(a);
  float y = height/2 + r*sin(a);
  //println("New Spawn Point! (" + x + ", " + y + ")");
  return new PVector(x, y);
}

void draw() {
  //background(0);
  for(Brush b : painters){
    b.update();
    b.show();
  }
  
  if (frameCount ==  120) {
    saveFrame("../" + sketchname + ".png");
  }
}
