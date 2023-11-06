// auto thumbnail generation script: https://timrodenbroeker.de/courses/sketching-with-code/thumbnails
// Reverse engineering this: https://openprocessing.org/sketch/2036461
String sketchname = getClass().getName();
float heightMin, heightMax;
int cols = 10;
float maxW;
float offset = 10;
ArrayList<Vase> vases;
float currentHStart = 0;
void setup(){
    size(1080,1080);
    heightMin = height/10;
    heightMax = height/6;
    maxW = (width-(cols+1)*offset)/cols;
    vases = new ArrayList<Vase>();
    vases.add(new Vase(width/2, currentHStart));
    
    while(currentHStart < height){
      // start the next 
      currentHStart += vases.get(vases.size()-1).h + offset;
      vases.add(new Vase(width/2, currentHStart));
    }
    
    
}

void draw(){
  background(0);
  for(Vase v: vases){
    v.show();
  }
  if (frameCount ==  120) {
    saveFrame("../" + sketchname + ".png");
  }
}

void keyPressed() {
  if (keyCode == ' ') {
    noLoop();
    saveFrame(sketchname + "_" + year()+"-"+month()+"-"+day()+"_"+hour()+"-"+minute()+"-"+second() + ".png");
  }
}
