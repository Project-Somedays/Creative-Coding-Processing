class Mover{
  PVector pos, vel, acc;
  color col;
  Mover(float x, float y, PVector vel_, color col_){
    pos = new PVector(x,y);
    vel = vel_.copy();
    acc = new PVector(0,0);
    col = col_;
  }
  
  void applyForce(PVector f){
    acc.add(f);  
  }
  
  void update(){
    pos.add(vel);
    vel.add(acc);
    vel.setMag(1);
    acc.mult(0);
    wrap();
  }
  
  void wrap(){
    if(pos.x > width){
      pos.x = 0;
    }
    if(pos.x < 0){
      pos.x = width;
    }
    if(pos.y > height){
      pos.y = 0;
    }
    if(pos.y < 0){
      pos.y = height;
    }
  }
  
  void showLine(PVector otherPos){
    stroke(col);
    line(pos.x, pos.y, otherPos.x, otherPos.y);
  }
  
  void show(){
    stroke(col);
    ellipse(pos.x, pos.y, proximity, proximity);
  }
}
