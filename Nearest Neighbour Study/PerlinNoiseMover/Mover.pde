class Mover{
  PVector p;
  float xOff;
  float yOff;
  int ix;
  Mover(int ix_){
    p = new PVector(random(width), random(height));
    ix = ix_;
    yOff = random(1000);
    xOff = random(1000);
  }
  
  void update(){
    p.set(map(noise(xOff),0,1,0,width), map(noise(yOff),0,1,0,height));
    yOff += 0.001;
    xOff += 0.001;
  }
  
  void show(){
    //ellipse(p.x, p.y, 2*r, 2*r);
    stroke(255, 50);
    strokeWeight(1);
    point(p.x, p.y);
    
    for(int i = 0; i < swarm.length; i++){
      if(swarm[i].ix != ix){
        float d = PVector.dist(p, swarm[i].p);
        if(d < 2*r){
          stroke(int(map(d, 0, 2*r, 50, 255)), 100);
          strokeWeight(2);
          line(p.x, p.y, swarm[i].p.x, swarm[i].p.y);
        }
      }
    }
  }
}
