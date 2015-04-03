
/**
 * Created by Llama on 10/03/2015.
 */
class Game {




  //gameState _state;

  private ObjectManager manager;
  private Player player;
  private PVector gravity = new PVector (0, 0.8f);

  private float deltaTime;
  private float frameTime;
  private float spawn;
  private int level = 0;

  float[] frequencies = new float[100];
  PImage heart;

  private boolean running;


  Game() {

  }


  private void ShowMenu() {
  }

  public void Start() {
    manager = null;
    player = null;
    //_state = gameState.PLAYING;


    manager = new ObjectManager();
    manager.start();

    player = new Player(new PVector(30, 30), new PVector(300, 100));
    player.setGravity(gravity);
    manager.add(player);
    manager.setPlayer(player);

    heart = loadImage("heart.png");

    running = true;
    spawn = millis();

    for (int i = 0; i < 100; i++)
    {
      float value = noise(i);
      frequencies[i] = value;
      println(frequencies[i]);
    }
  }





  public void GameLoop() {
   
    for (int i = 0; i < 100; i++)
    {
      float value = noise(i+ millis()/100);
      frequencies[i] = value;
     }
     //generate();
    
    
    if (millis() - spawn > 1500)
    {
      manager.spawnMonster();
      spawn = millis();
    }
    deltaTime = (millis() - frameTime)/1000.0f;
    frameTime = millis();
    background(52, 73, 94);
    manager.update();

    if (player.shooting)
    {
      PVector pPos = player.getPosition().get();

      Projectile temp = new Projectile(new PVector(10, 10), pPos, new PVector(mouseX, mouseY), player.getColour(), true);
      manager.add(temp);
      manager.addProjectile(temp);
      player.shooting = false;
      audioPlay.playShoot();
    }

    for (int i = 0; i < player.getLife (); i++)
    {
      image(heart, width/2 - (player.getLife()/2.0f)*50 + i*55, 10);
    }

    if (player.getLife() <= 0)
      gameOver();
    if (player.getPosition().x > width || player.getPosition().y > height
      || player.getPosition().x < -62)
      gameOver();
  }

  public void gameOver() {
    if (running) {
      for (int i = -20; i < 20; i++)
      {
        manager.explosion(player.getPosition(), new PVector(i, random(-30, -15)), color(34, 167, 240)); 
        manager.remove(player);
      }
      running = false;

      audioPlay.playDead();
    }

    manager.gameOver();
  }

  public boolean IsRunning()
  {

    return running;
  }

  public Player getPlayer()
  {
    return player;
  }

  public void generate()
  {
    manager.clearFloor();
    level++;
    for (int i = 0; i < 100; i ++)
    {
      int value = (int)(frequencies[i]*15);
      for (int j = 0; j < value; j++) {
        DestructibleTile temp = new DestructibleTile(new PVector(13, 13), new PVector(-100+(i)*14, height-13 - j*14));
        manager.add(temp);
        manager.addTile(temp);
      }
    }
  }
}

