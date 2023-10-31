class Mover {
  PVector p, v;
  PVector[] wallIntersectionPoints;
  int ix;

  Mover(float x, float y, int ix_) {
    p = new PVector(x, y);
    v = PVector.random2D();
    wallIntersectionPoints = new PVector[walls.length];
    ix = ix_;
    
  }

  void update() {
    p.add(v);
    for (int i = 0; i < walls.length; i++) {
      if (doesIntersect(walls[i])) {
        //ellipse(wallIntersectionPoints[i].x, wallIntersectionPoints[i].y, 10, 10);
        PVector g = PVector.sub(p, wallIntersectionPoints[i]);
        float dy_ = -sin(walls[i].a)*g.x + cos(walls[i].a)*g.y; // rotate around pt to make coordinate system easier
        float vx_ = cos(walls[i].a)*v.x + sin(walls[i].a)*v.y; //
        float vy_ = -sin(walls[i].a)*v.x + cos(walls[i].a)*v.y;
        if (abs(dy_) < r) {
          v.set(cos(walls[i].a)*vx_ + sin(walls[i].a)*vy_, sin(walls[i].a)*vx_ - cos(walls[i].a)*vy_);
        }
      }
    }
  }

  boolean doesIntersect(Wall w) {
    // following a wikipedia article (blindly)
    float x1 = p.x;
    float y1 = p.y;
    float x2 = p.x + v.x*2*width;
    float y2 = p.y + v.y*2*width;

    float x3 = w.start.x;
    float y3 = w.start.y;
    float x4 = w.end.x;
    float y4 = w.end.y;
    float denominator = (x1 - x2)*(y3 - y4) - (y1-y2)*(x3 - x4);
    if (denominator == 0) {
      return false;
    }
    float t = ((x1-x3)*(y3-y4) - (y1 - y3)*(x3-x4))/denominator;
    float u = ((x2 - x1)*(y1-y3) - (y2 - y1)*(x1-x3))/denominator;
    if (t >= 0 && t <= 1 && u >= 0 && u <= 1) {
      wallIntersectionPoints[w.ix] = new PVector(x1 + t*(x2 - x1), y1 + t*(y2-y1));
      //PVector pt = new PVector(x3+u*(x4-x3), y3 + u*(y4-y3));
      return true;
    } else {
      wallIntersectionPoints[w.ix] = null;
      return false;
    }
  }



  void show() {
    noFill();
    stroke(255);
    strokeWeight(2);
    //ellipse(p.x, p.y, r, r);
    //line(p.x, p.x, v.x, v.y);
    for(int i = 0; i < movers.length; i++){
      if(i != ix){
        float d = PVector.dist(p, movers[i].p);
        if(d <= 2*r){
          int col = int(map(d, r/4, 2*r,50, 255));
          stroke(col);
          line(p.x, p.y, movers[i].p.x, movers[i].p.y);
        }
      }
    }
  }
}

//class Mover{
//    PVector p, v;
//    PVector scalarProjWall1, scalarProjWall2, scalarProjWall3;
//    float d2Wall1, d2Wall2, d2Wall3;
//    boolean hasBounced;
//    Mover(float x, float y){
//        p = new PVector(x, y);
//        v = PVector.random2D().normalize();
//        scalarProjWall1 = scalarProj(walls[0]);
//        scalarProjWall2 = scalarProj(walls[1]);
//        scalarProjWall3 = scalarProj(walls[2]);
//        d2Wall1 = PVector.dist(p, scalarProjWall1);
//        d2Wall2 = PVector.dist(p, scalarProjWall2);
//        d2Wall3 = PVector.dist(p, scalarProjWall3);
//        hasBounced = false;
//    }

//    void update(){
//        p.add(v);
//        scalarProjWall1 = scalarProj(walls[0]);
//        scalarProjWall2 = scalarProj(walls[1]);
//        scalarProjWall3 = scalarProj(walls[2]);
//        d2Wall1 = PVector.dist(p, scalarProjWall1);
//        d2Wall2 = PVector.dist(p, scalarProjWall2);
//        d2Wall3 = PVector.dist(p, scalarProjWall3);
//        // check for distance from wall


//    }

//    PVector scalarProj(Wall w){
//        PVector ap = PVector.sub(p, w.start);
//        PVector ab = w.difference.copy();
//        ab.normalize(); // Normalize the line
//        ab.mult(ap.dot(ab));
//        PVector normalPoint = PVector.add(w.start, ab);
//        return normalPoint;
//    }



//    void show(){
//        ellipse(p.x, p.y, r, r);
//        line(p.x, p.y, scalarProjWall1.x, scalarProjWall1.y);
//        line(p.x, p.y, scalarProjWall2.x, scalarProjWall2.y);
//        line(p.x, p.y, scalarProjWall3.x, scalarProjWall3.y);

//    }
//}
