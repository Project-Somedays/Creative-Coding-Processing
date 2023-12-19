// auto thumbnail generation script: https://timrodenbroeker.de/courses/sketching-with-code/thumbnails/
import java.util.UUID;

String sketchname = getClass().getName();
HashMap<String, ArrayList<PVector>> gridLookup;
HashMap<String, ArrayList<String>> cellRelations;
int gridRes = 15;
float res;
int n = 500;
Particle[] particles;
float noiseZoomFactor = 300;
float noiseEvol = 0;
float noiseEvolRate = 0.01;

void setup() {
  size(1000, 1000);
  gridLookup = new HashMap<String, ArrayList<PVector>>();
  cellRelations = new HashMap<String, ArrayList<String>>();
  res = width/gridRes;
  particles = new Particle[n];
  stroke(0);
  fill(0);
  textSize(50);
  textAlign(CENTER, CENTER);
  for (int i = 0; i < n; i++) {
    particles[i] = new Particle(random(width), random(height));
  }
  for (int i = 0; i < gridRes; i++) {
    for (int j = 0; j < gridRes; j++) {
      String gridKey = str(i) + str(j);
      gridLookup.put(gridKey, new ArrayList<>());
    }
  }
  for (int i = 0; i < gridRes; i++) {
    for (int j = 0; j < gridRes; j++) {
      //println("Working with x = " + i + ", y = " + j);
      String gridKey = str(i) + str(j);
      //println("That's gridKey " + gridKey);
      cellRelations.put(gridKey, new ArrayList<>());
      for (int k = -1; k < 2; k++) {
        for (int l = -1; l < 2; l++) {
          //println("Evaluating k = " + k + ", l = " + l + ". Here, i + k = " + str(i+k) + ", j + l = " + str(j + l));
          if (i + k < 0  || j + l >= gridRes ||i + k >= gridRes || j + l < 0) {
            //println("This one is off the grid... continuing on...");
            continue;
          }
          //println("Adding to the map");
          cellRelations.get(gridKey).add(str(i+k) + str(j + l)); // add the surrounding cells
        }
      }
    }
  }
  //println(cellRelations);
}

void draw() {
  background(255);
  //text(getKey(new PVector(mouseX, mouseY)), width/2, height/2);
  //remap();
  for(Particle p : particles){
    p.update();
    p.show();
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
  noiseEvol += noiseEvolRate;
}

void remap() {
  // wipe all the arrayLists
  for (int i = 0; i < gridRes; i++) {
    for (int j = 0; j < gridRes; j++) {
      String gridKey = str(i) + str(j);
      gridLookup.get(gridKey).clear();
    }
  }
  // categorise them by box
  for(Particle p: particles){
    String particleKey = getKey(p.p);
    gridLookup.get(particleKey).add(p.p);
  }
}

String getKey(PVector p) {
  return str(int(p.x/res)) + str(int(p.y/res));
}

String generateGUID(){
  UUID uuid = UUID.randomUUID();
  return uuid.toString();
}

void showArc(PVector p){
  // lookup the current grid reference
  String gridAddress = getKey(p);
  for(ArrayList<String> toCheck : cellRelations.get(gridAddress)){
    
  }
  // loop through all the neighbouring cells
  //for(int i = 0; i < cellRelations.get(gridAddress).size(); i++){
  //  ArrayList<String> address = cellRelations.get(gridAddress);
  //  for(int j = 0; j < gridLookup.get(address).size(); j++){
  //    PVector q = gridLookup.get(address).get(i);
  //  }
  //}
}

boolean isArcing(){
  
}
