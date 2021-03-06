class VisibleObject {

  PVector position;
  PVector size;

  PVector velocity;
  
  PVector gravity = new PVector(0,0);
  
  color colour;


  void update()
  {
  }

  void drawThis()
  {
    fill(colour);
    rect(position.x, position.y, size.x, size.y);
  }
  
  public PVector getSize(){
    return size;
  }
  
  public PVector getVelocity()
  {
   return velocity; 
  }
  
  public PVector getPosition()
  {
   return position; 
  }
  
  public void setVelocity(PVector vel)
  {
    velocity = vel;
  }
  
  public void setGravity(PVector val)
  {
   gravity = val; 
  }
  
  public void setPosition(PVector val)
  {
   position = val; 
  }
  
  public color getColour()
  {
    return colour;
    
  }

}

