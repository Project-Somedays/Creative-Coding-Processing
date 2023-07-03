String sketchname = getClass().getName();
float s;
color[] tribes = {color(255, 0, 0), color(0, 0, 255)};
Tribesman test;
Tribesman[] tribesmen;
int n = 500;
float los;
int opacity = 2;
float vel = 1;
void setup() {
  size(1080, 1080, P2D);
  s = width/25;
  los = width/8;
  //test = new Tribesman();
  test = new Tribesman(random(width), random(height), color(255, 0, 0, opacity));
  tribesmen = new Tribesman[n];
  tribesmen[0] = test;
  for (int i = 1; i < n; i++) {
    tribesmen[i] = new Tribesman(random(width), random(height), color(255, 0, 0, opacity));
  }
  background(0);
}

void draw() {
  //background(0);
  //test.ctrl(mouseX, mouseY);
  for (Tribesman t : tribesmen) {
    t.update(findAveragePos(tribesmen, t));
    t.show();
  }
  //test.showDebug();



  if (frameCount ==  120) {
    saveFrame("../" + sketchname + ".png");
  }
}

PVector findAveragePos(Tribesman[] tribes, Tribesman t) {
  float avx = 0.0;
  float avy = 0.0;
  int tribeSize = 0;
  for (Tribesman each : tribes) {
    if (each.tribe == t.tribe && PVector.dist(each.pos, t.pos) <= los) {
      avx += each.pos.x;
      avy += each.pos.y;
      tribeSize += 1;
    }
  }
  avx = avx/tribeSize;
  avy = avy/tribeSize;
  return new PVector(avx, avy);
}
