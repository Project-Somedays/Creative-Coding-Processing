class Bubble {
  color col;
  PVector pos;
  PVector dir;
  float d = 1;
  boolean popped = false;
  int life = int(random(minLifespan, maxLifespan));
  boolean isMaxSize = false;

  Bubble(float x, float y, PVector dir_, color col_) {
    col = col_;
    pos = new PVector(x, y);
    dir = dir_.copy().setMag(0.5);
    
  }
  
  void setD(float d_){
    d = d_;
  }
  
  void popBubble(){
    popped = true;
  }
  
  void tick(){
    life --;
    if(life <= 0){
      popBubble();
    }
  }

  void update() {
    if(d > maxD || life <= 0){
      popBubble();
    }
    if (!popped) {
      pos.add(dir);
      d ++;
      
    }
    
  }

  void show() {
    stroke(col);
    ellipse(pos.x, pos.y, d, d);
  }
}
