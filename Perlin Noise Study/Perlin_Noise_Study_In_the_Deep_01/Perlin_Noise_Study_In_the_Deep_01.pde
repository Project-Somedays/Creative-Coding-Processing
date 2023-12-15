// auto thumbnail generation script: https://timrodenbroeker.de/courses/sketching-with-code/thumbnails/
String sketchname = getClass().getName();
int n = 200;
PVector[] field;
Brush[] brushes;
float step = 0.01;
int brushCount = 3;
float D,r;

void setup(){
    size(1080,1080);
    D = width/12;
    r = D/2;
    stroke(255,5);
    
    field = new PVector[n];
    for(int i = 0; i < n; i++){
      field[i] = new PVector(random(width), random(height));
    }
    
    brushes = new Brush[brushCount];
    for(int i = 0; i < brushes.length; i++){
      brushes[i] = new Brush();
    }
    background(#0D1126);
}

void draw(){
  for(Brush b: brushes){
    b.update();
    drawChords(b);
  }

  if (frameCount ==  120) {
    saveFrame("../" + sketchname + ".png");
  }
}

void drawChords(Brush b){
  for(int i = 0; i < field.length; i++){
    float d = PVector.dist(field[i], b.p);
    if(d > D){
      continue;
    }
    // get the heading from the circle to the centre of the brush
    float aSys = PVector.sub(b.p, field[i]).heading();
    float a = acos(d/D);
    
    // draw the chord of intersection points
    pushMatrix();
      translate(field[i].x, field[i].y);
      rotate(aSys);
      line(r*cos(a), r*sin(a), r*cos(a), r*sin(-a)); 
    popMatrix();
  }
}

void keyPressed() {
  if (keyCode == ' ') {
    noLoop();
    saveFrame(sketchname + "_" + year()+"-"+month()+"-"+day()+"_"+hour()+"-"+minute()+"-"+second() + ".png");
  }
}
