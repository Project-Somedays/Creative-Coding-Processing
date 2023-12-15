class Brush{
  float xOff, yOff;
  PVector p;
  Brush(){
    xOff = random(10000);
    yOff = random(10000);
    float x = getNoiseVal(xOff, 0, width);
    float y = getNoiseVal(yOff, 0, height);
    p = new PVector(x,y);
  }
  
  void update(){
    xOff += step;
    yOff += step;
    float x = getNoiseVal(xOff, 0, width);
    float y = getNoiseVal(yOff, 0, height);
    p.set(x,y);
  }
  
  float getNoiseVal(float offset, float minVal, float maxVal){
    return map(noise(offset), 0, 1, minVal, maxVal);
  }
}
