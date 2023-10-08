// auto thumbnail generation script: https://timrodenbroeker.de/courses/sketching-with-code/thumbnails/
// art from <a href="https://www.freepik.com/free-vector/nuclear-symbols-white-background_39653893.htm#query=nuclear%20reactor&position=2&from_view=keyword&track=ais">Image by brgfx</a> on Freepik
String sketchname = getClass().getName();
PImage powerplant;

void setup(){
    size(1080,1080);
    powerplant = loadImage("PowerPlant.png");
}

void draw(){
  background(0);
  image(powerplant,width/2 - powerplant.width/2, height/2 - powerplant.height/2);

  if (frameCount ==  120) {
    saveFrame("../" + sketchname + ".png");
  }
}
