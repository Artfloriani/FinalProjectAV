/**
 * Created by Llama on 10/03/2015.
 */


Game _game;
int colour = 0;
Player player;
void setup()
{
  size(1000, 500);
  _game = new Game();
  _game.Start();

  player = _game.getPlayer();
}


void loop()
{
  if (_game.IsRunning())
  {
    _game.GameLoop();
    //teste
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

