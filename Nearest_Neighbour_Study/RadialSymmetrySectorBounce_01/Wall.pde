class Wall{
    PVector start, end, difference;
    float a;
    int ix;
    Wall(float startX, float startY, float endX, float endY, int ix_){
        start = new PVector(startX, startY);
        end = new PVector(endX, endY);
        difference = PVector.sub(end, start);
        a = difference.heading();
        ix = ix_;
        
    }

    void show(){
        stroke(255);
        strokeWeight(5);
        line(start.x, start.y, end.x, end.y);
    }
}
