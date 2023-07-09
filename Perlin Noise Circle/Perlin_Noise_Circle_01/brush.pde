class Brush{
  PVector pos;
  color col;
  Brush(color col_){
    pos = generateSpawnPoint();
    col = col_;
  }
  
  void update(){
    PVector toAdd = ff[int(pos.x)][int(pos.y)];
    pos.add(toAdd);
    if(PVector.dist(pos, c) > r){
      pos = generateSpawnPoint();
    }
  }
  
  void show(){
    stroke(col);
    strokeWeight(5);
    point(pos.x, pos.y);
  }
  
  
}
