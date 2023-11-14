class Bubble {
  color col;
  PVector pos;
  PVector dir;
  float d = 1;
  boolean stillGrowing = true;

  Bubble(float x, float y, PVector dir_, color col_) {
    col = col_;
    pos = new PVector(x, y);
    dir = dir_.copy().setMag(0.5);
    
  }
  
  void setD(float d_){
    d = d_;
  }
  
  void detectCollision(){
    stillGrowing = false;
  }

  void update() {
    if(d > maxD){
      detectCollision();
    }
    if (stillGrowing) {
      pos.add(dir);
      d++;
    }
    
  }

  void show() {
    stroke(col);
    ellipse(pos.x, pos.y, d, d);
  }
}
