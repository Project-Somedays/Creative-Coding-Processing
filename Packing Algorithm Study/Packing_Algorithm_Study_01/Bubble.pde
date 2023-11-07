class Bubble {
  color col;
  PVector pos;
  float r = 1;
  boolean stillGrowing = true;

  Bubble(float x, float y) {
    col = colours[int(random(colours.length))];
    pos = new PVector(x, y);
  }
  
  void detectCollision(){
    stillGrowing = false;
  }

  void update() {
    if (stillGrowing) {
      r += 2;
    }
  }

  void show() {
    stroke(col);
    ellipse(pos.x, pos.y, r, r);
  }
}
