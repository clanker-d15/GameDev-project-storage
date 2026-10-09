class Heal {
  int x, y, healAmount;
  color c;
  PImage healthImage;

  void setup() {
    x = int(random(30, 670));
    y = int(random(30, 670));
    c = (255);
    healAmount = 450;
    healthImage = loadImage("Heal_Icon.png");
  }

  void update() {
    if (play == true) {
      if (player.health < 850) {
      }
    }
  }

  boolean isHit() {
    return true;
  }
}
