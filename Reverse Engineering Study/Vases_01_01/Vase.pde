class Vase {
  int startX, startY, h;
  float[] pts;
  color col;
  Vase(int x_, int y_, int h_) {
    startX = x_;
    startY = y_;
    h = h_;
    pts = new float[h];
    for(int i = 0; i < h; i++){
      int yIx = startY + i + heightMax;
      pts[i] = profile[yIx];
    }
   col = colours[int(random(colours.length))];
  }

  void show() {
    fill(col);
    beginShape();
    //lSide
    for(int i = 0 ; i < h; i++){
      vertex(startX - pts[i], startY + i);
    }
    
    // bottom of the vase
    vertex(startX - pts[h-1], startY + h);
    
    //rside
    
    for(int i = h - 1; i >= 0; i--){
      vertex(startX + pts[i], startY + i);
    }
    endShape(CLOSE);
  }
}
