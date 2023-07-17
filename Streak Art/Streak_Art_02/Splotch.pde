class Splotch {
  PVector pos;
  color col;
  float s;
  Splotch(float x, float y, color col_) {
    col = col_;
    pos = new PVector(x, y);
    s = random(width/20, width/10);
  }
  void update() {
    pos.add(new PVector(0, 1));
  }

  void show() {
    fill(col);
    noStroke();
    ellipse(pos.x, pos.y, s, s);
  }
}
