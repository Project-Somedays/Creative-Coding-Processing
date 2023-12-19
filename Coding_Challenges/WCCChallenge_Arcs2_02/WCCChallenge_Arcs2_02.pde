// auto thumbnail generation script: https://timrodenbroeker.de/courses/sketching-with-code/thumbnails/
import java.util.UUID;

String sketchname = getClass().getName();
HashMap<String, ArrayList<Particle>> gridLookup;

int gridRes = 10;
float res;
int n = 100;
Particle[] particles;
float noiseZoomFactor = 300;
float noiseEvol = 0;
float noiseEvolRate = 0.01;
float r = 10;
float d;
float chargeDrop = 50;

void setup() {
  size(1000, 1000);
  gridLookup = new HashMap<String, ArrayList<Particle>>();
  res = width/gridRes;
  d = 2*r;
  
  stroke(0);
  fill(0);
  textSize(50);
  textAlign(CENTER, CENTER);

  // make the array of particles
  particles = new Particle[n];
  for (int i = 0; i < n; i++) {
    particles[i] = new Particle(random(width), random(height));
  }
  println("Made a field of random particles!");
  // set up each grid Square with an array List to hold particles
  for (int i = 0; i < gridRes; i++) {
    for (int j = 0; j < gridRes; j++) {
      String gridKey = getKeyFromGridCoords(i, j);
      gridLookup.put(gridKey, new ArrayList<>());
    }
  }
  println(gridLookup);
  println("Categorising particles");


  stroke(0);

  //println(cellRelations);
}

void draw() {
  background(255);
  //text(getKey(new PVector(mouseX, mouseY)), width/2, height/2);
  
  // move the particles
  for (Particle p : particles) {
    p.update();
    constrain(p.p.x, r, width-r);
    constrain(p.p.y, r, height-r);
    p.show();
  }
  remap();
  showArcs();
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
  //println("Purging arraylists");
  for (int i = 0; i < gridRes; i++) {
    for (int j = 0; j < gridRes; j++) {
      String gridKey = getKeyFromGridCoords(i, j);
      gridLookup.get(gridKey).clear();
    }
  }

  // categorise them by box
  for (Particle p : particles) {
    String particleKey = getKey(p.p);
    println("Particle key: " + particleKey);
    gridLookup.get(particleKey).add(p);
  }
}

String getKey(PVector p) {
  println("p: " + p);
  return "("+str(floor(p.x/res)) + ", " + str(floor(p.y/res)) +")";
}

String getKeyFromGridCoords(int i, int j){
  return "("+str(i) + ", " + str(j) +")";
}

String generateGUID() {
  UUID uuid = UUID.randomUUID();
  return uuid.toString();
}

void showArcs() {
  for (int i = 0; i < gridRes; i++) {
    for (int j = 0; j < gridRes; j++) {
      //println("Working with x = " + i + ", y = " + j);
      //println("That's gridKey " + gridKey);
      String gridKey = getKeyFromGridCoords(i,j);
      // for each particle in that box
      for (Particle p : gridLookup.get(gridKey)) {
        for (int k = -1; k < 2; k++) {
          for (int l = -1; l < 2; l++) {
            //println("Evaluating k = " + k + ", l = " + l + ". Here, i + k = " + str(i+k) + ", j + l = " + str(j + l));
            if (i + k < 0  || j + l >= gridRes ||i + k >= gridRes || j + l < 0) {
              //println("This one is off the grid... continuing on...");
              continue;
            }
            String neighbourGridKey =getKeyFromGridCoords(i + k,j +l );
            // for each box, pull up the particles
            for (Particle q : gridLookup.get(neighbourGridKey)) {
              if (p.charge > 80 && q.charge > 80) {
                line(p.p.x, p.p.y, q.p.x, q.p.y);
                p.charge -= chargeDrop;
              }
            }
          }
        }
      }
    }
  }
}
