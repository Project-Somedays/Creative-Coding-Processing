String sketchname = getClass().getName();
float s;
int opacity = 2;
color[] tribes = {color(255, 0, 0, opacity), color(0, 0, 255, opacity), color(0,255,0,opacity)};
color[] tribes2 = {#1Af94144, #1Af3722c, #1Af8961e, #1Af9844a, #1Af9c74f, #1A90be6d, #1A43aa8b, #1A4d908e, #1A577590, #1A277da1};
Tribesman test;
Tribesman[] tribesmen;
int n = 1000;
float los;

float vel = 1;
void setup() {
  size(1080, 1080, P2D);
  s = 10;
  los = width/3;
  //test = new Tribesman();
  //test = new Tribesman(random(width), random(height), color(255, 0, 0, opacity));
  tribesmen = new Tribesman[n];
  //tribesmen[0] = test;
  for (int i = 0; i < n; i++) {
    color tribe = tribes2[int(random(tribes2.length))];
    tribesmen[i] = new Tribesman(random(width), random(height), tribe);
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
