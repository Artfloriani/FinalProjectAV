import ddf.minim.*;

class AudioClass {


  AudioPlayer shootSound;
  AudioPlayer hitSound;
  AudioPlayer jumpSound;
  AudioPlayer deadSound;
  AudioPlayer music;
  
  public int startTime;

  public AudioClass(Minim minim)
  {
    shootSound = minim.loadFile("laser.wav");
    shootSound.setGain(-9);
    hitSound = minim.loadFile("hurt.wav");
    jumpSound = minim.loadFile("jump.wav");
    deadSound = minim.loadFile("dead.wav");
    
    //Song from: http://freemusicarchive.org/music/Glass_Lux/
    music = minim.loadFile("soundtrack.mp3");
    
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
  
  public void playMusic(){
    music.loop();
    startTime = millis();
  }
  
  public int getStartTimer(){
   return startTime; 
  }
  
  public void stopMusic(){
   music.close(); 
  }
}

