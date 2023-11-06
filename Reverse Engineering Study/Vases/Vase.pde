class Vase{
  PVector start;
  int h;
  float noiseOffset = random(10000);
  float[] pts;
  Vase(float x, float y){
    start = new PVector(x,y);
    h = int(random(heightMin, heightMax));
    pts = new float[h];
    for(int i = 0; i < pts.length; i++){
      pts[i] = maxW*noise(noiseOffset);
      noiseOffset += 0.005;
    }
  }
  
  void show(){
    beginShape();
    //lSide
    for(int i = 0; i < pts.length; i++){
      vertex(start.x - pts[i], start.y + i);
    }
    //bottom
    line(start.x - pts[h-1], start.y + h, start.x + pts[h-1], start.y + h);
    //rside
    for(int i = h - 1; i >= 0; i--){
      vertex(start.x + pts[i], start.y + i);
    }
    
    endShape(CLOSE);
  }
}
