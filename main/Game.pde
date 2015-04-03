
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
  float[] tempFrequencies = new float[100];
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
    }
  }





  public void GameLoop() {
    deltaTime = (millis() - frameTime);
    frameTime = millis();

    
    int timer = millis() - musicStart;

    float max = 0, maxIndex = 0;
    int index = (int)(timer/fft.getBlockLength()) % fft.getBlocks();
    for (int i = 0; i < 100; i++)
      {
        frequencies[i] = spectrum[index][i]*2.5f;
        if (frequencies[i] > max && i > 4)
        {
          max = frequencies[i];
          maxIndex = i;
        }
      }
    boolean generated = false;
    if (timer <= 10015) {
      
      if(timer > 9500 && maxIndex > 22 && max > 12 && max < 30)
      {
        generated = true;
        tempFrequencies = frequencies;

        generate();
      }
      else if(timer < 9500){
        generate();
      }
    }
    
    float total = 0;
    for(int i = 22; i < 28; i++)
    {
      total += frequencies[i];
    }
    
    background(total*2, 73, 94);
     
    
 




    if (millis() - spawn > 750 && timer > 10500 && maxIndex > 22.0f)
    {
      manager.spawnMonster();
      spawn = millis();
    }else if(millis() - spawn > 1500 && timer > 10500)
    {
      manager.spawnMonster();
      spawn = millis() + random(0,500);
    }

    manager.update();

    if (player.shooting)
    {
      PVector pPos = player.getPosition().get();

      Projectile temp = new Projectile(new PVector(10, 10), pPos, new PVector(mouseX, mouseY), player.getColour(), true);
      manager.addProjectile(temp);
      manager.add(temp);
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
      int value = (int)(frequencies[i]);
      for (int j = 0; j < value; j++) {
        DestructibleTile temp = new DestructibleTile(new PVector(13, 13), new PVector((i)*14, height-13 - j*14));
        manager.add(temp);
        manager.addTile(temp);
      }
    }
  }
}

