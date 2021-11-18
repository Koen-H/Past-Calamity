int wwidth = 1280;
int wheight = 720;
boolean currentlyDragging = false;

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
  sceneManager.addScene(mainMenu);

  Scene cutScene01 = new Scene("cutScene01", "cutscene01.png");//playing tag
  sceneManager.addScene(cutScene01);

  Scene cutScene02 = new Scene("cutScene02", "cutscene02.png");//fall in teleporter
  sceneManager.addScene(cutScene02);

  Scene cutScene03 = new Scene("cutScene03", "storyboard2.png");//dark room with a switch
  MoveToSceneObject lightSwitch = new MoveToSceneObject("lightSwitch", 50, 300, 10, 30, "debugblock.png", "scene01");//TODO Remove debugblock
  cutScene03.addGameObject(lightSwitch);
  sceneManager.addScene(cutScene03);

  Scene scene01 = new Scene("scene01", "storyboard3.png");// the lab
  TextObject s01Hologram = new TextObject("hologram01", 700, 400, 50, 50, "debugblock.png", "Hey kids, what's up");//hologram text
  MoveToSceneObject s01GoToDoor = new MoveToSceneObject("s01GoToDoor", 1200, 300, 10, 30, "debugblock.png", "scene02");//go to door scene
  MoveToSceneObject s01ZoomOnPainting = new MoveToSceneObject("s01ZoomOnPainting", 800, 300, 10, 30, "debugblock.png", "scene01Painting");//go to zoomedpainting scene
  //ScannerObject drawerLocker = new ScannerObject("drawerLocker",400,400,20,20, "debuglock.png"); // TODO
  scene01.addGameObject(s01Hologram); 
  scene01.addGameObject(s01ZoomOnPainting); 
  scene01.addGameObject(s01GoToDoor);
  //scene01.addGameObject(drawerLocker);
  sceneManager.addScene(scene01);

  Scene scene01Painting = new Scene("scene01Painting", "zoomedPainting.png");//zoomedIn painting
  MoveToSceneObject s01OpenPainting = new MoveToSceneObject("s01ZoomOutPainting", 800, 300, 10, 30, "debugblock.png", "scene01OpenPainting");//open painting
  MoveToSceneObject s01ZoomOutPainting = new MoveToSceneObject("s01ZoomOutPainting", 640, 680, 50, 50, "arrowDown.png", "scene01");//go back to the lab
  scene01Painting.addGameObject(s01OpenPainting); 
  scene01Painting.addGameObject(s01ZoomOutPainting); 
  sceneManager.addScene(scene01Painting);

  Scene scene01OpenPainting = new Scene("scene01OpenPainting", "zoomedOpenPainting.png");//painting open
  MoveToSceneObject s01ClosePainting = new MoveToSceneObject("s01ClosePainting", 640, 680, 50, 50, "arrowDown.png", "scene01");//close painting
  Collectable drawerKey = new Collectable("drawerKey", "back04_apple.png");
  CollectableObject drawerKeyObj = new CollectableObject("drawerKeyObj", 600, 400, 150, 150, drawerKey);
  scene01OpenPainting.addGameObject(drawerKeyObj); 
  scene01OpenPainting.addGameObject(s01ClosePainting); 
  sceneManager.addScene(scene01OpenPainting);

  Scene scene02 = new Scene("scene02", "scene02doorClosed.png");//door scene
  MoveToSceneObject s02GoToLab = new MoveToSceneObject("s02GoToLab", 50, 360, 50, 50, "arrowLeft.png", "scene01");//go back to the lab
  MoveToSceneObject s02ZoomOnKeypad = new MoveToSceneObject("s02ZoomOnKeypad", 300, 360, 10, 30, "debugblock.png", "scene02Keypad");// go to keypad
  scene02.addGameObject(s02GoToLab); 
  scene02.addGameObject(s02ZoomOnKeypad); 
  sceneManager.addScene(scene02);

  Scene scene02Keypad = new Scene("scene02Keypad", "keypad.png");//zoomed-in keypad scene
  MoveToSceneObject s02KeyPadBack = new MoveToSceneObject("s02KeyPadBack", 640, 680, 50, 50, "arrowDown.png", "scene02");//go to door scene
  scene02Keypad.addGameObject(s02KeyPadBack);
  createKeypad(200, 200, 80, 10);//TODO  set coordinates correctly based on keypad.png createkeypad( top left x, top left y, keysize, pixels between keys).

  sceneManager.addScene(scene02Keypad);

  Scene scene03 = new Scene("scene03", "storyboard7.png");//door scene
  MoveToSceneObject s03GoToDoor = new MoveToSceneObject("s03GoToDoor", 640, 680, 50, 50, "debugblock.png", "scene02");//go back to the door scene
  scene03.addGameObject(s03GoToDoor); 
  sceneManager.addScene(scene03);





  //startGameInScene
  sceneManager.goToScene("scene01");
} 

void draw()
{
  sceneManager.getCurrentScene().draw(wwidth, wheight);
  sceneManager.getCurrentScene().updateScene();
  inventoryManager.clearMarkedForDeathCollectables();
  if (sceneManager.getCurrentScene().getSceneName() == "scene02Keypad") {
    drawKeypad();
  }
  for ( CutScene cutScene : cutScenes) cutScene.update();
  inventoryManager.clearMarkedForDeathCollectables(); //this was already here
  inventoryManager.drawInventory();         // was that here? might need some modification, esp regarding the objects in the inventory
}

void mouseDragged(){
  inventoryManager.mouseDragged();
}

void mouseReleased(){
  inventoryManager.mouseReleased();
  
}


void mouseMoved() {
  sceneManager.getCurrentScene().mouseMoved();
}

void mouseClicked() {
  sceneManager.getCurrentScene().mouseClicked();
  if (sceneManager.getCurrentScene().getSceneName() == "scene02Keypad") {
    for ( keypadButtonObject keypadButton : keypad) keypadButton.clicked();
  }
}

//CustomFunctions
