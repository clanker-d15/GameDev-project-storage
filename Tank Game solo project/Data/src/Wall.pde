class Wall {
  int x, y, w, h;

  boolean colliding;

  void setup() {
    x = int(random(0, 800));
    y = int(random(0, 800));
    w = int(random(0, 100));
    h = int(random(0, 100));
  }
}
