class Tribesman{
  PVector pos;
  color tribe;
  PVector target;
  Tribesman(float x, float y, color col){
    pos = new PVector(x,y);
    tribe = col;
    target = new PVector(width/2, height/2);
  }
  
  void update(PVector newTarget){
    target.set(newTarget.x, newTarget.y);
    PVector rqrdDir = PVector.sub(target, pos);
    pos.add(rqrdDir.setMag(vel));
  }
  
  void ctrl(float x, float y){
    pos.set(x,y);
  }
  
  void show(){
    fill(tribe);
    noStroke();
    ellipse(pos.x, pos.y, s, s);
  }
  
  void showDebug(){
    fill(0,255,0);
    noStroke();
    ellipse(target.x, target.y, s/2, s/2);
    noFill();
    stroke(0,255,0);
    ellipse(pos.x, pos.y, los*2, los*2);
  }
}
