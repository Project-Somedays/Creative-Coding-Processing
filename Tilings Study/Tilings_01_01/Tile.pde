
class Tile {
  PVector pos;
  TileType type;
  color col;
  Tile(float x, float y, TileType type_, color col_) {
    pos = new PVector(x, y);
    type = type_;
    col = col_;
  }

  void show() {
    pushMatrix();
    translate(pos.x + s/2, pos.y + s/2);
    
    switch(type) {
    case O:
      fill(col);
      stroke(col);
      rect(-s/2, -s/2, s, s);
      fill(bgCol);
      stroke(bgCol);
      rect(-s/6, -s/6, s/3, s/3);
      break;
    case H:
      fill(col);
      stroke(col);
      rect(-s/2, -s/2, s, s);
      fill(bgCol);
      stroke(bgCol);
      rect(-s/6,-s/2, s/3, s/3);
      rect(-s/6, s/6, s/3, s/3);
      break;
    case SideH:
      fill(col);
      stroke(col);
      rect(-s/2, -s/2, s, s);
      fill(bgCol);
      stroke(bgCol);
      rect(-s/2,-s/6, s/3, s/3);
      rect(s/6, -s/6, s/3, s/3);
      break;
    case UUP:
      fill(col);
      stroke(col);
      rect(-s/2,-s/2, s, s);
      fill(bgCol);
      stroke(bgCol);
      rect(-s/6, -s/2, s/3, 2*s/3);
      break;
    case ULEFT:
      fill(col);
      stroke(col);
      rect(-s/2,-s/2, s, s);
      fill(bgCol);
      stroke(bgCol);
      rect(-s/2, -s/6, 2*s/3, s/3);
      break;
    case URIGHT:
      fill(col);
      stroke(col);
      rect(-s/2,-s/2, s, s);
      fill(bgCol);
      stroke(bgCol);
      rect(-s/6, -s/6, 2*s/3, s/3);
      break;
    case UDOWN:
      fill(col);
      stroke(col);
      rect(-s/2,-s/2, s, s);
      fill(bgCol);
      stroke(bgCol);
      rect(-s/6, -s/6, s/3, 2*s/3);
      break;
    case PLUS:
      fill(bgCol);
      stroke(bgCol);
      rect(-s/2, -s/2, s, s);
      fill(col);
      stroke(col);
      rect(-s/6, -s/2, s/3, s);
      rect(-s/2, -s/6, s, s/3);
      break;
    default:
      break;
    }
    popMatrix();
  }
}
