class Particle{
  PVector pos;
  //PVector vel;
  float noiseXOffset;
  float noiseYOffset;
  
  Particle(float x, float y){
    noiseXOffset = random(10000);
    noiseYOffset = random(10000);
    pos = new PVector(x,y);
    //vel = PVector.random2D();
    //vel = PVector.fromAngle(HALF_PI/2);
    //vel = PVector.sub(new PVector(width, height), pos).setMag(2);
    //vel = PVector.random2D().setMag(random(1,5));
    
  }
  
  void update(){
    //pos.add(vel);
    //bounce();
    pos.set(width*noise(noiseXOffset + globXOffset), height*noise(noiseYOffset + globYOffset));
    
  }
  
  //void bounce(){
  //  if(pos.x < 0 || pos.x > width){
  //    vel.x = -vel.x;
  //  }
    
  //  if(pos.y < 0 || pos.y > height){
  //    vel.y = -vel.y;
  //  }
  //}
  
  void show(){
    ellipse(pos.x, pos.y, nodeS, nodeS);
  }
}
