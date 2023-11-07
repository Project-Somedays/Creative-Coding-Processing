// auto thumbnail generation script: https://timrodenbroeker.de/courses/sketching-with-code/thumbnails
// Reverse engineering this: https://openprocessing.org/sketch/2036461
// In this version, all vases are based on a single profile, but stored in the Vase objects themselves

String sketchname = getClass().getName();
int heightMin, heightMax;
int cols = 10;
float maxW, minW;
int offset = 20;
float yOff = 0.01;
float currentX = random(10000);
float[] profile;

int currentHStart;
ArrayList<ArrayList<Vase>> collection;
color[] colours = {#f72585, #b5179e, #7209b7, #560bad, #480ca8, #3a0ca3, #3f37c9, #4361ee, #4895ef, #4cc9f0};

void setup() {
  size(1000, 1000);
  heightMin = int(height/15);
  heightMax = int(height/10);
  currentHStart = - heightMax; // start off the screen
  maxW = width/20;
  minW = width/50;
  profile = new float[height + 3*int(heightMax)];
  collection = new ArrayList<ArrayList<Vase>>();

  // make the base profile
  for (int i = 0; i < profile.length; i++) {
    profile[i] = map(noise(currentX), 0, 1, minW, maxW);
    currentX += yOff;
  }
  
  // for each column
  for (int i = 0; i < cols + 1; i++) {
    ArrayList<Vase> vases = new ArrayList<Vase>();
   
    vases.add(new Vase(i*width/cols, currentHStart, int(random(heightMin, heightMax))));
    currentHStart = -heightMax;
    while (currentHStart < height) {
      // start the next based on the last of the
      currentHStart += vases.get(vases.size()-1).h + offset;
      vases.add(new Vase(i * width/cols, currentHStart, int(random(heightMin, heightMax))));
    }
    collection.add(vases);
  }

}

void draw() {
  background(0);
  for(int i = 0; i < collection.size(); i++){
    for(int j = 0; j < collection.get(i).size(); j++){
      collection.get(i).get(j).show();
    }
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
