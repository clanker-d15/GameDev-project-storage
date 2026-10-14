class Barrier {
  int x, y, w, h, wallType;
  PImage thinWall, basicWall, toughWall, invincibleWall;

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
    
    
  }
  
}
