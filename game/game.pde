int wwidth = 1280;
int wheight = 720;
boolean currentlyDragging = false;
boolean showInventory = false;

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
  // testDialogue.activateDialogue();

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
  DialogueBox dialogueCutScene03Box01 = new DialogueBox("Ouch that hurt...\nAre you okay?");
  DialogueBox dialogueCutScene03Box02 = new DialogueBox("Yeah i think so.");
  DialogueBox dialogueCutScene03Box03 = new DialogueBox("Alright. Stay here. I will turn on the lights.");
  dialogueCutScene03.addDialogueBox(dialogueCutScene03Box01);
  dialogueCutScene03.addDialogueBox(dialogueCutScene03Box02);
  dialogueCutScene03.addDialogueBox(dialogueCutScene03Box03);
  dialogueManager.add(dialogueCutScene03);
  cutScene03.addDialogueOnEnter(dialogueCutScene03, true);
  MoveToSceneObject lightSwitch = new MoveToSceneObject("lightSwitch", 50, 300, 10, 30, "debugblock.png", "scene01");//TODO Remove debugblock
  cutScene03.addGameObject(lightSwitch);
  sceneManager.addScene(cutScene03);

  Scene scene01 = new Scene("scene01", "storyboard3.png");// the lab
  Dialogue dialogueScene01 = new Dialogue();
  DialogueBox dialogueScene01Box01 = new DialogueBox("Wow it's dad's hologram. He looks so old. \nHe has even more gray hairs than he used to have.\nAnd his beard...it's so long.");
  DialogueBox dialogueScene01Box02 = new DialogueBox("Hello there. I hope this message reaches you \nsomewhere in the future. I will soon be killed. \nYou might be wondering what happened to everyone.");
  DialogueBox dialogueScene01Box03 = new DialogueBox("But first i want you to go to my desk. \nInside, you c-can f-fi-find a-");
  DialogueBox dialogueScene01Box04 = new DialogueBox("Dad's hologram ran out of power.");
  dialogueScene01.addDialogueBox(dialogueScene01Box01);
  dialogueScene01.addDialogueBox(dialogueScene01Box02);
  dialogueScene01.addDialogueBox(dialogueScene01Box03);
  dialogueScene01.addDialogueBox(dialogueScene01Box04);
  dialogueManager.add(dialogueScene01);
  scene01.addDialogueOnEnter(dialogueScene01, true);
  //DialogueObject s01Hologram = new DialogueObject("hologram01", 700, 400, 50, 50, "debugblock.png", testDialogue);//hologram text
  MoveToSceneObject s01GoToDoor = new MoveToSceneObject("s01GoToDoor", 1180, 330, 50, 50, "debugblock.png", "scene02");//go to door scene
  MoveToSceneObject s01ZoomOnPainting = new MoveToSceneObject("s01ZoomOnPainting", 800, 300, 10, 30, "debugblock.png", "scene01Painting");//go to zoomedpainting scene
  MoveToSceneObject s01GoToTimeMachine = new MoveToSceneObject("s01GoToTimeMachine", 50, 360, 50, 50, "debugblock.png", "scene01TimeMachine");//go back to the lab
  //ScannerObject drawerLocker = new ScannerObject("drawerLocker",400,400,20,20, "debuglock.png"); // TODO
  ScannerObject s01Frame = new ScannerObject("s01frame", 1000, 200, 150, 150, "frame.png", "drawerKeyObj");
  scene01.addScannerObject(s01Frame);
  //scene01.addGameObject(s01Hologram); 
  scene01.addGameObject(s01ZoomOnPainting); 
  scene01.addGameObject(s01GoToDoor);
  scene01.addGameObject(s01GoToTimeMachine);
  //scene01.addGameObject(drawerLocker);
  sceneManager.addScene(scene01);

  Scene scene01Locker = new Scene("scene01Locker", "lockerZoomed.png");
  Collectable diary = new Collectable("diary", "back04_apple.png");                        
  CollectableObject diaryObj = new CollectableObject("diarylObj", 200, 400, 150, 150, diary);
  Collectable screwDriver = new Collectable("screwDriver", "back04_apple.png");                        
  CollectableObject screwDriverObj = new CollectableObject("powerCellObj", 800, 400, 150, 150, screwDriver);
  MoveToSceneObject sceneLockerBack = new MoveToSceneObject("sceneLockerBack", 640, 680, 50, 50, "debugblock.png", "scene01");
  scene01Locker.addGameObject(sceneLockerBack);
  scene01Locker.addGameObject(diaryObj);
  scene01Locker.addGameObject(screwDriverObj);
  sceneManager.addScene(scene01Locker);



  Scene scene01TimeMachine = new Scene("scene01TimeMachine", "timemachinebackground.png"); //here's the time machine
  MoveToSceneObject s01TimeMachineGoToLab = new MoveToSceneObject("s01TimeMachineGoToLab", 1180, 330, 50, 50, "debugblock.png", "scene01");//go to door scene
  MoveToSceneObject s01TimeMachineGoToScrew = new MoveToSceneObject("s01TimeMachineGoToLab", 840, 640, 50, 50, "debugblock.png", "scene01TimeMachineScrew");//go zoomed Screw
  scene01TimeMachine.addGameObject(s01TimeMachineGoToScrew);
  scene01TimeMachine.addGameObject(s01TimeMachineGoToLab);
  sceneManager.addScene(scene01TimeMachine);

  Scene scene01TimeMachineScrew = new Scene("scene01TimeMachineScrew", "frame.png");
  MoveToSceneObject timeMachineScrewBack = new MoveToSceneObject("timeMachineScrewBack", 640, 680, 50, 50, "debugblock.png", "scene01TimeMachine");//go back to the scene01TimeMachine
  scene01TimeMachineScrew.addGameObject(timeMachineScrewBack);
  sceneManager.addScene(scene01TimeMachineScrew);


  Scene scene01Painting = new Scene("scene01Painting", "zoomedPainting.png");//zoomedIn painting
  Dialogue dialogueScene01Painting = new Dialogue();
  DialogueBox dialogueScene01PaintingBox01 = new DialogueBox("Look, there’s a picture of us and mom!");
  DialogueBox dialogueScene01PaintingBox02 = new DialogueBox("Strange… Dad was never the type to care about \npictures. Especially ones with his family in it. \nI’ll take a closer look.");
  dialogueScene01Painting.addDialogueBox(dialogueScene01PaintingBox01);
  dialogueScene01Painting.addDialogueBox(dialogueScene01PaintingBox02);
  dialogueManager.add(dialogueScene01Painting);
  scene01Painting.addDialogueOnEnter(dialogueScene01Painting, true);
  MoveToSceneObject s01OpenPainting = new MoveToSceneObject("s01ZoomOutPainting", 800, 300, 10, 30, "debugblock.png", "scene01OpenPainting");//open painting
  MoveToSceneObject s01ZoomOutPainting = new MoveToSceneObject("s01ZoomOutPainting", 640, 680, 50, 50, "arrowDown.png", "scene01");//go back to the lab
  scene01Painting.addGameObject(s01OpenPainting); 
  scene01Painting.addGameObject(s01ZoomOutPainting); 
  sceneManager.addScene(scene01Painting);

  Scene scene01OpenPainting = new Scene("scene01OpenPainting", "zoomedOpenPainting.png");//painting open
  MoveToSceneObject s01ClosePainting = new MoveToSceneObject("s01ClosePainting", 640, 680, 50, 50, "arrowDown.png", "scene01");//close painting
  Collectable drawerKey = new Collectable("drawerKey", "back04_apple.png");                                ///////APPLE
  CollectableObject drawerKeyObj = new CollectableObject("drawerKeyObj", 600, 400, 150, 150, drawerKey);   //drawerKeyObj is identifier
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

  Scene scene03 = new Scene("scene03", "storyboard7.png");//outside car scene
  MoveToSceneObject s03GoToDoor = new MoveToSceneObject("s03GoToDoor", 640, 680, 50, 50, "debugblock.png", "scene02");//go back to the door scene
  MoveToSceneObject s03GoToS04 = new MoveToSceneObject("s03GoToS04", 1170, 330, 50, 50, "debugblock.png", "scene04");//continue scene
  Collectable teddy = new Collectable("teddy", "back04_apple.png");                            
  CollectableObject teddyObj = new CollectableObject("teddyObj", 600, 400, 150, 150, teddy);
  scene03.addGameObject(teddyObj);
  scene03.addGameObject(s03GoToDoor); 
  scene03.addGameObject(s03GoToS04); 
  sceneManager.addScene(scene03);

  Scene scene04 = new Scene("scene04", "storyboard8.png");//walking to city, emergency board
  MoveToSceneObject s04GoToS03 = new MoveToSceneObject("s04GoToS03", 640, 680, 50, 50, "debugblock.png", "scene03");//go back a scene
  MoveToSceneObject s04GoToS05 = new MoveToSceneObject("s04GoToS05", 900, 330, 50, 50, "debugblock.png", "scene05");//continue scene
  scene04.addGameObject(s04GoToS03); 
  scene04.addGameObject(s04GoToS05); 
  sceneManager.addScene(scene04);

  Scene scene05 = new Scene("scene05", "storyboard9.png");//found a store scene
  MoveToSceneObject s05GoToS04 = new MoveToSceneObject("s05GoToS04", 640, 680, 50, 50, "debugblock.png", "scene04");
  MoveToSceneObject s05GoToS07 = new MoveToSceneObject("s05GoToS07", 1180, 330, 50, 50, "debugblock.png", "scene07");
  Collectable crowbar = new Collectable("crowbar", "back04_apple.png");                        
  CollectableObject crowbaObj = new CollectableObject("crowbaObj", 600, 400, 150, 150, crowbar);
  //needs a scannerobject to open the store's door make the functionality use scene05.addGameObject();  so it will add the game object, see how I did the keyapd door as example
  //for now, an object to go to the next scene
  MoveToSceneObject s05GoToS06 = new MoveToSceneObject("s05GoToS06", 640, 300, 50, 50, "debugblock.png", "scene06");
  scene05.addGameObject(s05GoToS04); 
  scene05.addGameObject(s05GoToS06); //replace this with scannerobject
  scene05.addGameObject(s05GoToS07);
  scene05.addGameObject(crowbaObj); 
  sceneManager.addScene(scene05);

  Scene scene06 = new Scene("scene06", "storyboard9.png");//inside a store scene
  MoveToSceneObject s06GoToS05 = new MoveToSceneObject("s06GoToS05", 640, 680, 50, 50, "debugblock.png", "scene05");
  Collectable powerCell01 = new Collectable("powerCell", "back04_apple.png");                        
  CollectableObject powerCellObj01 = new CollectableObject("powerCellObj", 600, 400, 150, 150, powerCell01);
  Collectable powerCell02 = new Collectable("powerCell", "back04_apple.png");                        
  CollectableObject powerCellObj02 = new CollectableObject("powerCellObj", 600, 400, 150, 150, powerCell02);
  Collectable powerCell03 = new Collectable("powerCell", "back04_apple.png");                        
  CollectableObject powerCellObj03 = new CollectableObject("powerCellObj", 600, 400, 150, 150, powerCell03);
  Collectable powerCell04 = new Collectable("powerCell", "back04_apple.png");                        
  CollectableObject powerCellObj04 = new CollectableObject("powerCellObj", 600, 400, 150, 150, powerCell04);
  Collectable powerCell05 = new Collectable("powerCell", "back04_apple.png");                        
  CollectableObject powerCellObj05 = new CollectableObject("powerCellObj", 600, 400, 150, 150, powerCell05);
  //needs a scannerobject to open the store's door make the functionality use scene05.addGameObject();  so it will add the game object, see how I did the keyapd door as example
  //for now, an object to go to the next scene
  scene06.addGameObject(s06GoToS05); 
  scene06.addGameObject(powerCellObj01);
  scene06.addGameObject(powerCellObj02); 
  scene06.addGameObject(powerCellObj03); 
  scene06.addGameObject(powerCellObj04); 
  scene06.addGameObject(powerCellObj05); 
  sceneManager.addScene(scene06);

  Scene scene07 = new Scene("scene07", "storyboard9.png");//holograms in city scene
  MoveToSceneObject s07GoToS05 = new MoveToSceneObject("s05GoToS04", 50, 330, 50, 50, "debugblock.png", "scene05");
  //this scene needs holograms (scanObjects) they will provide dialogue with lore if a battery is dragged on top of it.
  //
  scene07.addGameObject(s07GoToS05); 
  sceneManager.addScene(scene07);








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
  if (showInventory) {
    inventoryManager.drawInventory();
  }
  for ( Dialogue dialogue : dialogueManager) dialogue.drawDialogueBox();
}

void mouseDragged() {
  inventoryManager.mouseDragged();
}

void mouseReleased() {
  inventoryManager.mouseReleased();
}


void mouseMoved() {
  sceneManager.getCurrentScene().mouseMoved();
}

void mouseClicked() {
  if (mouseButton == RIGHT) {                                    //temporary! --> later make an icon (top right/topleft of screen for this functionality)
    if (showInventory) { 
      showInventory = false;
    } //you can use showInventory = !showInventory to make it change from false to true and vica versa.
    else { 
      showInventory = true;
    }
  }
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
