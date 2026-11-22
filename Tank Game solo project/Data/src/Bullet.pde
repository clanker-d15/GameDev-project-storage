class Bullet {
  float x, y, w, h, speed, angle, bulletDamage;

  Bullet(float x, float y) {
    this.x = x;
    this.y = y;
    w = 2;
    h = 28;
    speed = 32;
    angle = player.turretAngle;

    if (bulletType == 1) {
      bulletDamage = 30;
    } else if (bulletType == 2) {
      bulletDamage = 70;
    }
  }

  void update() {
    x += cos(angle + HALF_PI) * speed;
    y += sin(angle + HALF_PI) * speed;
  }

  void display() {
    fill(#F0A327);
    strokeWeight(0.5);
    rectMode(CENTER);
    pushMatrix();
    translate(x, y);
    rotate(angle + PI);
    rect(0, 0, w, h);
    popMatrix();
  }

  boolean isOffScreen() {
    return (x < -10 || x > width + 10 || y < -10 || y > height + 10);
  }

  boolean isHit(Tank t) {
    float d = dist(x, y, t.x, t.y);
    if (d < 40) {
      t.health -= bulletDamage;
      return true;
    }
    return false;
  }

  boolean isHit(HeavyEnemy het) {
    float d = dist(x, y, het.x, het.y);
    if (d < 40) {
      het.health -= bulletDamage;
      return true;
    }
    return false;
  }

  boolean isHit(LightEnemy le) {
    float d = dist(x, y, le.x, le.y);
    if (d < 40) {
      le.health -= bulletDamage;
      return true;
    }
    return false;
  }
}
