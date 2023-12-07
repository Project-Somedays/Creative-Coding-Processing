// auto thumbnail generation script: https://timrodenbroeker.de/courses/sketching-with-code/thumbnails/
// Happy accident: accidentally got weird matrix effects
String sketchname = getClass().getName();
float[][] field;
float xOff, yOff;
float step = 0.005;
PVector[] pts;
int n = 1000;


void setup() {
  size(1080, 1080);
  field = new float[width][height];
  pts = new PVector[n];
  for(int i = 0; i < n; i++){
    pts[i] = new PVector(random(width), random(height));
  }
  yOff = 0;
  for (int i = 0; i < width; i++) {
    xOff = 0;
    for (int j = 0; j < height; j++) {
      field[i][j] = map(noise(xOff, yOff), 0, 1, 0, 100);
      xOff += step;
    }
    yOff += step;
  }
  fill(255,10);
  noStroke();

  background(0);

  fill(255);
  for (int i = 0; i < width; i++) {
    for (int j = 0; j < height; j++) {
      if (field[i][j] > 55 && field[i][j] < 60) {
        ellipse(i, j, 10, 10);
      }
    }
  }
}

//PVector generateSpawnPoint() {
//  float a = random(TWO_PI);
//  float x = width/2  + r*cos(a);
//  float y = height/2 + r*sin(a);
//  //println("New Spawn Point! (" + x + ", " + y + ")");
//  return new PVector(x, y);
//}

void draw() {
  //background(0);
  if (frameCount ==  120) {
  saveFrame("../" + sketchname + ".png");
}
}
