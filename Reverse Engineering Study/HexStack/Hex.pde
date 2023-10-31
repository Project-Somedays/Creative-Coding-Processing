class Hex {
  float rx, ry, t;
  PVector c;
  PVector[] vTops, vBots;
  int sideOrderOffset;
  float extraA;
  float intraLayerOffset;
  boolean hasArc;
  Hex(float x, float y, float r_, float t_, float extraA_) {
    c = new PVector(x, y);
    rx = r_;
    ry = r_/2;
    t = t_;
    extraA = extraA_;
    vTops = new PVector[6];
    vBots = new PVector[6];
    sideOrderOffset = 0;
    update(); // sets the sideOrderOffset AND finds the vertices
    intraLayerOffset = random(-PI/12, PI/12);
    hasArc = random(1) < 0.5;
  }

  void update() {
    sideOrderOffset = (int((extraA +globA +PI/6)/(TWO_PI/6)))%6;
    println("sideOrderOffset: " + sideOrderOffset);
    findVertices();
  }

  void findVertices() {
    for (int i = 0; i < 6; i++) {
      float a = i*TWO_PI/6;
      vTops[i] = new PVector(c.x + rx*cos(-a-extraA-globA), c.y + ry*sin(-a-extraA - globA));
      vBots[i] = new PVector(c.x + rx*cos(-a-extraA-globA-intraLayerOffset), c.y + ry*sin(-a-extraA - globA - intraLayerOffset) + t);
    }
  }

  void show() {
    fill(0);
    stroke(255);
    // draw bottom
    beginShape();
    for (int i = 0; i < 6; i++) {
      vertex(vBots[i].x, vBots[i].y);
    }
    endShape(CLOSE);

    //// draw sides
    for (int i = 0; i < 6; i++) {
      //int start = (i + sideOrderOffset)%6;
      int start = i - sideOrderOffset;
      if (start < 0) {
        start += 6;
      }
      fill(colours[start]);
      int end = (start+1)%6;
      beginShape();
      vertex(vTops[start].x, vTops[start].y);
      vertex(vBots[start].x, vBots[start].y);
      vertex(vBots[end].x, vBots[end].y);
      vertex(vTops[end].x, vTops[end].y);
      endShape(CLOSE);
    }

    fill(0);
    // draw top
    beginShape();
    for (int i = 0; i < 6; i++) {
      vertex(vTops[i].x, vTops[i].y);
    }
    endShape(CLOSE);

    // label vertices
    //fill(255);
    //for (int i = 0; i < 6; i++) {
    //  text(i, vTops[i].x, vTops[i].y-20);
    //}
  }
}
