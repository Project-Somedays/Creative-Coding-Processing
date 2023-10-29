class BlobParticle{
  PVector pos;
  PVector vel;
  PVector acc;
  
  BlobParticle(float x, float y){
    pos = new PVector(x,y);
    vel = new PVector(0,0);
    acc = new PVector(0,0);
  }
  
  void applyForce(PVector f){
    acc.add(f);
  }
  
  void update(){
    pos.add(vel);
    vel.add(acc);
    acc.mult(0);
  }
  
  void show(){
  
  }
}
