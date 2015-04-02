import java.util.ArrayList;

/**
 * Created by Llama on 10/03/2015.
 */
class ObjectManager {
  private Player player;
  private ArrayList<DestructibleTile> tiles = new ArrayList<DestructibleTile>();
  private ArrayList<VisibleObject> _gameObjects = new ArrayList<VisibleObject>();
  private ArrayList<Projectile> _projectiles = new ArrayList<Projectile>();
  private ArrayList<Enemy> enemies = new ArrayList<Enemy>();

  ObjectManager()
  {
  }

  public void start() {
    for (int i = 0; i < 100; i ++)
    {
      DestructibleTile temp = new DestructibleTile(new PVector(13, 13), new PVector((i)*14, 490));
      temp.indestructible();
      _gameObjects.add(temp);
      tiles.add(temp);
    }

    Enemy first = new Enemy(new PVector(32, 32), new PVector(100, 50));
    first.setGravity(new PVector (0, 0.8f).get());


    _gameObjects.add(first);
    enemies.add(first);
  }

  public void update() {
    for (int i = 0; i < _gameObjects.size (); i++) {
      _gameObjects.get(i).update();
      if (_gameObjects.get(i).getPosition().x > width || _gameObjects.get(i).getPosition().y > height || _gameObjects.get(i).getPosition().y < 0
        || _gameObjects.get(i).getPosition().x < 0)
        _gameObjects.remove(i);
    }


    for(int i = 0; i < enemies.size(); i++){
      enemies.get(i).setTarget(player.getPosition());
      enemies.get(i).update();
    }


    handleCollisions();


    //checkPlayerCollision();
    player.move();
    for (int i = 0; i < enemies.size (); i++)
    {
      enemies.get(i).move();
    }

    for (int i = 0; i < _gameObjects.size (); i++) {
      _gameObjects.get(i).drawThis();
    }
  }

  public void add(VisibleObject obj) {

    _gameObjects.add(obj);
  }

  public void remove(VisibleObject obj) {
    _gameObjects.remove(obj);
  }

  public void setPlayer(Player pl)
  {
    player = pl;
  }

  public void  addTile(DestructibleTile tile)
  {
    tiles.add(tile);
  }

  public void  addProjectile(Projectile proj)
  {
    _projectiles.add(proj);
  }

  public void handleCollisions()
  {




    //All collisions with Tiles
    for (int i = 0; i < tiles.size (); i++)
    {
      PVector check = checkCollision(player, tiles.get(i));

      if (check.x == 1) {
        player.setVelocity(new PVector(0, player.getVelocity().y));
      }
      if (check.y == 1) {
        player.setVelocity(new PVector(player.getVelocity().x, 0));
        player.grounded = true;

        player.setPosition(new PVector(player.getPosition().x, tiles.get(i).getPosition().y - player.getSize().y));
      }

      for (int k = 0; k < enemies.size (); k++)
      {
        check = checkCollision(enemies.get(k), tiles.get(i));

        if (check.x == 1) {
          enemies.get(k).setVelocity(new PVector(0, enemies.get(k).getVelocity().y));
        }
        if (check.y == 1) {
          enemies.get(k).setVelocity(new PVector(0, 0));
          enemies.get(k).grounded = true;
          enemies.get(k).setPosition(new PVector(enemies.get(k).getPosition().x, tiles.get(i).getPosition().y - enemies.get(k).getSize().y));
        }
      }

      if (tiles.get(i).destructible)
      {
        for (int j = 0; j < _projectiles.size (); j++)
        {
          check = checkCollision(_projectiles.get(j), tiles.get(i));
          if (check.x == 1 || check.y == 1)
          {
            _gameObjects.remove(_projectiles.get(j));
            _projectiles.remove(j);
            _gameObjects.remove(tiles.get(i));
            tiles.remove(i);
          }
        }
      }
    }


    //Collision Between Player and Enemy
    for (int i = 0; i < enemies.size (); i++)
    {
      PVector check = checkCollision(player, enemies.get(i));
      if (check.x == 1) {
        player.setVelocity(new PVector(-player.getVelocity().x, player.getVelocity().y));
        enemies.get(i).setVelocity(new PVector(-enemies.get(i).getVelocity().x, enemies.get(i).getVelocity().y));
      }
      if (check.y == 1) {
        player.setVelocity(new PVector (player.getVelocity().x, enemies.get(i).getVelocity().y));
        player.grounded = true;
      }

      check = checkCollision(enemies.get(i), player);
      if (check.x == 1) {
        player.setVelocity(new PVector(-player.getVelocity().x, player.getVelocity().y));
        enemies.get(i).setVelocity(new PVector(-enemies.get(i).getVelocity().x, enemies.get(i).getVelocity().y));
      }
      if (check.y == 1) {
        enemies.get(i).setVelocity(new PVector (enemies.get(i).getVelocity().x, player.getVelocity().y));
        enemies.get(i).grounded = true;
      }
    }
  }

  public PVector checkCollision(VisibleObject one, VisibleObject two)
  {
    PVector collision = new PVector(0, 0);
    PVector pPos = one.getPosition().get();
    PVector pVel = one.getVelocity();
    PVector pSiz = one.getSize();

    PVector pPosY = pPos.get();
    pPos.add(new PVector(pVel.x, 0));
    pPosY.add(new PVector(0, pVel.y));

    PVector tPos = two.getPosition();
    PVector tSiz = two.getSize();
    if (pPos.x < tPos.x + tSiz.x &&
      pPos.x + pSiz.x > tPos.x &&
      pPos.y < tPos.y + tSiz.y &&
      pSiz.y + pPos.y > tPos.y)
    {
      collision.x = 1;
    }

    if (pPosY.x < tPos.x + tSiz.x &&
      pPosY.x + pSiz.x > tPos.x &&
      pPosY.y < tPos.y + tSiz.y &&
      pSiz.y + pPosY.y > tPos.y)
    {
      collision.y = 1;
    }
    return collision;
  }
}

