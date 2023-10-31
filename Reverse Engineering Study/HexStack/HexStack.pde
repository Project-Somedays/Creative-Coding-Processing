String sketchname = getClass().getName();
Hex[] stack;
float globA;
color[] colours = {#0c7176, #0f87ad, #119da4, #1ADEE7, #16c9d2, #13b3bb};
void setup() {
  size(500, 500);
  stack = new Hex[15];
  stack[0] = new Hex(width/2, 2*height/3, 200, 50,0);
  for(int i = 1; i < stack.length; i++){
    float rx = stack[i-1].rx*random(0.75, 0.95); // new radius is between half and 90 of the previous
    float t = rx/stack[i-1].rx * stack[i-1].t; // new thickness is proportional to the radius
    float cx = stack[i - 1].c.x + random(-stack[i-1].rx/8, stack[i-1].rx/8); // new centre for the next layer up is only r/4 away from centre
    float cy = stack[i - 1].c.y + random(-stack[i-1].ry/8, stack[i-1].ry/8) - t;
    stack[i] = new Hex(cx, cy, rx, t, random(TWO_PI));
  }
  fill(0);
  stroke(255);
  strokeWeight(1);
  textSize(20);
  textAlign(CENTER);
  strokeJoin(BEVEL);
  globA = 0;
  
}

void draw() {
  background(0);
  for(Hex h: stack){
    h.update();
    h.show();
  }
  if (frameCount ==  120) {
    saveFrame("../" + sketchname + ".png");
  }
  
  globA += 0.01;
}

//void keyPressed(){
//  if(keyCode == RIGHT){
//    globA += PI/12;
//  }
//  if(keyCode == LEFT){
//    globA -= PI/12;
//  }
//  h.update();
//}
