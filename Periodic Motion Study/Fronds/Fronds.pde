Leaf leaf;
Leaf[] leafs;
CounterLeaf[] counterLeafs;
//320°, 55%, 92%
float globA;
void setup() {
  size(1080, 1080);
  colorMode(HSB, 360, 100, 100);
  //leaves = new Leaf[10];
  leafs = new Leaf[40];
  counterLeafs = new CounterLeaf[40];
  leafs[0] = new Leaf(1, 0, 0, color(320,55, 92 - 0*92/leafs.length));
  counterLeafs[0] = new CounterLeaf(1, 0, 0, color(320,55, 92 - 0*92/leafs.length));
  for (int i = 1; i < leafs.length; i++){
    float offset = -PI/6 + i*PI/3/leafs.length;
    leafs[i] = new Leaf(leafs[i-1].scale+0.1,offset,i*PI/leafs.length, color(320,55,92 - i*92/leafs.length));
    counterLeafs[i] = new CounterLeaf(counterLeafs[i-1].scale+0.1,offset,i*QUARTER_PI/leafs.length, color(320,55,92 - i*92/leafs.length));
  }
  //noLoop();
}

void draw() {
  background(0);
    translate(width/2, height/2);
    for(int i = 0; i < leafs.length; i++){
      leafs[i].update();
      counterLeafs[i].update();
    }
    
    
    for(int i = leafs.length - 1 ; i > 0; i--){
      
      for(int j = 0; j < 3; j++){
        pushMatrix();
        rotate(j * TWO_PI/3);
        leafs[i].show();
        counterLeafs[i].show();
        popMatrix();
      }
    }
    
    globA += TWO_PI/300; // equivalent to 0.02;
}

void keyPressed(){
  if(keyCode == ENTER){
    loop();
  }
  if(keyCode == ' '){
    saveFrame("../"+ getClass().getName() + ".png");
  }
}
