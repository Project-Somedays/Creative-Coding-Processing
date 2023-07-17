// auto thumbnail generation script: https://timrodenbroeker.de/courses/sketching-with-code/thumbnails/
// the intent here is to let the user smear the things
PGraphics canvas, user;
String sketchname = getClass().getName();
color[] colours = {#1be7ff, #6eeb83, #e4ff1a, #ffb800, #ff5714};
ArrayList<Splotch> splotches;
int n = 8;
float res;
Squeegee squeegee;
float inc;


void setup(){
    size(1080,1080);
    canvas = createGraphics(width, height);
    canvas.noStroke();
    user = createGraphics(width, height);
    noStroke();
    squeegee = new Squeegee();
    inc = TWO_PI/500;
    res = width/(n+1);
    splotches = new ArrayList<Splotch>();
    for(int i = 0; i < 8; i++){
      for(int j = 0; j < 8; j++){
        splotches.add(new Splotch((i+1)*res, (j+1)*res, colours[int(random(0,colours.length))]));
      }
    }
    
    background(0);
}

void draw(){
  
  canvas.beginDraw();
  for(Splotch s: splotches){
      s.show();
    }
  canvas.endDraw();
  
  user.beginDraw();
   user.clear();
   squeegee.update();
   //squeegee.show();
  user.endDraw();
  
  image(canvas, 0,0);
  image(user, 0,0);

  if (frameCount ==  120) {
    saveFrame("../" + sketchname + ".png");
  }
}

void mouseDragged(){
  for(Splotch s: splotches){
    float d = PVector.dist(s.pos, squeegee.c);
    float a = PVector.sub(squeegee.c, s.pos).heading();
    if(abs(d*cos(a)) < squeegee.img.width/2 && abs(d*sin(a)) < squeegee.img.height/10){
      s.update();
    }
  }
}

void keyPressed(){
  switch(keyCode){
    case LEFT: 
      squeegee.rot(inc);
      println("Squeegee angle: ", squeegee.a);
      break;
    case RIGHT:
      squeegee.rot(-inc);
      println("Squeegee angle: ", squeegee.a);
      break;
    default:
      break;
  }
}
