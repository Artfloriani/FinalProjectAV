
/**
 * Created by Llama on 10/03/2015.
 */
class Game {


  Game() {
  }

  //gameState _state;

  private ObjectManager manager;
  private Player player;
  private PVector gravity = new PVector (0, 0.8f);

  private float deltaTime;
  private float frameTime;
  private int level = 0;


  private void ShowMenu() {
  }

  public void Start() {
    //_state = gameState.PLAYING;
    manager = new ObjectManager();
    manager.start();

    manager = new ObjectManager();
    manager.start();

    player = new Player(new PVector(30, 30), new PVector(300, 100));
    player.setGravity(gravity);
    manager.add(player);
    manager.setPlayer(player);
  }





  public void GameLoop() {
    deltaTime = (millis() - frameTime)/1000.0f;
    frameTime = millis();
    background(22, 24, 72);
    manager.update();

    if (player.shooting)
    {
      PVector pPos = player.getPosition().get();
      PVector dir = new PVector(mouseX, mouseY);
      dir.sub(pPos);
      dir.normalize();
      dir.mult(13);

      Projectile temp = new Projectile(new PVector(10, 10), pPos, dir);
      manager.add(temp);
      manager.addProjectile(temp);
      player.shooting = false;
    }
  }

  public boolean IsRunning()
  {

    return true;
  }

  public Player getPlayer()
  {
    return player;
  }

  public void generate()
  {
    level++;
    for (int i = 0; i < 100; i ++)
    {
      DestructibleTile temp = new DestructibleTile(new PVector(13, 13), new PVector((i)*14, 490 - level*14));
      manager.add(temp);
      manager.addTile(temp);
    }
    
  }
}

