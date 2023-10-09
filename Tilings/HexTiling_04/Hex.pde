class Hex {
  PVector pos;
  PVector[] p;
  PVector[] c;
  Hex(float x, float y) {
    pos = new PVector(x, y);
    p = new PVector[6];
    c = new PVector[6];
    for (int i = 0; i < 6; i++) {
      float px = x + R*cos(i*THIRD_PI);
      float py = y + R*sin(i*THIRD_PI);
      p[i] = new PVector(px, py);
      c[i] = new PVector(px, py);
    }
  }
  
  void showVertices() {
    for (int i = 0; i < 6; i++) {
      point(p[i].x, p[i].y);
    }
  }
  
  void updateHex(){
    for (int i = 0; i < 6; i++) {
      float x = pos.x + currentR*cos(i*THIRD_PI);
      float y = pos.y + currentR*sin(i*THIRD_PI);
      c[i].set(x,y);
    }
  }
  
  void showHex() {
    beginShape();
    for (int i = 0; i < 6; i++) {
      vertex(c[i].x, c[i].y);
    }
    endShape(CLOSE);
  }
}
