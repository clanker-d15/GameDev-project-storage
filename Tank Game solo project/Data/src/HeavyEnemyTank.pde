class HeavyEnemyTank {
  int x, y, health, hitPoints, speed, angle, turretAngle, reload, shootDelay;
  PImage HeavyEnemyBase, HeavyEnemyTurret;
  color c;


  // Contructor
  HeavyEnemyTank(int x, int y) {
    this.x = x;
    this.y = y;
    health = 900;
    hitPoints = 60;
    c = (50);
    HeavyEnemyBase = loadImage("HeavyEnemyBase.png");
    HeavyEnemyTurret = loadImage("HeavyEnemyTurret.png");
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
