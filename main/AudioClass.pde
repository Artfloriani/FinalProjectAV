import ddf.minim.*;

class AudioClass {


  AudioPlayer shootSound;
  AudioPlayer hitSound;
  AudioPlayer jumpSound;
  AudioPlayer deadSound;

  public AudioClass(Minim minim)
  {
    shootSound = minim.loadFile("laser.wav");
    hitSound = minim.loadFile("hurt.wav");
    jumpSound = minim.loadFile("jump.wav");
    deadSound = minim.loadFile("dead.wav");
  }

  public void playShoot() {
    shootSound.play(0);
  }

  public void playHit() {
    hitSound.play(0);
  }

  public void playJump() {
    jumpSound.play(0);
  }

  public void playDead() {
    deadSound.play();
  }
}

