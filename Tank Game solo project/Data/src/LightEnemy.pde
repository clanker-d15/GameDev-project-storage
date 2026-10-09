class LightEnemy {
  int x, y, health, damage, speed, angle, turretAngle, reload, shootDelay;
  PImage tank;

  // Contructor
  LightEnemy(int x, int y) {
    this.x = x;
    this.y = y;
    health = 325;
    damage = 30;
  }

  // Member Methods
  void display() {
    if (health > 0) {
    } else {
    }
  }

  void update() {
  }

  void move(int tempX, int tempY) {
    x = tempX;
    y = tempY;
  }

  boolean isHit() {
    return true;
  }
}
