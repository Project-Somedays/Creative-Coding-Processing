/*
Version 3.1 - Tribesman spawn in a circle and preferentially move toward the nearest of their kind rather than towards the average pos of their kind
*/
String sketchname = getClass().getName();
float s;
int opacity = 2;
color[] tribes0 = {color(255, 0, 0)};
color[] tribes = {color(255, 0, 0, opacity), color(0, 0, 255, opacity), color(0,255,0,opacity)};
color[] tribes2 = {#1Af94144, #1Af3722c, #1Af8961e, #1Af9844a, #1Af9c74f, #1A90be6d, #1A43aa8b, #1A4d908e, #1A577590, #1A277da1};
color[] tribes3 = {#05012a4a, #05013a63, #0501497c, #05014f86, #052a6f97, #052c7da0, #05468faf, #0561a5c2, #0589c2d9, #05a9d6e5};
color[] tribes4 = {#05590d22, #05800f2f, #05a4133c, #05c9184a, #05ff4d6d, #05ff758f, #05ff8fa3, #05ffb3c1, #05ffccd5, #05fff0f3};
Tribesman test;
Tribesman[] tribesmen;
int n = 5;
float los;

float vel = 1;
void setup() {
  size(1080, 1080, P2D);
  s = 50;
  los = 0.5*width;
  test = new Tribesman(mouseX, mouseY, tribes0[0]);
  //test = new Tribesman(random(width), random(height), color(255, 0, 0, opacity));
  tribesmen = new Tribesman[n];
  tribesmen[0] = test;
  
  float r = 0.95*width/2;
  for (int i = 1; i < n; i++) {
    color tribe = tribes0[int(random(tribes0.length))];
    float a = random(0, TWO_PI);
    tribesmen[i] = new Tribesman(width/2 + r*cos(a), height/2 + r*sin(a), tribe);
  }
  //background(0);
}

void draw() {
  background(0);
  test.ctrl(mouseX, mouseY);
  for (Tribesman t : tribesmen) {
    t.update(findAveragePos(tribesmen, t));
    t.show();
  }
  test.showDebug();



  if (frameCount ==  1000) {
    saveFrame("../" + sketchname + ".png");
  }
}

PVector findAveragePos(Tribesman[] tribes, Tribesman t) {
  float tx = 0.0;
  float ty = 0.0;
  float avx = 0.0;
  float avy = 0.0;
  
 
  // loop through to find the total x and y
  for (Tribesman each : tribes) {
    if (each.tribe == t.tribe && PVector.dist(each.pos, t.pos) <= los) {
      tx += each.pos.x;
      ty += each.pos.y;
    }
  }
  
  // now loop through to find the weighted average
  for (Tribesman each : tribes) {
    if (each.tribe == t.tribe && PVector.dist(each.pos, t.pos) <= los) {
      avx += (1 - each.pos.x/tx)*each.pos.x;
      avy += (1 - each.pos.y/ty)*each.pos.y;
    }
  }
  
  return new PVector(avx, avy);
}
