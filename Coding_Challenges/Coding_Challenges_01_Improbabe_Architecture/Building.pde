class Building {
  PVector[] rprofile;
  PVector[] lprofile;
  int h;
  int w;
  float cX;

  Building(float centreX_, int h_, int w_) {
    h = h_;
    w = w_;
    cX = centreX_;
    lprofile = fillProfile(-1);
    rprofile = fillProfile(1);
  }
  // RSide


  PVector[] fillProfile(int dir) { // -1 or + 1

    // to get the general boab shape, a sin curve
    PVector[] profile = new PVector[h];
    for (int i = 0; i < h; i++) {
      float a = PI*0.2 + i*PI*0.8/h; // starts part way through the cycle and finishes the cycle by the top of the tree
      float x = cX + dir*w/2 + dir*abs(sin(a))*w*0.1;
      float y = height - i;
      float xNoise = map(noise(x/treezoomFactor, y/treezoomFactor),0,1,0,0.2*w);
      profile[i] = new PVector(x + dir*xNoise, y);
    }
    return profile;
  }

  void show() {
    fill(tree);
    beginShape();
    for (PVector p : lprofile) {
      vertex(p.x, p.y);
    }
    // go backwards through the rprofile
    for (int i = rprofile.length -1; i >= 0; i--) {
      vertex(rprofile[i].x, rprofile[i].y);
    }
    endShape();
  }
}
