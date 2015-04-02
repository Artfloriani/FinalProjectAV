class Enemy extends VisibleObject{
  
  private PVector target;
  
  private float lastJump;
  private boolean grounded = true;
  
  public Enemy(PVector siz, PVector pos) {
    position = pos;
    size = siz;
    velocity = new PVector(0, 0);
    
  }
  
  public void update()
  {
    if(millis() - lastJump > 5000 && grounded)
    {
      lastJump = millis() + random (-300,300);
      if(target.x < position.x)
        velocity = new PVector(random(-8, -12), -15.0f);
      else
        velocity = new PVector(random(8,12), -15.0f);
        
       grounded = false;
    }
    
    
    velocity.add(gravity);
  }
  
  void drawThis()
  {
    fill(135, 211, 124);
    rect(position.x, position.y, size.x, size.y);
  }
 
  
  public void move()
  {
    position.add(velocity);
  }
  
  public void setTarget(PVector value)
  {
   target = value; 
  }
  
}
