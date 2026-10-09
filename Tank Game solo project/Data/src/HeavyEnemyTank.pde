class HeavyEnemy {
  int x, y, health, damage, speed, angle, turretAngle, reload, shootDelay;
  PImage base, turret;

  // Contructor
  HeavyEnemy(int x, int y) {
    this.x = x;
    this.y = y;
    health = 1000;
    damage = 30;
    base = loadImage("HeavyEnemyBase.png");
    turret = loadImage("HeavyEnemyTurret.png");
    speed = 3;
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
