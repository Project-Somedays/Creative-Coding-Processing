// auto thumbnail generation script: https://timrodenbroeker.de/courses/sketching-with-code/thumbnails/
// Happy accident: accidentally got weird matrix effects
String sketchname = getClass().getName();
float[][] field;
float xOff, yOff;
float step = 0.005;
PVector[] pts;
int n = 1000;
float maxSep;
int maxHeightDiff = 5;


void setup() {
  size(1080, 1080);
  maxSep = width/10;
  //colorMode(HSB,360,100,100);
  
  // init pts
  pts = new PVector[n];
  for(int i = 0; i < n; i++){
    pts[i] = new PVector(random(width), random(height));
  }
  yOff = 0;
  
  // init field
  field = new float[width][height];
  for (int i = 0; i < width; i++) {
    xOff = 0;
    for (int j = 0; j < height; j++) {
      field[i][j] = map(noise(xOff, yOff), 0, 1, 0, 100);
      xOff += step;
    }
    yOff += step;
  }
 
  stroke(255,150);

  background(0);

  fill(255);
  for(int i = 0; i < n; i++){
    for(int j = i; j < n; j++){
      // skip self checks
      if(i == j){
        continue;
      }
      // ignore points that are too far away
      if(PVector.dist(pts[i], pts[j]) > maxSep){
        continue;
      }
      // ignore points that are too different in height
      if(isInDifferentHeightBand(pts[i], pts[j])){
        continue;
      }
      //int shade = int(map(getTopography(pts[i]),0,100, 360, 0));
      int shade = int(map(getTopography(pts[i]),0,100, 0, 255));
      int strokeThick = int(map(getTopography(pts[i]),0,100,00.5,2));
      strokeWeight(strokeThick);
      //stroke(shade,100,100);
      stroke(shade);
      line(pts[i].x, pts[i].y, pts[j].x, pts[j].y);
    }
  }
}

boolean isInDifferentHeightBand(PVector pi, PVector pj){
  return abs(getTopography(pi) - getTopography(pj)) > maxHeightDiff;
}

float getTopography(PVector p){
  int xCoord = int(p.x);
  int yCoord = int(p.y);
  return field[xCoord][yCoord];
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
