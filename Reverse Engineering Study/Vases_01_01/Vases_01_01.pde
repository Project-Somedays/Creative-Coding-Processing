// auto thumbnail generation script: https://timrodenbroeker.de/courses/sketching-with-code/thumbnails
// Reverse engineering this: https://openprocessing.org/sketch/2036461
// In this version, all vases are based on a single profile
String sketchname = getClass().getName();
int heightMin, heightMax;
int cols = 10;
float maxW, minW;
float offset = 20;
float yOff = 0.01;
float currentX = random(10000);
float[] profile;
ArrayList<Vase> vases;
int currentHStart;

void setup(){
    size(1080,1080);
    heightMin = int(height/15);
    heightMax = int(height/10);
    currentHStart = - heightMax; // start off the screen
    maxW = width/20;
    minW = width/50;
    profile = new float[height + 3*int(heightMax)];
    for(int i = 0; i < profile.length; i++){
      profile[i] = map(noise(currentX), 0, 1, minW, maxW);
      currentX += yOff;
    }

    vases = new ArrayList<Vase>();
    vases.add(new Vase(0, currentHStart, int(random(heightMin, heightMax))));
    
    for(int i = 0; i < cols; i++)
    currentHStart = -heightMax;
      while(currentHStart < height){
        // start the next based on the last of the  
        currentHStart += vases.get(vases.size()-1).h + offset;
        vases.add(new Vase(width/2, currentHStart, int(random(heightMin, heightMax))));
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
