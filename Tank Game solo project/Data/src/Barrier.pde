class Barrier {
  int x, y, w, h, wallType;
  PImage thinWall, basicWall, toughWall, invincibleWall;
  boolean Collision

  void setup() {
    x = int(random(75, 825));
    y = int(random(75, 825));
    w = int(random(5, 30));
    h = int(random(45, 125));

    wallType = int(random(0, 4));

    thinWall = loadImage("");
    basicWall = loadImage("");
    toughWall = loadImage("");
    invincibleWall = loadImage("");
  }

  void draw() {
    if (wallType == 1) {
      Image(thinWall, x, y, w, h);
      
    }
    if (wallType == 2) {
      Image(basicWall, x, y, w, h);
      
    }
    if (wallType == 3) {
      Image(toughWall, x, y, w, h);
      
    }
    if (wallType == 4) {
      Image(invincibleWall, x, y, w, h);
      
    }
  }

  boolean Collision() {
    return true;
  }
}
