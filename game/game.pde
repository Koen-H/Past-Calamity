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
  //TextObject name = new TextObject(String name, Int xPos, Int yPos, Int width, Int height, String imageFile, String Text);//DONT USE THIS ANYMORE
  //GameObject.setHoverImage(String imageFile);
  //Scene.addGameObject(GameObject name);
  //sceneManager.addScene(Scene name);

  //DialogueBox dialogueBox = new DialogueBox(String text); //NOTE: Use \n to create a newline
  //Dialogue dialogue = new Dialogue();// multiple dialogueBoxes will be one dialogue.
  //dialogue.addDialogueBox(dialogueBox); // adds the dialogueBox to the dialogue.
  //dialogueManager.add(dialogue); // add the dialogue to the dialogueManager else it wont work!
  //dialogue.activateDialogue(); // enables the dialogue
  //DialogueObject dialogueObject = new DialogueObject(String identifier, Int xPos, Int yPos, Int width, Int height, String imageFile, Dialogue dialogue); //create a button that enables a dialogue
  //scene.addDialogueOnEnter(Dialogue dialogue, boolean dialogueOnlyOnce) //start a dialogue when the payer enters the scene, enable dialogueOnlyOnce if the dialogue should only happen the first time the player enters the scene.


  DialogueBox testDialogueBox1 = new DialogueBox("Who! this dialogue box works perfect!");
  DialogueBox testDialogueBox2 = new DialogueBox("It even switches to the next one!");
  DialogueBox testDialogueBox3 = new DialogueBox("It even switches to the next one!2");
  Dialogue testDialogue = new Dialogue();
  testDialogue.addDialogueBox(testDialogueBox1);
  testDialogue.addDialogueBox(testDialogueBox2);
  testDialogue.addDialogueBox(testDialogueBox3);
  dialogueManager.add(testDialogue);
  testDialogue.activateDialogue();

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
  Dialogue dialogueCutScene03 = new Dialogue();
  DialogueBox dialogueCutScene03Box01 = new DialogueBox("What happend, it's dark... where am I...");
  DialogueBox dialogueCutScene03Box02 = new DialogueBox("second text here");
  dialogueCutScene03.addDialogueBox(dialogueCutScene03Box01);
  dialogueCutScene03.addDialogueBox(dialogueCutScene03Box02);
  dialogueManager.add(dialogueCutScene03);
  cutScene03.addDialogueOnEnter(dialogueCutScene03, true);
  MoveToSceneObject lightSwitch = new MoveToSceneObject("lightSwitch", 50, 300, 10, 30, "debugblock.png", "scene01");//TODO Remove debugblock
  cutScene03.addGameObject(lightSwitch);
  sceneManager.addScene(cutScene03);

  Scene scene01 = new Scene("scene01", "storyboard3.png");// the lab
  DialogueObject s01Hologram = new DialogueObject("hologram01", 700, 400, 50, 50, "debugblock.png", testDialogue);//hologram text
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
  // sceneManager.goToScene("scene01");
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
  for ( Dialogue dialogue : dialogueManager) dialogue.drawDialogueBox();
}


void mouseMoved() {
  sceneManager.getCurrentScene().mouseMoved();
}

void mouseClicked() {
  if (!isDialogueActive) {
    sceneManager.getCurrentScene().mouseClicked();
    if (sceneManager.getCurrentScene().getSceneName() == "scene02Keypad") {
      for ( keypadButtonObject keypadButton : keypad) keypadButton.clicked();
    }
  } else {
    for ( Dialogue dialogue : dialogueManager) dialogue.nextDialogueBox();
  }
}

//CustomFunctions
