class Scene {




  private String sceneName;
  protected PImage backgroundImage;
  private ArrayList<GameObject> gameObjects;
  private ArrayList<ScannerObject> scannerObjects;
  protected ScannerObject recentScannerObject;
  
  private ArrayList<GameObject> recentlyAddedGameObjects;
  private ArrayList<GameObject> markedForDeathGameObjects;
  
  


  protected boolean hasEntered ;
  protected Dialogue dialogue;
  protected boolean dialogueOnlyOnce;

  public Scene(String sceneName, String backgroundImageFile) {
    this.sceneName = sceneName;
    this.backgroundImage = loadImage(backgroundImageFile);
    gameObjects = new ArrayList<GameObject>();
    scannerObjects = new ArrayList<ScannerObject>();
    recentScannerObject = new ScannerObject("", 0, 0, 0, 0, "", "");    //nothing
    
    
    markedForDeathGameObjects = new ArrayList<GameObject>(); 
    recentlyAddedGameObjects = new ArrayList<GameObject>();
  }

  public void addGameObject(GameObject object) {
    recentlyAddedGameObjects.add(object);
  }
  
  public void addScannerObject(ScannerObject scannerObject){
    scannerObjects.add(scannerObject);                        //add ScannerObject in game
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
    for(int i = 0; i < scannerObjects.size(); i++){            //scanner objects
      ScannerObject scannerObject = scannerObjects.get(i);
      scannerObject.display();        //display scannerObject based on in which scene they are in
      if(scannerObject.mouseOverImage && scannerObject.draggingObject == inventoryManager.currentId ){    //check whether required Dragging Object is over scannerObject
        println(" YEEEEEE ");                 
        scannerObject.isActive = true;        // once it is true create a scenario!
        recentScannerObject = scannerObject;
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
  }

  public String getSceneName() {
    return this.sceneName;
  }
}
