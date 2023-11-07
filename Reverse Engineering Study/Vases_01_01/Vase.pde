class Vase {
  int startX, startY, h;

  float[] pts;
  Vase(int x_, int y_, int h_) {
    startX = x_;
    startY = y_;
    h = h_;
  }

  void show() {
    beginShape();
    
    //lSide
    for(int i = 0 ; i < h; i++){
      vertex(startX - profile[startY + i + heightMax], startY + i);
    }
    
    // bottom of the vase
    vertex(startX - profile[startY + h + heightMax], startY + h);
    
    //rside
    
    for(int i = h - 1; i >= 0; i--){
      vertex(startX + profile[startY + i + heightMax], startY + i);
    }
    
    endShape(CLOSE);
  }
}
