/**
 * Created by Llama on 10/03/2015.
 */


import ddf.minim.*;


Game _game;
int colour = 0;
Player player;

PFont pixelate;

Minim minim;
AudioPlayer shootSound;
AudioClass audioPlay;

void setup()
{
  size(1000, 500);
  minim = new Minim(this);
  audioPlay = new AudioClass(minim);
  
  _game = new Game();
  _game.Start();

  player = _game.getPlayer();


  pixelate = loadFont("Pixelate-48.vlw");
}


void loop()
{
  if (_game.IsRunning())
  {
    _game.GameLoop();
    //teste
  } else {
    _game.GameLoop();

    textFont(pixelate, 72);
    text("Game Over", width/2-175, height/2);
    textSize(32);
    text("Press R to restart", width/2-140, height/2+45);
  }
}


void draw()
{
  loop();
}

void mousePressed() {
  if (mouseButton == LEFT) {
    player.shoot(true);
  }
}

void mouseReleased()
{
  if (mouseButton == LEFT) {
    player.shoot(false);
  }
}

void restart() {
  if (!_game.IsRunning()) {
    setup();
  }
}



void keyPressed() {
  if (key == CODED) {
    if (keyCode == UP) {
      player.setUp(true);
    }
    if (keyCode == DOWN) {
      player.setDown(true);
    }
    if (keyCode == LEFT) {
      player.setLeft(true);
    }
    if (keyCode == RIGHT) {
      player.setRight(true);
    }
  } else {
    if (key == 'i')
    {
      _game.generate();
    }
    if (key == 'w' || key == ' ') {
      player.setUp(true);
    }
    if (key == 's') {
      player.setDown(true);
    }
    if (key == 'a') {
      player.setLeft(true);
    }
    if (key == 'd') {
      player.setRight(true);
    }
    if (key == 'r') {
      restart();
    }
  }
}

void keyReleased() {
  if (key == CODED) {
    if (keyCode == UP) {
      player.setUp(false);
    }
    if (keyCode == DOWN) {
      player.setDown(false);
    }
    if (keyCode == LEFT) {
      player.setLeft(false);
    }
    if (keyCode == RIGHT) {
      player.setRight(false);
    }
  } else {
    if (key == 'w' || key == ' ') {
      player.setUp(false);
    }
    if (key == 's') {
      player.setDown(false);
    }
    if (key == 'a') {
      player.setLeft(false);
    }
    if (key == 'd') {
      player.setRight(false);
    }
  }
}

