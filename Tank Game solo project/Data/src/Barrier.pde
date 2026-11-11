enum State {
  Broken, Unbroken
}

class Barrier {
  int x, y, w, h, wallType, thinWallHealth, basicWallHealth, toughWallHealth;
  PImage thinWall, basicWall, toughWall, invincibleWall;
  boolean Collision;

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

     State currentState = State.Unbroken;
  }

  void draw() {
    if (wallType == 1) {
      image(thinWall, x, y, w, h);
    }
    if (wallType == 2) {
      image(basicWall, x, y, w, h);
    }
    if (wallType == 3) {
      image(toughWall, x, y, w, h);
    }
    if (wallType == 4) {
      image(invincibleWall, x, y, w, h);
    }
  }

  void update() {
    if (thinWallHealth < 0) {
      switch(currentState) {
        case Broken:
      
        break;
      }
    } else {
      switch(currentState) {
        case Unbroken:
      
        break;
      }
    }
    if (basicWallHealth < 0) {
      switch(currentState) {
        case Broken:
      
        break;
      }
    } else {
      switch(currentState) {
        case Unbroken:
      
        break;
      }
    }
    if (toughWallHealth < 0) {
      switch(currentState) {
        case Broken:
      
        break;
      }
    } else {
      switch(currentState) {
        case Unbroken:
      
        break;
      }
    }


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
