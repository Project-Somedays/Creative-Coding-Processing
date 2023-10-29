class Blob{
  PVector pos;
  float r;
  float offset;
  BlobParticle[] pts;
  float springStiffness; 
  Blob(float x, float y, float r_, float offset_){
    r = r_;
    pos = new PVector(x,y);
    offset = offset_;
    pts = new BlobParticle[res+3];
    for(int i = 0; i < pts.length; i++){
      float a = i*TWO_PI/res;
      pts[i] = new BlobParticle(pos.x + r*cos(a), pos.y + r*sin(a));
    }
  }
  
  void update(){
    // move the overall blob
    pos.set(width/2 + 0.25*width*cos(globA + offset), height/2);
    for(int i = 0; i < pts.length; i++){
      // work out where the particle SHOULD be
      float a = i*TWO_PI/res;
      PVector target = new PVector(pos.x + r*cos(a), pos.y + r*sin(a));
      // apply a force in that direction
      PVector f = PVector.sub(target, pts[i].pos).setMag(0.01);
      pts[i].applyForce(f);
      //update the location of each point
      pts[i].update();
    }
  }
  
  void applySurfaceTension(){
    
  }
  
  void show(){
    for(BlobParticle blobparticle: pts){
      ellipse(blobparticle.pos.x, blobparticle.pos.y, 10, 10);
    }
    //ellipse(pos.x, pos.y, 2*r, 2*r);
  }
  
  
}
