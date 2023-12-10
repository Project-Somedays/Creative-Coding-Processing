class Star{
  PVector p;
  float r;
  Star(float x, float y){
    p = new PVector(x,y);
    r = randomGaussian()*2.5;
  }
  void show(){
    ellipse(p.x,p.y,r,r);
  }
}  
