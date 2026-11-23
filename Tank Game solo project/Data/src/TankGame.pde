// Complexity | TankGame
Tank player;
HeavyEnemy H_enemy;
LightEnemy L_enemy;
Heal healthPack;

//import processing.video.*;
//Movie particleSample, legacyMovementSample, detailsSample;

import processing.sound.*;
SoundFile shoot1, shoot2, shoot3, idle, move;

PImage mouse, reloadMouse, defaultBullet, armorBullet, normalRocket, guidedRocket, defaultArmor, explosiveArmor, heavyArmor, plazaIcon, plaza, city1Icon, city1, city2Icon, city2, menuSmokeTest;
int tankOffScreen, ax, ay, detailLevel, menuScreen, bulletType, rocketType, armorType, map;
boolean play, pause, legacyMovement, particles, sound;

ArrayList<HeavyEnemy> H_enemies = new ArrayList<HeavyEnemy>();
ArrayList<LightEnemy> L_enemies = new ArrayList<LightEnemy>();
ArrayList<Heal> healPack = new ArrayList<Heal>();
ArrayList<Bullet> bullets = new ArrayList<Bullet>();
ArrayList<Rocket> rockets = new ArrayList<Rocket>();
ArrayList<Barrier> barriers = new ArrayList<Barrier>();


void setup() {
  size(925, 925);
  player = new Tank();
  H_enemy = new HeavyEnemy(0, 0);
  healthPack = new Heal();
  mouse = loadImage("crossHair.png");
  reloadMouse = loadImage("ReloadCrosshair.png");
  plazaIcon = loadImage("");
  plaza = loadImage("");
  city1Icon = loadImage("");
  city1 = loadImage("");
  menuSmokeTest = loadImage("");
  defaultBullet = loadImage("");
  armorBullet = loadImage("");
  normalRocket = loadImage("");
  guidedRocket = loadImage("");
  defaultArmor = loadImage("");
  explosiveArmor = loadImage("");
  heavyArmor = loadImage("");
  H_enemies.add(new HeavyEnemy(int(random(width)), -60));
  L_enemies.add(new LightEnemy(int(random(width)), -60));
  play = false;
  pause = false;
  legacyMovement = false;
  particles = true;
  sound = true;
  detailLevel = 3;
  menuScreen = 1;
  bulletType = 1;
  rocketType = 1;
  armorType = 1;
  map = 1;

  ax = mouseX + 15;
  ay = mouseY + 15;

  shoot1 = new SoundFile(this, "");
  shoot2 = new SoundFile(this, "");
  shoot3 = new SoundFile(this, "");
  idle = new SoundFile(this, "");
  move = new SoundFile(this, "");

  //particleSample = new Movie(this, "");
  //legacyMovementSample = new Movie(this, "");
  //detailsSample = new Movie(this, "");
}

