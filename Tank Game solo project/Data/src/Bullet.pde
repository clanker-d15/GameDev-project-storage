class Bullet {
  float x, y, w, h, speed, angle, bulletDamage;

  Bullet(float x, float y) {
    this.x = x;
    this.y = y;
    w = 2;
    h = 21;
    speed = 24;
    angle = player.turretAngle;
    bulletDamage = 30;
  }

  void update() {
    x += cos(angle + HALF_PI) * speed;
    y += sin(angle + HALF_PI) * speed;
  }

  void display() {
    fill(#F0A327);
    noStroke();
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
}
