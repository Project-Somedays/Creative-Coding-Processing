/*
*/
class PaintBlob{
  PVector pos;
  PVector vel;
  PVector acc;
  
  PaintBlob(float x, float y, float vX, float vY){
    pos = new PVector(x, y);
    vel = new PVector(vX, vY);
    acc = new PVector(0,0);
  }
  
  void update(){
    pos.add(vel);
    vel.add(gravity);
    //constrain(pos.y, 0, groundLevel);
    if(pos.y > groundLevel){
      pos.y = groundLevel;
      vel.set(0,0);
    }
  }
   
  void show(){
    fill(255,0,0);
    noStroke();
    ellipse(pos.x, pos.y, 10, 10);
  }
}
