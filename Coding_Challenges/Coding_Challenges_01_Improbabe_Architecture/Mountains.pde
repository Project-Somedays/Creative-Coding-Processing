class Mountains {
  PVector[] profile;
  float h;
  Mountains(float h_) {
    h = h_;
    profile = initMountains();
  }

  PVector[] initMountains() {
    PVector[] profile_ = new PVector[width+1];
    profile_[0] = new PVector(width, height); // BR corner
    profile_[1] = new PVector(0, height); // BL corner
    for (int i = 2; i < width + 1; i++) {
      float nVal = noise(i/mountainzoomFactor);
      float hPerturbation = map(nVal, 0, 1, 0, height/4);
      profile_[i] = new PVector(i, h - hPerturbation);
    }
    return profile_;
  }

  void show() {
    fill(mountainsCol);
    beginShape();
    for (PVector p : profile) {
      vertex(p.x, p.y);
    }
    endShape(CLOSE);
  }
}
