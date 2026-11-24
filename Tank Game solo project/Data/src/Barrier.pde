enum State {
  Broken, Unbroken
}

class Barrier {
  int x, y, w, h, wallType, health;
  PImage thinWall, basicWall, toughWall, invincibleWall;
  boolean Collision;

  void setup() {
    x = int(random(75, 825));
    y = int(random(75, 825));
    w = int(random(5, 30));
    h = int(random(45, 125));

    wallType = int(random(0, 4));
    health = 0;

    thinWall = loadImage("");
    basicWall = loadImage("");
    toughWall = loadImage("");
    invincibleWall = loadImage("");
  }

  void draw() {
    //if (wallType == 1) {
    //  image(thinWall, x, y, w, h);
    //  health = 100;
    //}
    //if (wallType == 2) {
    //  image(basicWall, x, y, w, h);
    //  health = 250;
    //}
    //if (wallType == 3) {
    //  image(toughWall, x, y, w, h);
    //  health = 600;
    //}
    //if (wallType == 4) {
    //  image(invincibleWall, x, y, w, h);
    //  health = 2147483646;
    //}
  }

  void update() {

    if (wallType == 1) {
    }
    if (wallType == 2) {
    }
    if (wallType == 3) {
    }
    if (wallType == 4) {
    }
  }

  boolean Collision() {
    return true;
  }
}
