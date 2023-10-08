// auto thumbnail generation script: https://timrodenbroeker.de/courses/sketching-with-code/thumbnails/
String sketchname = getClass().getName();
PVector lineStart, lineEnd, step, half_step, lineNormal, pos;
float D;
int n;
AltLine test;

void setup(){
    size(1080,1080);
    D = 50;
    lineStart = new PVector(0, random(height));
    lineEnd = new PVector(width, random(height));
    step = PVector.sub(lineEnd, lineStart).setMag(D);
    half_step = step.copy().setMag(D/2);
    lineNormal = PVector.fromAngle(step.heading() - HALF_PI).setMag(D*sin(THIRD_PI)*2);
    pos = lineStart.copy();
    n = int(width*sqrt(2)/D) + 1;
    noStroke();
    
    fill(255);
    background(0);
    test = new AltLine(0, random(height), width, random(height));
    test.show();
  //for(int i = 0; i < n; i++){
  //  // draw circle on the line
  //  ellipse(pos.x, pos.y, D, D);
  //  pos.add(half_step);
  //  PVector alt = pos.copy();
  //  alt.add(lineNormal);
  //  ellipse(alt.x, alt.y, D, D);
  //  pos.add(half_step);
    
  //}
}

class AltLine{
  PVector start, end, dir, lStep, rStep;
  AltLine(float xStart, float yStart, float xEnd, float yEnd){
    start = new PVector(xStart, yStart);
    end = new PVector(xEnd, yEnd);
    dir = PVector.sub(lineEnd, lineStart).normalize();
    lStep = PVector.fromAngle(dir.heading() - THIRD_PI).setMag(D*sin(THIRD_PI)*1.15);
    rStep = PVector.fromAngle(dir.heading() + THIRD_PI).setMag(D*sin(THIRD_PI)*1.15);
  }
  
  void show(){
    PVector tempStart = start.copy();
    ellipse(tempStart.x, tempStart.y, D, D);
    for(int i = 0; i < n; i++){
       tempStart.add(lStep);
       ellipse(tempStart.x, tempStart.y, D, D);
       tempStart.add(rStep);
       ellipse(tempStart.x, tempStart.y, D, D);
    }
    }
}

void draw(){
  

  if (frameCount ==  120) {
    saveFrame("../" + sketchname + ".png");
  }
}
