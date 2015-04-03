class DestructibleTile extends VisibleObject {
  
  public boolean destructible = true;

  public DestructibleTile(PVector siz, PVector pos) {
    position = pos;
    size = siz;
    
    colour = color(189, 195, 199);
    
  }
  
  public void indestructible()
  {
    destructible = false;
  }
}

