
/**
 * Created by Llama on 10/03/2015.
 */
class DestructibleTile extends VisibleObject {
  
  public boolean destructible = true;

  public DestructibleTile(PVector siz, PVector pos) {
    position = pos;
    size = siz;
    
  }
  
  public void indestructible()
  {
    destructible = false;
  }
}

