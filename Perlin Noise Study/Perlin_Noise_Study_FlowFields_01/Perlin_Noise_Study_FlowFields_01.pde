/*
Make a field of points
 */
Pt[][] pts;
PVector[][] flowfield;
PVector c;
float inc, xOff, yOff;
int iterations;

void setup() {
  size(720, 720);
  noStroke();
  inc = 0.01;
  xOff = 0;
  yOff = 0;
  c = new PVector(width/2, height/2);
  pts = new Pt[width][height];
  flowfield = new PVector[width][height];
  for (int i = 0; i < width; i ++) {
    xOff += inc;
    yOff = 0;
    for (int j = 0; j < height; j++) {
      yOff += inc;
      pts[i][j] = new Pt(i, j);
      flowfield[i][j] = PVector.fromAngle(TWO_PI*noise(xOff, yOff));
    }
  }
}

void draw() {
  //for (int i = 0; i < width; i++) {
  //  for (int j = 0; j < height; j++) {
  //    
  //  }
  //}
  for (int i = 0; i < width; i ++) {
    for (int j = 0; j < height; j++) {
      pts[i][j].update();
      pts[i][j].show();
    }
  }
}

int getGreyScaleValFromCentre(PVector loc) {
  float d = PVector.dist(loc, c);
  return int(map(d, 0, width/sqrt(2), 255, 0));
}

class Pt {
  PVector loc;
  color col;
  Pt(int i, int j) {
    loc = new PVector(float(i), float(j));
    col = getGreyScaleValFromCentre(loc);
  }

  void update() {
    loc.add(flowfield[int(loc.x)][int(loc.y)]);
    if (loc.x < 0) {
      loc.x = width-1;
    }
    if (loc.x >= width) {
      loc.x = 0;
    }
    if (loc.y < 0) {
      loc.y = height-1;
    }
    if (loc.y >= height) {
      loc.y = 0;
    }
  }

  void show() {
    fill(col);
    rect(loc.x, loc.y, 1, 1);
  }
}

void keyPressed() {
  if (keyCode == ENTER) {
    save("Flowfield.jpg");
  }
}
