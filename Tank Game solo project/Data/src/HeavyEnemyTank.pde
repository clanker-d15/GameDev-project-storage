class HeavyEnemy {
  int x, y, health, damage, speed, angle, turretAngle, reload, shootDelay;
  PImage tank;

  // Contructor
  HeavyEnemy(int x, int y) {
    this.x = x;
    this.y = y;
    health = 900;
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

  //boolean isHit() {
  //}
}
