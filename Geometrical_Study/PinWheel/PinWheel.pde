float a, r;
color [] cols = {#FFFFFF, #FF0000, #00FF00, #0000FF};
PVector[] locs;
String sketchname = getClass().getName();

void setup() {
  size(700, 700);
  ellipseMode(CORNER);
  a = 0;
  r = width/2;
  background(0);
  locs = new PVector[4];
  locs[0] = new PVector(0, 0);
  locs[1] = new PVector(width, 0);
  locs[2] = new PVector(3*width/4, 3*width/4);
  locs[3] = new PVector(width/4, 3*width/4);
  noFill();
}

void draw() {
  //background();
  if (a <= 2*TWO_PI) {
    for (int i = 0; i < 4; i++) {
      pushMatrix();
      //translate(locs[i].x, locs[i].y);
      translate(width/2, height/2);
      rotate((2*i+1)*QUARTER_PI);
      stroke(cols[i], 20);
      ellipse(0, 0, r*cos(a), r*sin(a));
      popMatrix();
    }
  } else {
    for (int i = 0; i < 4; i++) {
      pushMatrix();
      translate(locs[i].x, locs[i].y);
      rotate((2*i+1)*QUARTER_PI);
      noStroke();
      fill(0);
      ellipse(0, 0, r*cos(a), r*sin(a));
      popMatrix();
    }
  }
  a += 0.015;
  
  if (frameCount ==  120) {
    saveFrame("../" + sketchname + ".png");
  }
}
