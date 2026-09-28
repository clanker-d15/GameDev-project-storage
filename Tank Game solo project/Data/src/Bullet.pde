class Bullet {
  int x, y, w, h, speed, damage;

  Bullet(int x, int y) {
    this.x = x;
    this.y = y;
    w = 6;
    h = 15;
    speed = 5;
    damage = 30;
  }

  void display() {
    fill(#F0A327);
    rectMode(CENTER);
    rect(x, y, w, h);
  }

  boolean isOffScreen() {
    if (x>width+10 || x<width-10 || y>height+10 || y<height-10) {
      return true;
    } else {
      return false;
    }
  }

  boolean isHit(Tank t) {
    float d = dist(x, y, t.x, t.y);
    if (d<40) {
      return true;
    } else {
      return false;
    }
  }
}