void draw() {
  if (play == false) {
    background(0);

    if (menuScreen == 1) {
      startScreen();
    } else if (menuScreen == 2) {
      settingsScreen();
    } else if (menuScreen == 3) {
      controlsScreen();
    } else if (menuScreen == 4) {
      creditsScreen();
    }

    //Smoke needs to be more transparent and needs to be animated left to right
    //(Can do that in the engine without downloading a video)

    //image(menuSmokeTest, 0, -300);
  }

  if (play == true) {
    noCursor();
    background(255);

    if (map == 1) {
      //image(plaza, 0, 0);
    } else if (map == 2) {
      //image(city1, 0, 0);
    }

    // add enemies and health packs

    player.update();
    player.display();

    infoPanel();

    if (player.health<1) {
      gameOver();
    }
    if (player.shootType == 1) {
      if (player.ammo > 0) {
        image(mouse, mouseX, mouseY);
      } else {
        image(reloadMouse, mouseX, mouseY);
      }
    } else {
      if (player.rocketAmmo > 0) {
        image(mouse, mouseX, mouseY);
      } else {
        image(reloadMouse, mouseX, mouseY);
      }
    }

    // Ammo counter next to crosshair
    textAlign(CENTER, CENTER);
    rectMode(CENTER);
    textSize(15);

    if (player.shootType == 1) {
      if (player.ammo > 0) {
        if (mouseY < 25 || mouseX < 25) {
          fill(190, 200);
          rect(mouseX + 23, mouseY + 17, 22, 19, 25);
          fill(0);
          text(player.ammo, mouseX + 23, mouseY + 15);
        } else {
          fill(190, 200);
          rect(mouseX - 23, mouseY - 20, 22, 19, 25);
          fill(0);
          text(player.ammo, mouseX - 23, mouseY - 22);
        }
      } else {
        if (mouseY < 25 || mouseX < 70) {
          fill(190, 200);
          rect(mouseX + 50, mouseY + 23, 82, 19, 25);
          fill(0);
          text("Reloading...", mouseX + 50, mouseY + 21);
        } else {
          fill(190, 200);
          rect(mouseX - 50, mouseY - 23, 82, 19, 25);
          fill(0);
          text("Reloading...", mouseX - 50, mouseY - 25);
        }
      }
    }
  } else if (player.shootType == 2) {
    if (player.rocketAmmo > 0) {
      if (mouseY < 25 || mouseX < 25) {
        fill(190, 200);
        rect(mouseX + 23, mouseY + 17, 22, 19, 25);
        fill(0);
        text(player.rocketAmmo, mouseX + 23, mouseY + 15);
      } else {
        fill(190, 200);
        rect(mouseX - 23, mouseY - 20, 22, 19, 25);
        fill(0);
        text(player.rocketAmmo, mouseX - 23, mouseY - 22);
      }
    } else {
      if (mouseY < 25 || mouseX < 70) {
        fill(190, 200);
        rect(mouseX + 50, mouseY + 23, 82, 19, 25);
        fill(0);
        text("Reloading...", mouseX + 50, mouseY + 21);
      } else {
        fill(190, 200);
        rect(mouseX - 50, mouseY - 23, 82, 19, 25);
        fill(0);
        text("Reloading...", mouseX - 50, mouseY - 25);
      }
    }
  }

  // Bullet and Rocket activators
  for (int i = bullets.size() - 1; i >= 0; i--) {
    Bullet b = bullets.get(i);
    b.update();
    b.display();

    if (b.isOffScreen()) {
      bullets.remove(i);
    }
  }

  for (int i = rockets.size() - 1; i >= 0; i--) {
    Rocket r = rockets.get(i);
    r.update();
    r.display();

    if (r.isOffScreen()) {
      rockets.remove(i);
    }
  }
}

void mousePressed() {
  if (mouseButton == LEFT) {
    if (play == true) {
      if (pause == false) {
        if (player.shootType == 1) {
          if (player.ammo > 0) {
            bullets.add(new Bullet(player.x, player.y));
            player.shoot();
            // shoot1.play();
          }
        } else if (player.shootType == 2) {
          if (player.rocketAmmo > 0) {
            rockets.add(new Rocket(player.x, player.y));
            player.shoot();
            // shoot2.play();
          }
        }
      }
    } else {
      // Menu navigation and settings clicks
      if (menuScreen == 1) {
        if (mouseX > 198 && mouseX < 338 && mouseY > 768 && mouseY < 811) {
          menuScreen = 2;
        }
        if (mouseX > 198 && mouseX < 346 && mouseY > 817 && mouseY < 857) {
          menuScreen = 3;
        }
        if (mouseX > 198 && mouseX < 323 && mouseY > 863 && mouseY < 903) {
          menuScreen = 4;
        }
      } else if (menuScreen == 2) {
        if (mouseX > 200 && mouseX < 400 && mouseY > 240 && mouseY < 270) {
          legacyMovement = !legacyMovement;
        }

        if (mouseX > 200 && mouseX < 300 && mouseY > 280 && mouseY < 310) {
          particles = !particles;
        }

        if (mouseX > 200 && mouseX < 277 && mouseY > 320 && mouseY < 350) {
          sound = !sound;
        }

        if (mouseX > 200 && mouseX < 280 && mouseY > 360 && mouseY < 390) {
          detailLevel -= 1;
          if (detailLevel < 1) {
            detailLevel = 3;
          }
        }
      }
    }
  }
}

// Ammo switch
void mouseWheel (MouseEvent event) {
  if (play == true) {
    float e = event.getCount();

    if (e > 0) {
      if (player.shootType == 1) {
        player.shootType = 2;
      } else {
        player.shootType = 1;
      }
    } else if (player.shootType == 2) {
      player.shootType = 1;
    } else {
      player.shootType = 2;
    }
  }
}

void keyPressed() {
  if (play == false) {
    if (menuScreen == 1) {
      if (key == ENTER) play = true;
    } else if (menuScreen != 1) {
      if (key == 'e') menuScreen = 1;
    }
  }

  if (play == true) {
    if (key == 'w') player.movingForward = true;
    if (key == 's') player.movingBackward = true;
    if (keyCode == 38) player.movingForward = true;
    if (keyCode == 40) player.movingBackward = true;

    if (legacyMovement == true) {
      if (key == 'a') player.movingLeft = true;
      if (key == 'd') player.movingRight = true;
      if (keyCode == 37) player.movingLeft = true;
      if (keyCode == 39) player.movingRight = true;
    } else {
      if (key == 'a') player.turningLeft = true;
      if (key == 'd') player.turningRight = true;
      if (keyCode == 37) player.turningLeft = true;
      if (keyCode == 39) player.turningRight = true;
    }

    if (keyCode == 49) player.shootType = 1;
    if (keyCode == 50) player.shootType = 2;

    if (key == 'p') {
      pause();
    }
  }
}


