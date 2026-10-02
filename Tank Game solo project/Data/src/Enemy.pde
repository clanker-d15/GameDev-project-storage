class Enemy {
  int x, y, health, hitPoints, speed, angle, turretAngle, reload, shootDelay;
  PImage e1Base, e1Turret;
  color c;


  // Contructor
  Enemy(int x, int y) {
    this.x = x;
    this.y = y;
    health = 850;
    hitPoints = 60;
    c = (50);
    e1Base = loadImage("TankBase.png");
    e1Turret = loadImage("TankTurret.png");
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
