class Projectile extends VisibleObject {

  public boolean fromPlayer = true;
  private PVector target;


  public Projectile(PVector siz, PVector pos, PVector target, color c, boolean from) {
    fromPlayer = from;
    position = pos;
    size = siz;

    colour = c;


    target.sub(position);
    target.normalize();
    target.mult(10);
    velocity = target;
  }

  public void update()
  {
    position.add(velocity);
  }
}

