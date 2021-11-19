class Scene {
  private String sceneName;
  private PImage backgroundImage;
  private ArrayList<GameObject> gameObjects;
  
  private ArrayList<GameObject> recentlyAddedGameObjects;
  private ArrayList<GameObject> markedForDeathGameObjects;      //not in use
  
  public Scene(String sceneName, String backgroundImageFile) {
    this.sceneName = sceneName;
    this.backgroundImage = loadImage(backgroundImageFile);
    gameObjects = new ArrayList<GameObject>();
    
    markedForDeathGameObjects = new ArrayList<GameObject>();  //what for?
    recentlyAddedGameObjects = new ArrayList<GameObject>();
  }
  
  public void addGameObject(GameObject object) {
    recentlyAddedGameObjects.add(object);
  }
  
  public void removeGameObject(GameObject object) {
    markedForDeathGameObjects.add(object);
  }
  
  public void updateScene() {
    if(markedForDeathGameObjects.size() > 0) {
      for(GameObject object : markedForDeathGameObjects) {
        gameObjects.remove(object);
      }
      markedForDeathGameObjects  = new ArrayList<GameObject>();    //Previous one will be replaced by new ArrayList?
    }
    if(recentlyAddedGameObjects.size() > 0) {
      for(GameObject object : recentlyAddedGameObjects) {
        gameObjects.add(object);
      }
      recentlyAddedGameObjects  = new ArrayList<GameObject>();
    }
  }
  
  public void draw(int wwidth, int wheight) {
    image(backgroundImage, 0, 0, wwidth, wheight);
    for(GameObject object : gameObjects) {
      object.draw();
    }
  }
  
  public void mouseMoved() {
    for(GameObject object : gameObjects) {
      object.mouseMoved();
    }
  }
  
  public void mouseClicked() {
    for(GameObject object : gameObjects) {
      object.mouseClicked();
    }
  }
  
  public String getSceneName() {
    return this.sceneName;
  }
}