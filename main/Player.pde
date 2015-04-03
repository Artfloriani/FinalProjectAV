/**
 * Created by Llama on 10/03/2015.
 */
class Player extends VisibleObject {
  private boolean up = false;
  private boolean down = false;
  private boolean left = false;
  private boolean right = false;
  public boolean grounded = false;

  public boolean shooting = false;
  public boolean shot = false;

  private float shootDelay;

  private int life = 7;
  
  AudioClass audio;
  

  public Player(PVector siz, PVector pos) {
    position = pos;
    size = siz;
    velocity = new PVector(0, 0);
    
    colour = color(34, 167, 240);
       
  }


  public void update()
  {
    if (up && grounded)
    {
      velocity.add(new PVector(0, -15.0f));
      grounded = false;
      audioPlay.playJump();
    }
    if (down)
    {
      //velocity.y = lerp(velocity.y, 5, 0.1f);
    }
    if (left)
    {
      velocity.x = lerp(velocity.x, -10, 0.1f);
    }
    if (right)
    {
      velocity.x = lerp(velocity.x, 10, 0.1f);
    }

    if (!down && !up)
    {
      //velocity.y = lerp(velocity.y, 0, 0.1f);
    }
    if (!left && !right)
    {
      velocity.x = lerp(velocity.x, 0, 0.1f);
    }

    velocity.add(gravity);



    //handle Shooting
    if (!shooting && shot && millis() - shootDelay > 200)
    {
      shootDelay = millis();
      shooting = true;
    } else {
      shooting = false;
    }
  }

  public void move()
  {
    position.add(velocity);
  }


  public void shoot(boolean var)
  {
    shot = var;
  }


  public void setUp(boolean value) {
    up = value;
  }
  public void setDown(boolean value) {
    down = value;
  }
  public void setLeft(boolean value) {
    left = value;
  }
  public void setRight(boolean value) {
    right = value;
  }

  public void hit() {
    life--;
  }

  public int getLife(){
   return life; 
  }
  public boolean dead()
  {
    if (life <= 0){
      
      return true;
    }
    return false;
  }
}

