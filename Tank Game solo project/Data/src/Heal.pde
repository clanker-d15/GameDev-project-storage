class Heal {
  int x, y, healAmount, counter;
  PImage healthImage;

  void setup() {
    x = int(random(30, 850));
    y = int(random(30, 850));
    healAmount = 450;
    healthImage = loadImage("Heal_Icon.png");
    counter = 1500
  }

  void update() {
    if (play == true) {
      if (counter == 0) {
        Image(healthImage,x,y);
        
      } else {
        counter = counter - 1;
        
      }
    }
  }

  boolean isHit() {
    player.health = player.health + healAmount;
    return true;
  }
}
