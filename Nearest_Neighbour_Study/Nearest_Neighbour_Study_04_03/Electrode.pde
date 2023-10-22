class Electrode{
  PVector pos;
  //float a;
  //float r;
  float noiseXOffset;
  float noiseYOffset;
  
  
  Electrode(float phase){
    noiseXOffset = random(10000);
    noiseYOffset = random(10000);
    pos = new PVector(width*noise(noiseXOffset),height*noise(noiseYOffset));
    //a = phase;
  }
  
  void update(){
    //r = 0.4*width*sin(0.1*(a+globA));
    //pos.set(width/2 + r*cos(a + globA), height/2 + r*sin(a + globA));
    pos.set(width*noise(noiseXOffset + globXOffset), height*noise(noiseYOffset + globYOffset));
  }
  
  
  void show(){
    ellipse(pos.x, pos.y, nodeS, nodeS);
  }
}
