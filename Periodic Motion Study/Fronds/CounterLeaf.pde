class CounterLeaf extends Leaf {
  CounterLeaf(float scale_, float offset_, float threshold_, color col_) {
    super(scale_, offset_, threshold_, col_);
  }

  void update() {

    if (globA > threshold) {
      if (a <= -HALF_PI) {
        a = HALF_PI + PI/6*sin(globA-threshold);
      } else {
        a = HALF_PI + PI/3*sin(globA-threshold);
      }
      start.set(rs*cos(-a), rs*sin(-a));
      end.set(R*cos(-a), R*sin(-a));
      left.set(r*cos(-a - PI/4), r*sin(-a - PI/4));
      right.set(r*cos(-a + PI/4), r*sin(-a + PI/4));
    }
  }
}
