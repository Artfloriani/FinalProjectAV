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
  private ArrayList<Particles> effects = new ArrayList<Particles>();
  

  ObjectManager()
  {

  }

  public void start() {
    for (int i = 0; i < 100; i ++)
    {
      DestructibleTile temp = new DestructibleTile(new PVector(13, 13), new PVector(-100+(i)*14, 490));
      temp.indestructible();
      _gameObjects.add(temp);
      tiles.add(temp);
    }

    for (int i = 0; i < 2; i++) {
      spawnMonster();
    }
  }

  public void update() {
    
    for (int i = 0; i < enemies.size (); i++) {
      enemies.get(i).setTarget(player.getPosition());
      //enemies.get(i).update();
      if (enemies.get(i).shoot())
      {
        Projectile temp = new Projectile(new PVector(10, 10), enemies.get(i).getPosition().get(), player.getPosition().get(), color(246, 36, 89), false);
        _gameObjects.add(temp);
        _projectiles.add(temp);
      }
    }
    
    
    for (int i = 0; i < _gameObjects.size (); i++) {
      _gameObjects.get(i).update();
      if (_gameObjects.get(i).getPosition().x > width+200 || _gameObjects.get(i).getPosition().y > height
        || _gameObjects.get(i).getPosition().x < -200)
        _gameObjects.remove(i);
    }


    


    handleCollisions();

    for (int i = 0; i < effects.size (); i++)
    {
      //effects.get(i).update();
      if (millis() - effects.get(i).bornTime > 6000)
      {
        _gameObjects.remove(effects.get(i));
        effects.remove(i);
      }
    }



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

  public void addEffects(Particles effe)
  {
    effects.add(effe);
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


      for (int k = 0; k < effects.size (); k++)
      {
        check = checkCollision(effects.get(k), tiles.get(i));

        if (check.x == 1) {
          effects.get(k).setVelocity(new PVector(0, effects.get(k).getVelocity().y));
        }
        if (check.y == 1) {
          effects.get(k).setVelocity(new PVector(0, 0));
          effects.get(k).setPosition(new PVector(effects.get(k).getPosition().x, tiles.get(i).getPosition().y - effects.get(k).getSize().y));
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


    //Collision Between Projectile and Enemy/Player

    for (int i = 0; i < _projectiles.size (); i++)
    {
      boolean hit = false;
      PVector check = checkCollision(player, _projectiles.get(i)); 
      if ((check.x == 1 || check.y ==  1) && !_projectiles.get(i).fromPlayer)
      {
        player.hit();
       
        hit = true;
        
        audioPlay.playHit();
      }

      if (i < _projectiles.size())
        for (int j = 0; j < enemies.size (); j++)
        {
          check = checkCollision(enemies.get(j), _projectiles.get(i)); 

          if ((check.x == 1 || check.y == 1) && _projectiles.get(i).fromPlayer)
          {
            hit = true;
            enemies.get(j).hit();
            
            audioPlay.playHit();
            
            if (enemies.get(j).dead())
            {
              explosion(enemies.get(j).getPosition().get(), _projectiles.get(i).getVelocity().get(), enemies.get(j).getColour());
              _gameObjects.remove(enemies.get(j));
              enemies.remove(j);
            }
          }
        }

      if (hit)
      {

        _gameObjects.remove(_projectiles.get(i));
        _projectiles.remove(i);
      }
    }
  }

  public void explosion(PVector pos, PVector dir, color c)
  {
    float quantity = random(12, 20);
    dir.mult(0.1);

    for (int i = 0; i < quantity; i++)
    {
      PVector changeDir = new PVector(dir.x*random(1, 5), dir.y+random(-5, -1));
      PVector changePos = new PVector(pos.x, pos.y + random(-15, 15));

      Particles temp = new Particles(new PVector(8, 8), changePos, changeDir, new PVector (0, 0.18f), c);
      _gameObjects.add(temp);
      effects.add(temp);
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

  public void gameOver() {
    for (int i = 0; i < enemies.size (); i++)
    {
      enemies.get(i).gameOver = true;
    }
  }
  
  public void spawnMonster()
  {
    PVector pos = new PVector(0,0);
    if(random(0,1) < 0.5f)
    {
      pos = new PVector(random(-100,100),50);
    }else
    {
      pos =  new PVector(random(width-100, width+100),50);
    }
      Enemy first = new Enemy(new PVector(25, 25), pos);
      first.setGravity(new PVector (0, 0.8f).get());
      //first.setTarget(player.getPosition());
      _gameObjects.add(first);
      enemies.add(first);
  }
  
  public void clearFloor(){
    println(_gameObjects.size());
    for(int i = 0; i < tiles.size(); i++)
    {
     _gameObjects.remove(tiles.get(i));
     
    }
    
    tiles.clear(); 
    
  }
}

