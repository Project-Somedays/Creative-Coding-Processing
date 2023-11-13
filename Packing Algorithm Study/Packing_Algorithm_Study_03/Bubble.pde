class Bubble {
  color col;
  PVector pos;
  PVector dir;
  float r = 1;
  boolean stillGrowing = true;

  Bubble(float x, float y, PVector dir_, color col_) {
    col = col_;
    pos = new PVector(x, y);
    dir = dir_.copy();
    
  }
  
  void setR(float r_){
    r = r_;
  }
  
  void detectCollision(){
    stillGrowing = false;
  }

  void update() {
    if (stillGrowing) {
      pos.add(dir);
      r ++;
    }
    if(r > maxR){
      detectCollision();
    }
  }

  void show() {
    stroke(col);
    ellipse(pos.x, pos.y, r, r);
  }
}
