class Hex {
  PVector pos;
  int state;
  float a;
  float thisR;
  float dist2c;

  Hex(float x, float y) {
    pos = new PVector(x, y);
    state = 1;
    thisR = bigR;
    dist2c = PVector.dist(c, pos);
  }

  void updateHex(){
    if(state == 1 && dist2c < rippleR){
      state = 2;
    } else if(state == 2){
      thisR = map(cos(a), -1, 1, 0.8*bigR, bigR);
      a+=frameDuration;
      if(a >= TWO_PI){
        a = 0;
        state = 1;
      }
    }
  }
  
  void showHex() {
    int opacity = int(map(thisR, 0.8*bigR, bigR,75,255));
    fill(0,0,255,opacity);
    stroke(0);
    strokeWeight(2);
    beginShape();
    for (int i = 0; i < 6; i++) {
      vertex(pos.x + thisR*cos(i*TWO_PI/6), pos.y + thisR*sin(i*TWO_PI/6));
    }
    endShape(CLOSE);
    
  }
  
}
