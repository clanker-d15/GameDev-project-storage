enum State {
  Broken, Unbroken
}

class Barrier {
  int x, y, w, h, wallType, health;
  PImage thinWall, basicWall, toughWall;
  boolean Collision;

  void setup() {
    x = int(random(75, 825));
    y = int(random(75, 825));
    w = int(random(5, 30));
    h = int(random(45, 125));

    wallType = int(random(0, 3));
    health = 0;

    //thinWall = loadImage("");
    //basicWall = loadImage("");
    //toughWall = loadImage("");
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
  }

  void update() {

    if (wallType == 1) {
      
    }
    if (wallType == 2) {
      
    }
    if (wallType == 3) {
      
    }
  }

  boolean Collision() {
    return true;
  }
}