void keyReleased() {
  if (play == true) {
    if (key == 'w') player.movingForward = false;
    if (key == 's') player.movingBackward = false;
    if (keyCode == 38) player.movingForward = false;
    if (keyCode == 40) player.movingBackward = false;

    if (legacyMovement == true) {
      if (key == 'a') player.movingLeft = false;
      if (key == 'd') player.movingRight = false;
      if (keyCode == 37) player.movingLeft = false;
      if (keyCode == 39) player.movingRight = false;
    } else {
      if (key == 'a') player.turningLeft = false;
      if (key == 'd') player.turningRight = false;
      if (keyCode == 37) player.turningLeft = false;
      if (keyCode == 39) player.turningRight = false;
    }
  }
}

void infoPanel() {
  textAlign(CENTER, CENTER);
  rectMode(CENTER);
  stroke(10);
  strokeWeight(2);
  fill(100, 100);
  rect(75, 880, 137, 70, 10);

  fill(255);
  textSize(25);
  text("Health: " + player.health, 75, 860);
  if (player.ammo > 0) {
    text("Ammo: " + player.ammo, 65, 880);
  } else {
    text("Reloading...", 72, 880);
  }
  if (player.rocketAmmo > 0) {
    text("Rockets: " + player.rocketAmmo, 65, 900);
  } else {
    text("Reloading...", 72, 900);
  }
}


void startScreen() {
  background(0);
  menuScreen = 1;
  fill(50);
  rect(630, 715, 280, 195, 10);

  fill(100);
  //Screens buttons
  rect(198, 768, 140, 43, 5);
  rect(198, 817, 148, 40, 5);
  rect(198, 863, 125, 40, 5);

  //Bullet buttons
  rect(645, 753, 75, 25, 5);
  rect(735, 753, 75, 25, 5);

  //Rocket buttons
  rect(645, 805, 75, 25, 5);
  rect(735, 805, 75, 25, 5);

  //Armor buttons
  rect(645, 860, 75, 40, 5);
  rect(735, 860, 75, 40, 5);
  rect(825, 860, 75, 40, 5);

  fill(255);
  textSize(100);
  text("Tank Game", 85, 205);

  textSize(40);
  text("Press ENTER to begin", 205, 245);
  text("Settings", 200, 800);
  text("Controls", 200, 850);
  text("Credits", 200, 896);
  text("Tank Specs", 680, 700);
  text("Maps:", 140, 315);

  textSize(25);
  text("Bullet Type:", 640, 745);
  text("Rocket Type:", 640, 800);
  text("Armor Type:", 640, 855);

  textSize(20);
  if (bulletType == 1) {
    text("Default", 770, 745);
  } else if (bulletType == 2) {
    text("Armor Piercing", 770, 745);
  }

  if (rocketType == 1) {
    text("Default", 780, 800);
  } else if (rocketType == 2) {
    text("Laser Guided", 780, 800);
  }

  if (armorType == 1) {
    text("Default", 775, 855);
  } else if (armorType == 2) {
    text("Explosive", 775, 855);
  } else if (armorType == 3) {
    text("Heavy", 775, 855);
  }

  textSize(20);
  if (mouseX > 645 && mouseX < 720 && mouseY > 753 && mouseY < 778) {
    text("Light all purpose explosive rounds. /nCarries more shots per load and shoots faster.", 350, 820);
  }
  if (mouseX > 735 && mouseX < 810 && mouseY > 753 && mouseY < 778) {
    text("Heavier rounds specifically for vehicle armor. /nCarries less shots and shoots slower.", 350, 820);
  }

  if (mouseX > 645 && mouseX < 720 && mouseY > 805 && mouseY < 830) {
    text("Fast unguided rockets with high explosive power. /nCarry 2 rockets total.", 350, 820);
  }
  if (mouseX > 735 && mouseX < 810 && mouseY > 805 && mouseY < 830) {
    text("Slower crosshair guided rockets with less explosive power. /nCarry more rockets than standard unguided but slower reload.", 350, 820);
  }

  if (mouseX > 645 && mouseX < 720 && mouseY > 860 && mouseY < 900) {
    text("Standard issue armor plating with acceptable stopping power. /nAllows for decent speed while providing equally decent protection.", 350, 820);
  }
  if (mouseX > 735 && mouseX < 810 && mouseY > 860 && mouseY < 900) {
    text("Thin armor plating with explosive padded plates to stop anything. /nAllows for high speed while sacrificing proctection. /nPlating wears out, stopping less and less damage for every projectile taken.", 350, 820);
  }
  if (mouseX > 825 && mouseX < 900 && mouseY > 860 && mouseY < 900) {
    text("Heavy armor plating with great stopping power. /nSacrifices speed for great overall protection. /nHas a longer time stopping and going.", 350, 820);
  }

  //image();
  //image();
  //image();
  //image();
  //image();

  //image(plazaIcon, 300, 400);
  //image(city1Icon, 500, 400);
  //image
  //image

  
}

