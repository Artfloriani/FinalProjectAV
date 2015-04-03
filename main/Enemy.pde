class Enemy extends VisibleObject{
  
  private PVector target;
  
  private float lastJump;
  private boolean grounded = false;
  
  private int life = 1;
  
  private float shootTime;
  
  public boolean gameOver;
  
  public Enemy(PVector siz, PVector pos) {
    position = pos;
    size = siz;
    velocity = new PVector(0, 0);
    
    colour = color(random(150,255), random(70,200), random (70,150));
    //colour = color(224, 130, 131);
    
    shootTime = millis() + random(1000,5000);
    
    target = new PVector(0,0);
    
    gameOver = false;
    
    life = round(random(1,2));
    
  }
  
  public void update()
  {
    if(millis() - lastJump > 1500 && grounded)
    {
      lastJump = millis() + random (-300,300);
      if(target.x < position.x)
        velocity = new PVector(random(-3, -6), -15.0f);
      else
        velocity = new PVector(random(3,6), -15.0f);
        
       if(gameOver){
         velocity = new PVector(0, random(-14,-20.0f));
         lastJump = millis() + random(-500,0);
         
       }
       grounded = false;
    }
    
    
    velocity.add(gravity);
  }
  
 
  
  public void move()
  {
    position.add(velocity);
  }
  
  public void setTarget(PVector value)
  {
    
   target = value; 
  }
  
  public void hit()
  {
   life--;
  }
  
  public boolean dead()
  {
   if(life <= 0)
      return true;
     return false; 
  }
  
  public float getShoot()
  {
    return shootTime;  
  }
  
  public boolean shoot(){
    if(millis() - shootTime >= 1000 && !gameOver){
       shootTime = millis() + random(0,1000); 
       return true;
    }
    return false;
  }
  
}
