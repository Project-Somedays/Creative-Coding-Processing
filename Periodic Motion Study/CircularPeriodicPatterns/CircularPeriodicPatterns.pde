float r, a, diam;
int count;

void setup() {
  size(720, 720);
  a = 0;
  count = 12;
  diam = 20;
  noStroke();
  fill(255);
}

void draw() {
  background(0);
  pushMatrix();
  translate(width/2, height/2);
  for (int i = 0; i < count; i++) {
    float r = width/4 + (width/8)*cos(a);
    float x = r*cos(TWO_PI*i/count - a);
    float y = r*sin(TWO_PI*i/count - a);
    ellipse(x, y, diam, diam);
  }

  for (int i = 0; i < count; i++) {
    float r = width/4 + (width/8)*sin(a);
    float x = r*cos(TWO_PI*i/count - a + PI/4);
    float y = r*sin(TWO_PI*i/count - a + PI/4);
    ellipse(x, y, diam, diam);
  }
  
 for (int i = 0; i < count; i++) {
    float r = width/3 + (width/8)*cos(a);
    float x = r*cos(TWO_PI*i/count - a);
    float y = r*sin(TWO_PI*i/count - a);
    ellipse(x, y, diam, diam);
  }
  
  for (int i = 0; i < count; i++) {
    float r = width/3 + (width/8)*sin(a);
    float x = r*cos(TWO_PI*i/count - a + PI/4);
    float y = r*sin(TWO_PI*i/count - a + PI/4);
    ellipse(x, y, diam, diam);
  }



  popMatrix();
  a += 0.02;
}

void keyPressed(){

  if(keyCode == ' '){
    saveFrame("../"+ getClass().getName() + ".png");
  }
}
