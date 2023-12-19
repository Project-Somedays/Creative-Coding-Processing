class Particle{
  PVector p;
  PVector v;
  float charge;
  //String id = generateGUID(); 
  Particle(float x, float y){
    p = new PVector(x,y);
    charge = randomGaussian(10);
    v = PVector.random2D();
  }
  
  void update(){
    p.add(v);
    charge += map(noise(p.x, p.y, noiseEvol),0,1, 0, 5);
    bounce();
  }
  
  void bounce(){
    if(p.x > width || p.x < 0){
      v.x = -v.x;
    }
    if(p.y > height || p.y < 0){
      v.y = -v.y;
    }
  }
  
  void show(){
    int col = int(map(charge, 0, 500, 0, 255));
    fill(0,col);
    circle(p.x,p.y,10);
  }
}
