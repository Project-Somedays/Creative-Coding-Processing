// auto thumbnail generation script: https://timrodenbroeker.de/courses/sketching-with-code/thumbnails/
String sketchname = getClass().getName();
PVector lineStart, lineEnd, step, half_step, lineNormal, pos;
float D;
int n;

void setup(){
    size(1080,1080);
    D = 25;
    lineStart = new PVector(0, random(height));
    lineEnd = new PVector(width, random(height));
    step = PVector.sub(lineEnd, lineStart).setMag(D);
    half_step = step.copy().setMag(D/2);
    lineNormal = PVector.fromAngle(step.heading() - HALF_PI).setMag(D*sin(THIRD_PI));
    pos = lineStart.copy();
    n = int(width*sqrt(2)/D) + 1;
    noStroke();
    fill(255);
    background(0);
  for(int i = 0; i < n; i++){
    // draw circle on the line
    ellipse(pos.x, pos.y, D, D);
    pos.add(half_step);
    PVector alt = pos.copy();
    alt.add(lineNormal);
    ellipse(alt.x, alt.y, D, D);
    pos.add(half_step);
    
  }
}

void draw(){
  

  if (frameCount ==  120) {
    saveFrame("../" + sketchname + ".png");
  }
}
