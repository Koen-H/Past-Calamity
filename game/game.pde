int wwidth = 1280;
int wheight = 720;

final SceneManager sceneManager = new SceneManager();
final InventoryManager inventoryManager = new InventoryManager();

void settings()
{
  size(wwidth, wheight);
}

void setup()
{
  //Collectable name = new Collectable(String name, String imageFile);
  //CollectableObject name = new CollectableObject(String name, Int xPos, Int yPos, Int width, Int height, Collectable name);
  //MoveToSceneObject name = new MoveToSceneObject(String name, Int xPos, Int yPos, Int width, Int height, String imageFile, String sceneName);
  //Scene name = new Scene(String name, String sceneBackgroundImageFile);
  //RequireObject name = new RequireObject(String name, Int xPos, Int yPos, Int width, Int height, String imageFile, String text, Collectable name, MoveToSceneObject name);
  //TextObject name = new TextObject(String name, Int xPos, Int yPos, Int width, Int height, String imageFile, String Text);
  //GameObject.setHoverImage(String imageFile);
  //Scene.addGameObject(GameObject name);
  //sceneManager.addScene(Scene name);


  //Main menu
  Scene mainMenu = new Scene("mainMenu", "mainmenu.png"); //TODO update mainmenu.png
  MoveToSceneObject playButton = new MoveToSceneObject("playButton", 350, 300, 300, 300, "debugblock.png", "cutScene01");//TODO Remove debugblock
  playButton.setMethod("doCutScene01"); 
  mainMenu.addGameObject(playButton); 

  Scene cutScene01 = new Scene("cutScene01", "cutscene01.png");
  Scene cutScene02 = new Scene("cutScene02", "cutscene02.png");

  Scene cutScene03 = new Scene("cutScene03", "storyboard2.png");
  MoveToSceneObject lightSwitch = new MoveToSceneObject("lightSwitch", 50, 300, 10, 30, "debugblock.png", "scene01");//TODO Remove debugblock
  cutScene03.addGameObject(lightSwitch); 

  Scene scene01 = new Scene("scene01", "storyboard3.png");
  TextObject hologram01 = new TextObject("hologram01", 700, 400, 50, 50, "debugblock.png", "Hey kids, what's up");
  scene01.addGameObject(hologram01); 



  Scene keypad = new Scene("keypad", "keypad.png");//TODO update keypad.png
  createKeypad(200, 200, 80, 10);//TODO  set coordinates correctly based on keypad.png createkeypad( top left x, top left y, keysize, pixels between keys).
  sceneManager.addScene(mainMenu);
  sceneManager.addScene(cutScene01);
  sceneManager.addScene(cutScene02);
  sceneManager.addScene(cutScene03);
  sceneManager.addScene(scene01);
  sceneManager.addScene(keypad);//zoomed-in keypad scene
} 

void draw()
{
  sceneManager.getCurrentScene().draw(wwidth, wheight);
  sceneManager.getCurrentScene().updateScene();
  inventoryManager.clearMarkedForDeathCollectables();
  if (sceneManager.getCurrentScene().getSceneName() == "keypad") {
    drawKeypad();
  }
  for ( CutScene cutScene : cutScenes) cutScene.update();
}


void mouseMoved() {
  sceneManager.getCurrentScene().mouseMoved();
}

void mouseClicked() {
  sceneManager.getCurrentScene().mouseClicked();
  if (sceneManager.getCurrentScene().getSceneName() == "keypad") {
    for ( keypadButtonObject keypadButton : keypad) keypadButton.clicked();
  }
}

//CustomFunctions
