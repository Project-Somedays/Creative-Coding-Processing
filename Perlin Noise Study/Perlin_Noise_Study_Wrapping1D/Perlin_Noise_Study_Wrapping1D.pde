float r;
float xOff;
float a;
int ptCount;
int col;
void setup() {
  size(1000, 1000);
  colorMode(HSB, 360, 255, 255);
  r = 2*width/3;
  //xOff = random(1000);
  a = 0;
  background(0);
  col = 1;
  
  noFill();
  ptCount = 360;
}

void draw() {
  pushMatrix();
  translate(width/2, height/2);
  stroke(col,255,255,20);
  beginShape();
  for (int i=0; i<ptCount; i++) {
    float noiseFactor = noise(i*0.02, xOff);
    float x = r*cos(i*TWO_PI/ptCount)*noiseFactor;
    float y = r*sin(i*TWO_PI/ptCount)*noiseFactor;
    curveVertex(x, y);
  }
  endShape(CLOSE);
  popMatrix();
  r -= 0.5;
  if (r == 0) {
    save("AwesomeSauce2.png");
    noLoop();
    
  }
  xOff+=0.01;
  col = (col + 1)%360;
}
