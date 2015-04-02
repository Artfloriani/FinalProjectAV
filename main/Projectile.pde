class Projectile extends VisibleObject{
    
  public boolean fromPlayer = true;
  
  
   public Projectile(PVector siz, PVector pos, PVector vel) {
    position = pos;
    size = siz;
    velocity = vel;
    
  }
  
  public void update()
  {
    position.add(velocity);
  }
  
  void drawThis()
  {
    fill(217, 30, 24);
    rect(position.x, position.y, size.x, size.y);
  }
}
