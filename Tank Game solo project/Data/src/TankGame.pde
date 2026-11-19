// Franklin Roth | 17 Sept 2026 | TankGame
Tank player;
HeavyEnemy H_enemy;
LightEnemy L_enemy;
Heal healthPack;

//import processing.video.*;
//Movie particleSample, legacyMovementSample, detailsSample;

import processing.sound.*;
SoundFile shoot1, shoot2, shoot3, idle, move;

PImage mouse, reloadMouse, city1;
int tankOffScreen, ax, ay, detailLevel;
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
  city1 = loadImage("");
  H_enemies.add(new HeavyEnemy(int(random(width)), -60));
  L_enemies.add(new LightEnemy(int(random(width)), -60));
  play = false;
  pause = false;
  legacyMovement = false;
  particles = true;
  sound = true;
  detailLevel = 3;

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
    startScreen();
  }

  if (play == true) {
    noCursor();
    background(255);
    //image(city1, 0, 0);

    // add enemies and health packs

    player.update();
    player.display();

    infoPanel();

    if (player.health<1) {
      gameOver();
    }

    // Crosshair
    if (player.ammo > 0) {
      image(mouse, mouseX, mouseY);
    } else {
      image(reloadMouse, mouseX, mouseY);
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

// Shoot
void mousePressed() {
  if (play == true && pause == false) {
    if (mouseButton == LEFT) {
      if (player.shootType == 1) {
        if (player.ammo > 0) {
          bullets.add(new Bullet(player.x, player.y));
          player.shoot();
          // shoot1.play();
        }
      }

      if (player.shootType == 2) {
        if (player.rocketAmmo > 0) {
          rockets.add(new Rocket(player.x, player.y));
          player.shoot();
          // shoot2.play();
        }
      }
    }
  } else if (play == false) {
    if (mouseX > 612 && mouseX < 777 && mouseY > 671 && mouseY < 701) {
      if (legacyMovement == false) {
        legacyMovement = true;
      } else {
        legacyMovement = false;
      }
    }

    if (mouseX > 612 && mouseX < 692 && mouseY > 707 && mouseY < 737) {
      if (particles == false) {
        particles = true;
      } else {
        particles = false;
      }
    }

    if (mouseX > 612 && mouseX < 677 && mouseY > 742 && mouseY < 772) {
      if (sound == false) {
        sound = true;
      } else {
        sound = false;
      }
    }

    if (mouseX > 612 && mouseX < 682 && mouseY > 776 && mouseY < 806) {
      detailLevel -= 1;
      if (detailLevel < 1) {
        detailLevel = 3;
      }
    }
  }
}

// Ammo switch
void mouseWheel (MouseEvent event) {
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

// Movement
void keyPressed() {
  if (play == false) {
    if (keyPressed) play = true;
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
  rect(73, 855, 137, 75, 10);

  if (player.health > 750) {
    fill(255);
  }
  if (player.health < 750) {
    fill(#E5AC2E);
  }
  if (player.health < 300) {
    fill(#D82A2A);
  }

  textSize(25);
  text("Health: " + player.health, 73, 827);

  if (player.ammo == 0) {
    fill(255);
    text("Reloading...", 73, 847);
  } else {
    if (player.ammo > 8) {
      fill(255);
      text("Ammo: " + player.ammo, 65, 847);
    }
    if (player.ammo < 9) {
      fill(#FAE0C0);
      text("Ammo: " + player.ammo, 65, 847);
    }
    if (player.ammo < 4) {
      fill(#FAC0C0);
      text("Ammo: " + player.ammo, 65, 847);
    }
  }

  if (player.rocketAmmo == 0) {
    fill(255);
    text("Reloading...", 73, 868);
  } else {
    if (player.rocketAmmo > 0) {
      fill(255);
      text("Rockets: " + player.rocketAmmo, 65, 868);
    }
  }
}


void startScreen() {
  background(0);

  fill(100);
  rect(612, 671, 165, 30, 5);
  rect(612, 707, 80, 30, 5);
  rect(612, 742, 65, 30, 5);
  rect(612, 776, 70, 30, 5);

  fill(255);
  textSize(60);
  text("Defend the base", width/5, height/2);

  textSize(45);
  text("Controls", width/7, 655);
  text("Settings", width/1.6, 655);

  textSize(20);
  text("Press any key to begin", width/2.5, 495);
  text("WASD or arrow keys for movement", width/5.5, 680);
  text("1 to switch to bullets", width/5.5, 705);
  text("2 to switch to rockets", width/5.5, 730);
  text("Left-click to shoot", width/5.5, 755);
  text("Scroll to switch ammo type", width/5.5, 780);

  text("Legacy movement", 617, 693);
  if (legacyMovement == true) {
    text("On", width/1.18, 693);
  } else {
    text("Off", width/1.18, 693);
  }

  text("Particles", 617, 728);
  if (particles == true) {
    text("On", 697, 728);
  } else {
    text("Off", 697, 728);
  }

  text("Sound", 617, 763);
  if (sound == true) {
    text("On", 682, 763);
  } else {
    text("Off", 682, 763);
  }

  text("Details", 617, 798);
  if (detailLevel == 3) {
    text("High", 687, 798);
  } else if (detailLevel == 2) {
    text("Medium", 687, 798);
  } else if (detailLevel == 1) {
    text("Low", 687, 798);
  }

  textSize(15);
  if (mouseX > 612 && mouseX < 777 && mouseY > 671 && mouseY < 701) {
    text("Legacy movement is a simpler version of movement.\nThis movement was used for the prototype of this game.\nApplies to the enemies movement too", 550, 850);
  }

  if (mouseX > 612 && mouseX < 692 && mouseY > 707 && mouseY < 737) {
    text("Disabling particles will partially improve performance", 550, 850);
  }

  if (mouseX > 612 && mouseX < 677 && mouseY > 742 && mouseY < 772) {
    text("Disabling sounds will disable every single sound", 550, 850);
  }

  if (mouseX > 612 && mouseX < 682 && mouseY > 776 && mouseY < 806) {
    text("How detailed you want the world to be. \nLower quality will partially improve performance", 550, 850);
  }
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
