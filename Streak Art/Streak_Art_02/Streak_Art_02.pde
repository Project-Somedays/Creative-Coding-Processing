// auto thumbnail generation script: https://timrodenbroeker.de/courses/sketching-with-code/thumbnails/
// straw blowing
String sketchname = getClass().getName();
color[] colours = {#1be7ff, #6eeb83, #e4ff1a, #ffb800, #ff5714};
ArrayList<Splotch> splotches;
int n = 8;
float res;

float inc;


void setup(){
    size(1080,1080);
    noStroke();
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
  
  
  for(Splotch s: splotches){
      s.show();
    }
  
  

   //squeegee.update();
   ////squeegee.show();


  if (frameCount ==  120) {
    saveFrame("../" + sketchname + ".png");
  }
}

//void mouseDragged(){
//  for(Splotch s: splotches){
//    float d = PVector.dist(s.pos, squeegee.c);
//    float a = PVector.sub(squeegee.c, s.pos).heading();
//    if(abs(d*cos(a)) < squeegee.img.width/2 && abs(d*sin(a)) < squeegee.img.height/10){
//      s.update();
//    }
//  }
//}
