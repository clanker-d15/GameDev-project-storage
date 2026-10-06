class HeavyEnemyTank {
  int x, y, health, hitPoints, speed, angle, turretAngle, reload, shootDelay;
  PImage e1Base, e1Turret;
  color c;


  // Contructor
  HeavyEnemyTank(int x, int y) {
    this.x = x;
    this.y = y;
    health = 850;
    hitPoints = 60;
    c = (50);
    Base = loadImage("TankBase.png");
    Turret = loadImage("TankTurret.png");
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
