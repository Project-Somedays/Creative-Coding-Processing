class SoundSource{
  PVector source;
  Particle[] particles;
  SoundSource(float x, float y){
    source = new PVector(x,y);
    particles = new Particle[n];
    for(int i = 0; i < n; i++){
      float a = i*TWO_PI/n;
      PVector vel = PVector.fromAngle(a);
      particles[i] = new Particle(source,vel);
    }
  }
  
  void updateandshow(){
    for(Particle p : particles){
    p.update();
    p.bounce(leftBoundary, rightBoundary, upperBoundary, lowerBoundary);
    p.show();
  }
  }
  
}
