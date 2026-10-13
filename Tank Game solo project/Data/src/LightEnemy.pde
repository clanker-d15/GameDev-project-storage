class LightEnemy {
  float x, y, health, damage, speed, angle, turretAngle, reload, shootDelay;
  PImage base, turret;

  // Contructor
  LightEnemy(int x, int y) {
    this.x = x;
    this.y = y;
    health = 325;
    damage = 7;
    speed = 5;
    reload = 300;
    shootDelay = 20;
    angle = HALF_PI;
    turretAngle = -HALF_PI;

    base = loadImage("LightEnemyBase.png");
    turret = loadImage("");
  }

  // Member Methods
  void display() {
    if (health > 0) {
      imageMode(CENTER);

      pushMatrix();

      rotate(angle + HALF_PI);
      image(base, x, y);

      pushMatrix();

      float pivotOffsetX = -2;
      float pivotOffsety = 7;

      rotate(turretAngle - angle - HALF_PI);
      image(turret, pivotOffsetX, pivotOffsety);

      popMatrix();
      popMatrix();
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
