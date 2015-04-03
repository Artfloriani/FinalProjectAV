/**
 * Created by Llama on 10/03/2015.
 */


import ddf.minim.*;
import ddf.minim.analysis.*;
import ddf.minim.spi.*;

Game _game;
int colour = 0;
Player player;

PFont pixelate;

Minim minim;
AudioPlayer shootSound;
AudioClass audioPlay;

fftAudio fft;
float[][] spectrum;

int musicStart;

void setup()
{
  size(1000, 500);
  minim = new Minim(this);
  audioPlay = new AudioClass(minim);

  _game = new Game();
  _game.Start();

  player = _game.getPlayer();


  pixelate = loadFont("Pixelate-48.vlw");


  fft = new fftAudio(this, "soundtrack.mp3", 256);

  spectrum = fft.getSpectrum();
  
  audioPlay.playMusic();
  musicStart = millis();
}

void draw()
{
   textFont(pixelate, 72);
  if (_game.IsRunning())
  {
    
    _game.GameLoop();
   
    textSize(32);
    text("WASD + MOUSE", width/2-100, 90);
    //teste
  } else {
    _game.GameLoop();

    text("Game Over", width/2-175, height/2);
    textSize(32);
    text("Press R to restart", width/2-140, height/2+45);
  }
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
    audioPlay.stopMusic();
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

