class Scene {

  private String sceneName;
  protected PImage backgroundImage;
  private ArrayList<GameObject> gameObjects;
  private ArrayList<ScannerObject> scannerObjects;
  private ArrayList<ScannerObject> markedForDeathScanGameObjects;
  protected ScannerObject recentScannerObject;

  private ArrayList<GameObject> recentlyAddedGameObjects;
  private ArrayList<GameObject> markedForDeathGameObjects;

  protected boolean hasEntered ;
  protected Dialogue dialogue;
  protected boolean dialogueOnlyOnce;

  private AudioPlayer ambience;
  boolean isCutScene;

  //CUT SCENE: play AudioPlayer ambience(soundEffect) only ONCE when entering the CutScene
  public Scene(String sceneName, String backgroundImageFile, AudioPlayer ambience, boolean isCutScene) {  //if it is a cutscene
    this(sceneName, backgroundImageFile, ambience);
    this.isCutScene = isCutScene;
  }

  //SCENE: play ambience in a loop
  public Scene(String sceneName, String backgroundImageFile, AudioPlayer ambience) {
    this.sceneName = sceneName;

    if (ambience != null) {   
      minim = new Minim(this);
      this.ambience = ambience;                      //if yes load ambience
    }

    this.backgroundImage = loadImage(backgroundImageFile);
    gameObjects = new ArrayList<GameObject>();
    scannerObjects = new ArrayList<ScannerObject>();
    recentScannerObject = new ScannerObject("", 0, 0, 0, 0, "", "");    //nothing

    markedForDeathScanGameObjects = new ArrayList<ScannerObject>();
    markedForDeathGameObjects = new ArrayList<GameObject>(); 
    recentlyAddedGameObjects = new ArrayList<GameObject>();
  }

  /* public void addAmbience(AudioPlayer ambience){
   ambiences.add(ambience);
   }
   */

  public void addGameObject(GameObject object) {
    recentlyAddedGameObjects.add(object);
  }

  public void addScannerObject(ScannerObject scannerObject) {
    scannerObjects.add(scannerObject);                        //add ScannerObject in game
  }
  public void removeScannerObject(ScannerObject object) {
    markedForDeathScanGameObjects.add(object);
  }

  public void removeGameObject(GameObject object) {
    markedForDeathGameObjects.add(object);
  }

  public void updateScene() {
    if (markedForDeathGameObjects.size() > 0) {
      for (GameObject object : markedForDeathGameObjects) {
        gameObjects.remove(object);
      }
      markedForDeathGameObjects  = new ArrayList<GameObject>();
    }
    if (markedForDeathScanGameObjects.size() > 0) {
      for (ScannerObject object : markedForDeathScanGameObjects) {
        scannerObjects.remove(object);
      }
      markedForDeathGameObjects  = new ArrayList<GameObject>();
    }
    if (recentlyAddedGameObjects.size() > 0) {
      for (GameObject object : recentlyAddedGameObjects) {
        gameObjects.add(object);
      }
      recentlyAddedGameObjects  = new ArrayList<GameObject>();
    }
  }

  public void playDialogueOnEnter() {
    if (dialogue != null) {
      if (!hasEntered || !dialogueOnlyOnce) {
        dialogue.activateDialogue();
      }
    }
  }

  public void addDialogueOnEnter(Dialogue dialogue, boolean dialogueOnlyOnce) {
    this.dialogueOnlyOnce = dialogueOnlyOnce;
    this.dialogue = dialogue;
  }

  public void draw(int wwidth, int wheight) {
    image(backgroundImage, 0, 0, wwidth, wheight);
    for (GameObject object : gameObjects) {
      object.draw();
    }
    for (int i = 0; i < scannerObjects.size(); i++) {            //scanner objects
      ScannerObject scannerObject = scannerObjects.get(i);
      scannerObject.display();        //display scannerObject based on in which scene they are in
      //println(inventoryManager.currentId +  " and " + scannerObject.draggingObject);
      if (scannerObject.mouseOverImage) {    //check whether required Dragging Object is over scannerObject
        if (inventoryManager.currentId != null) {
          if ( inventoryManager.currentId.indexOf(scannerObject.draggingObject) >= 0) {                
            scannerObject.isActive = true;        // once it is true create a scenario!
            recentScannerObject = scannerObject;
          }
        }
      }
    }
  } 

  public void mouseMoved() {
    for (GameObject object : gameObjects) {
      object.mouseMoved();
    }
  }

  public void mouseClicked() {
    for (GameObject object : gameObjects) {
      object.mouseClicked();
    }
    for (ScannerObject object : scannerObjects) {
      object.mouseClicked();
    }
  }

  public String getSceneName() {
    return this.sceneName;
  }
}
