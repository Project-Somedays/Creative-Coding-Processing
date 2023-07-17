class Squeegee{
  PImage img;
  PVector c;
  float a = 0;
  Squeegee(){
    img = loadImage("../"+"squeegee.png");
    c = new PVector(width/2, 0);
  }
  
  void update(){
    c.set(mouseX, mouseY);
  }
  
  void rot(float a_){
    a += a_;
  }
  
  void show(){
    pushMatrix();
    translate(c.x, c.y);
    rotate(a);
    user.image(img, -img.width/2, 0);
    popMatrix();
  }
}
