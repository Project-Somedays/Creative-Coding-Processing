class Particle{
  PVector pos;
  PVector vel;
  boolean isDead = false;
  ArrayList<FireTrail> trail;
  
  Particle(float x, float y){
    pos = new PVector(x,y);
    //vel = PVector.random2D();
    //vel = PVector.fromAngle(HALF_PI/2);
    //vel = PVector.sub(new PVector(width, height), pos).setMag(2);
    vel = PVector.random2D().setMag(random(1,5));
    trail = new ArrayList<FireTrail>();
    
  }
  
  void update(){
    pos.add(vel);
    
    if(isDead){
      vel.add(gravity);
      trail.add(new FireTrail(pos.x, pos.y));
    } else {
      bounce();
    }
    //cleaning up fireTrails
    for(int i = trail.size()-1; i >= 0; i--){
      if(trail.get(i).opacity < 0){
        trail.remove(i);
      }
    }
    
  }
  
  void kill(){
    isDead = true;
  }
  
  void bounce(){
    if(pos.x < 0 || pos.x > width){
      vel.x = -vel.x;
    }
    
    if(pos.y < 0 || pos.y > height){
      vel.y = -vel.y;
    }
  }
  
  void show(){
    if(isDead){
      fill(255,0,0);
      noStroke();
      for(FireTrail f: trail){
        f.update();
        f.show();
      }
      ellipse(pos.x, pos.y, nodeS, nodeS);
      
      
    }
    
  }
}
