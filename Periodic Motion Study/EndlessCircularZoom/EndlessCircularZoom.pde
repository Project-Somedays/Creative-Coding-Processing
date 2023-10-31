/*
Circle in centre
 New circle is generated offset from the radius by the radius of the new circle
 https://cre8math.com/2017/10/02/creating-animated-gifs-in-processing/
 
 Choose from
 Black (0)
 Red   (255,  0,  0);
 Green (0,  255,  0);
 Blue  (0,  0,  255);
 Yellow (255,  255,  0);
 Cyan  (0,  255,  255);
 Magenta  (255,  0,  255);
 
 
 
 */

float D, a, increment, steps;
boolean isScenario1;
float period, offset;
ArrayList<Circle> circles;
int colPos = 2;
int multCycle = 2;
int maxCols = 3;
int maxCycles = 3;
color[] cols = {
  color(0),
  color(255, 0, 0),
  color(0, 255, 0),
  color(0, 0, 255),
  color(255, 255, 0),
  color(255, 0, 255),
  color(0, 255, 255)
  };


void setup() {
    size(720, 720);
D = 500;
a = 0;
increment = 0.05;
steps = D/increment;
isScenario1 = true;
period = 4*TWO_PI;
offset = PI/2;
circles = new ArrayList<Circle>();
// load the first circle
Circle first = new Circle(cols[0],1);
first.d = D;
first.isFinished = true;
circles.add(first);

// load the second circle
circles.add(new Circle(cols[1],1));


noStroke();
}

void draw() {
  background(255);

  pushMatrix();
  translate(width/2, height/2);
  circles.get(0).show();
  for (int i = 1; i < circles.size(); i++) {
    circles.get(i).show();
  }

  // look at the last circle
  // if the counter is greater than TWO_PI, gen new circle
  if (circles.get(circles.size()-1).t > TWO_PI) {
    circles.add(new Circle(cols[colPos%maxCols],multCycle%maxCycles));
    colPos += 1;
    multCycle += 1;
  }

  popMatrix();

  //a += increment;
  //renderV1();

  // keep the array from getting too big
  if (circles.size() > 5) {
    circles.remove(0);
  }
}

void renderV1() {
  pushMatrix();
  translate(width/2, height/2);
  if (isScenario1) {
    fill(255, 0, 0);
  } else {
    fill(0);
  }
  ellipse(0, 0, D, D);
  if (isScenario1) {
    fill(0);
  } else {
    fill(255, 0, 0);
  }
  float d = D*a/period;
  ellipse((D/2-d/2)*cos(-a-offset), (D/2 - d/2)*sin(-a-offset), d, d);
  popMatrix();

  a += increment;
  if (a > period) {
    a = 0;
    isScenario1 = !isScenario1;
  }
}

void keyPressed(){
  if(keyCode == ' '){
    saveFrame("../"+ getClass().getName() + ".png");
  }
}
