class Particles extends VisibleObject {

  public float bornTime;

  public Particles(PVector siz, PVector pos, PVector vel, PVector grav, color c) {
    position = pos;
    size = siz;
    velocity = vel;
    gravity = grav;
    colour = color(224, 130, 131);
    bornTime = millis() + random (0,500);
    
    colour = c;
  }
  
  public void update()
  {
    velocity.add(gravity);
    position.add(velocity);
    
    
  }
  
  void drawThis()
  {
    fill(colour);
    rect(position.x, position.y, size.x, size.y);
  }
}

