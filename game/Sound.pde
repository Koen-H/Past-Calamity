import ddf.minim.*;
// use minim for better performance
//problem: when changing scenes, I can play one specific sound, but I cannot specify specific sounds
//background music, how to change: scenes need to be initialized in set up
Minim minim;

AudioPlayer heartbeat;
AudioPlayer transport;
AudioPlayer bodyFall;

AudioPlayer buttonClick;
AudioPlayer roomTone;
AudioPlayer drawerOpen;
AudioPlayer drawerClosed;
AudioPlayer takeItem;

AudioPlayer beep;                //keypad
AudioPlayer correctSound;
AudioPlayer wrongSound;
AudioPlayer openDoor;

AudioPlayer openBook;
AudioPlayer pageFlip1;
AudioPlayer pageFlip2;

AudioPlayer lockerOpen;
AudioPlayer lockerClosed;

AudioPlayer screw1;
AudioPlayer screw2;
AudioPlayer screw3;

AudioPlayer walk1;
AudioPlayer walk2;
AudioPlayer door;

AudioPlayer cityAmbience;
AudioPlayer labAmbience;

public void soundLoad(){
  minim = new Minim(this);
  
  heartbeat =     minim.loadFile("heartbeat.mp3");
  transport =     minim.loadFile("transport.mp3");
  bodyFall =      minim.loadFile("bodyFall.mp3");
  
  walk1 =         minim.loadFile("fastWalk1.mp3");
  walk2 =         minim.loadFile("fastWalk2.mp3");

  buttonClick =   minim.loadFile("buttonClick.mp3");
  openBook =      minim.loadFile("openBook.mp3");
  pageFlip1 =     minim.loadFile("pageFlip1.mp3");
  pageFlip2 =     minim.loadFile("pageFlip2.mp3");
  takeItem =      minim.loadFile("takeItem.mp3"); 
  
  lockerOpen =    minim.loadFile("lockerOpen.mp3");    // if too quiet: "lockerOpenLouder.mp3"
  lockerClosed =  minim.loadFile("lockerClosed1.mp3"); //alternative: "lockerClosed2.mp3"
  drawerOpen =    minim.loadFile("drawerOpen.mp3");     //currently not in use, Clip in Data folder
  drawerClosed =   minim.loadFile("drawerClose.mp3");   //currently not in use, Clip in Data folder
  beep =          minim.loadFile("beep.mp3");
  correctSound =  minim.loadFile("correct.mp3");
  wrongSound =    minim.loadFile("wrong.mp3");
  openDoor =      minim.loadFile("door.mp3");
  
  screw1 =        minim.loadFile("screw1.mp3");
  screw2 =        minim.loadFile("screw2.mp3");
  screw3 =        minim.loadFile("screw3.mp3");

//SOUND - AMBIENCE
  roomTone =      minim.loadFile("roomTone.mp3");
  labAmbience =   minim.loadFile("labAmbience.mp3");
  cityAmbience =  minim.loadFile("cityAmbience.mp3");

}

/*public class SoundManager{

  protected AudioPlayer currentlyPlaying;    //ambience
  protected ArrayList<AudioPlayer> soundEffects = new ArrayList<AudioPlayer>();
  protected ArrayList<AudioPlayer> ambiences = new ArrayList<AudioPlayer>();
  
  SoundManager(){
    minim = new Minim(this);
    currentlyPlaying = minim.loadFile("");
  }
  
  public void addSoundEffect(AudioPlayer soundEffect){
    soundEffects.add(soundEffect);
  }
  public void playSoundEffect(GameObject object){    // will this work?
    object.soundEffect.rewind();
    object.soundEffect.play();
  }
  
  public void playAmbience(Scene scene){            //doesn't work
    scene.ambience.rewind();
    scene.ambience.play();
    //ambience
    
  }  
}*/