void settingsScreen() {
  menuScreen = 2;
  fill(100);
  rect(200, 240, 200, 30, 5);
  rect(200, 280, 100, 30, 5);
  rect(200, 320, 77, 30, 5);
  rect(200, 360, 80, 30, 5);

  fill(255);
  textSize(75);
  text("Settings", 132, 200);

  textSize(25);
  text("Press E to go back", 50, 50);

  text("Legacy movement", 205, 263);
  if (legacyMovement == true) {
    text("On", 410, 263);
  } else {
    text("Off", 410, 263);
  }

  text("Particles", 205, 305);
  if (particles == true) {
    text("On", 310, 305);
  } else {
    text("Off", 310, 305);
  }

  text("Sound", 205, 345);
  if (sound == true) {
    text("On", 285, 345);
  } else {
    text("Off", 285, 345);
  }

  text("Details", 205, 385);
  if (detailLevel == 3) {
    text("High", 290, 385);
  } else if (detailLevel == 2) {
    text("Medium", 290, 385);
  } else if (detailLevel == 1) {
    text("Low", 290, 385);
  }

  textSize(20);
  if (mouseX > 200 && mouseX < 400 && mouseY > 240 && mouseY < 270) {
    text("Legacy movement is a simpler version of movement.\nThis movement was used for the prototype of this game.\nApplies to the enemies movement too", 430, 320);
  }

  if (mouseX > 200 && mouseX < 300 && mouseY > 280 && mouseY < 310) {
    text("Disabling particles will partially improve performance", 430, 320);
  }

  if (mouseX > 200 && mouseX < 277 && mouseY > 320 && mouseY < 350) {
    text("Disabling sounds will disable every single sound", 430, 320);
  }

  if (mouseX > 200 && mouseX < 280 && mouseY > 360 && mouseY < 390) {
    text("How detailed you want the world to be. \nLower quality will partially improve performance", 430, 320);
  }
}

void controlsScreen() {
  menuScreen = 3;
  fill(255);
  textSize(75);
  text("Controls", 132, 200);

  textSize(30);
  text("-WASD or arrow keys for movement", 200, 240);
  text("-1 to switch to bullets", 200, 280);
  text("-2 to switch to rockets", 200, 320);
  text("-Left-click to shoot", 200, 360);
  text("-Scroll to switch ammo type", 200, 400);
  text("-Press P to pause the game", 200, 440);

  textSize(25);
  text("Press E to go back", 50, 50);
}

void gameOver() {
  if (player.health < 1) {
    textAlign(CENTER, CENTER);
    fill(0, 190);
    rect(0, 0, 1200, 1200);

    fill(255);
    textSize(25);
    text("Game Over! Your tank was destroyed.", 200, 400);
    text("Rerun the game to restart", 255, 430);
    noLoop();
  }
}

void creditsScreen() {
  menuScreen = 4;
  fill(255);
  textSize(75);
  text("Credits", 132, 200);

  textSize(50);
  text("Creator", 200, 240);
  text("Inspiration", 200, 330);
  text("My Socials", 200, 425);

  textSize(30);
  text("-Complexity", 220, 270);
  text("-Battlefield 6", 220, 365);
  text("YouTube - Complexity_628", 220, 460);
  text("Twitter - Complexity_ (Or @P0tat0pratguy)", 220, 530);

  textSize(25);
  text("Press E to go back", 50, 50);
}

void pause() {
  if (play == true && player.health > 0) {
    if (pause == false) {
      pause = true;
      noLoop();
      textAlign(CENTER, CENTER);

      fill(0, 190);
      rect(400, 400, 1200, 1200);

      fill(255);
      textSize(60);
      text("Paused", 300, 400);
      textSize(25);
      text("Press 'P' to unpause", 355, 450);

      cursor();
    } else {
      pause = false;
      loop();
      noCursor();
    }
  }
}
