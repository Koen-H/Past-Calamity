int wwidth = 1280;
int wheight = 720;
boolean currentlyDragging = false;
boolean showInventory = false;

boolean playDialogue = true;

//INITIALIZE Inventory + SCANNER OBJECTS + SCENE
InventoryButton inventoryButton;
ScannerObject s01Drawer;

ScannerObject timeScrew1, timeScrew2, timeScrew3, timeScrew4, timeBattery1, timeBattery2;
//timeScrew variables;
boolean timeScrew1B, timeScrew2B, timeScrew3B, timeScrew4B, timeMachineScrewed, timeBattery1B, timeBattery2B, timeBatterySolved;

//hologram variables
//boolean holo1Screw1B, holo1Screw2B, holo1Active, holo2Screw1B, holo2Screw2B, holo3Screw1B, holo3Screw2B;

final SceneManager sceneManager = new SceneManager();
final InventoryManager inventoryManager = new InventoryManager();

void settings()
{
  size(wwidth, wheight);
}

void setup()
{
  frameRate(30);
  textFont(createFont("neo-latina-demo-FFP.ttf", 32));
  //Collectable name = new Collectable(String name, String imageFile);
  //CollectableObject name = new CollectableObject(String name, Int xPos, Int yPos, Int width, Int height, Collectable name);
  //MoveToSceneObject name = new MoveToSceneObject(String name, Int xPos, Int yPos, Int width, Int height, String imageFile, String sceneName);
  //Scene name = new Scene(String name, String sceneBackgroundImageFile);
  //RequireObject name = new RequireObject(String name, Int xPos, Int yPos, Int width, Int height, String imageFile, String text, Collectable name, MoveToSceneObject name);
  //TextObject name = new TextObject(String name, Int xPos, Int yPos, Int width, Int height, String imageFile, String Text);
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

  SpriteCharacter finn = new SpriteCharacter("Finn", "FinnTalk.png");
  SpriteCharacter lila = new SpriteCharacter("Lila", "LilaTalk.png");
  SpriteCharacter dad = new SpriteCharacter("Dad (Hank)", "characterSpritetest.png");
  SpriteCharacter news_reporter = new SpriteCharacter("News Reporter", "characterSpritetest.png");

  DialogueBox testDialogueBox1 = new DialogueBox("Who! this dialogue box works perfect!", finn);
  DialogueBox testDialogueBox2 = new DialogueBox("It even switches to the next one!", dad);
  DialogueBox testDialogueBox3 = new DialogueBox("It even switches to the next one!2", lila);
  Dialogue testDialogue = new Dialogue();
  testDialogue.addDialogueBox(testDialogueBox1);
  testDialogue.addDialogueBox(testDialogueBox2);
  testDialogue.addDialogueBox(testDialogueBox3);
  dialogueManager.add(testDialogue);
  // testDialogue.activateDialogue();

  //All Dialogue
  Dialogue dialogueCutScene03 = new Dialogue();
  DialogueBox dialogueCutScene03Box01 = new DialogueBox("Ow my head! What in the world happened!", finn);
  DialogueBox dialogueCutScene03Box02 = new DialogueBox("Lila, where are you??! Are you okay??!", finn);
  DialogueBox dialogueCutScene03Box03 = new DialogueBox("Finn, Help it’s so dark?  \nI’m scared Finn!", lila);
  DialogueBox dialogueCutScene03Box04 = new DialogueBox("It’s gonna be alright Lila, I am here!", finn);
  dialogueCutScene03.addDialogueBox(dialogueCutScene03Box01);
  dialogueCutScene03.addDialogueBox(dialogueCutScene03Box02);
  dialogueCutScene03.addDialogueBox(dialogueCutScene03Box03);
  dialogueCutScene03.addDialogueBox(dialogueCutScene03Box04);
  dialogueManager.add(dialogueCutScene03);

  Dialogue dialogueScene01 = new Dialogue();
  DialogueBox dialogueScene01Box01 = new DialogueBox("Who is that in the hologram?", finn);
  DialogueBox dialogueScene01Box02 = new DialogueBox("Hello Finn, Hello Lila, \nI wish I could see you in person. \nBut I’m afraid that it is too late", dad);
  DialogueBox dialogueScene01Box03 = new DialogueBox("I have a lot of regrets, \nI should have been a better father.", dad);
  DialogueBox dialogueScene01Box04 = new DialogueBox("For the… Last 18 years... \nI... been trying….. \nget... back, desk... drawer...", dad);
  DialogueBox dialogueScene01Box05 = new DialogueBox("Was that dad? Where is dad? \nHe is always in his lab!", lila);
  DialogueBox dialogueScene01Box06 = new DialogueBox("I think it was, but he never was so... Caring.\nHe also said something strange at the end.", finn);
  dialogueScene01.addDialogueBox(dialogueScene01Box01);
  dialogueScene01.addDialogueBox(dialogueScene01Box02);
  dialogueScene01.addDialogueBox(dialogueScene01Box03);
  dialogueScene01.addDialogueBox(dialogueScene01Box04);
  dialogueScene01.addDialogueBox(dialogueScene01Box05);
  dialogueScene01.addDialogueBox(dialogueScene01Box06);
  dialogueManager.add(dialogueScene01);

  Dialogue dialogueScene01Painting = new Dialogue();
  DialogueBox dialogueScene01PaintingBox01 = new DialogueBox("Look,it’s a picture of us with Mom! \nYou make a funny face!", lila);
  DialogueBox dialogueScene01PaintingBox02 = new DialogueBox("I remember when we took this picture \nbefore she passed away.", finn);
  dialogueScene01Painting.addDialogueBox(dialogueScene01PaintingBox01);
  dialogueScene01Painting.addDialogueBox(dialogueScene01PaintingBox02);
  dialogueManager.add(dialogueScene01Painting);

  Dialogue dialogueScene01OpenPainting = new Dialogue();
  DialogueBox dialogueScene01OpenPaintingBox01 = new DialogueBox("This could be useful!", finn);
  dialogueScene01OpenPainting.addDialogueBox(dialogueScene01OpenPaintingBox01);
  dialogueManager.add(dialogueScene01OpenPainting);

  Dialogue dialogueScene01OpenDrawer = new Dialogue();
  DialogueBox dialogueScene01OpenDrawerBox01 = new DialogueBox("It's a book!", lila);
  DialogueBox dialogueScene01OpenDrawerBox02 = new DialogueBox("It’s dad’s Notebook? I didn't even know he had a notebook.", finn);
  dialogueScene01OpenDrawer.addDialogueBox(dialogueScene01OpenDrawerBox01);
  dialogueScene01OpenDrawer.addDialogueBox(dialogueScene01OpenDrawerBox02);
  dialogueManager.add(dialogueScene01OpenDrawer);

  Dialogue dialogueOpenBook = new Dialogue();
  DialogueBox dialogueOpenBookBox01 = new DialogueBox("Huh?? Christmas is in about 3 weeks. What is he talking about?", finn);
  DialogueBox dialogueOpenBookBox02 = new DialogueBox("He never said that he loved us!", lila);
  DialogueBox dialogueOpenBookBox03 = new DialogueBox("The way he says things is strange, something must be off!", finn);
  dialogueScene01OpenDrawer.addDialogueBox(dialogueOpenBookBox01);
  dialogueScene01OpenDrawer.addDialogueBox(dialogueOpenBookBox02);
  dialogueScene01OpenDrawer.addDialogueBox(dialogueOpenBookBox03);
  dialogueManager.add(dialogueOpenBook);

  Dialogue pickUpCard = new Dialogue();
  DialogueBox pickUpCardBox01 = new DialogueBox("Let’s take this with us just in case.", finn);
  pickUpCard.addDialogueBox(pickUpCardBox01);
  dialogueManager.add(pickUpCard);

  Dialogue doorNotOpen = new Dialogue();
  DialogueBox doorNotOpenBox1 = new DialogueBox("Shit! Maybe it's something else", finn);
  DialogueBox doorNotOpenBox2 = new DialogueBox("The door won't open.", lila);
  DialogueBox doorNotOpenBox3 = new DialogueBox("I see that Lila, thanks.", finn);
  doorNotOpen.addDialogueBox(doorNotOpenBox1);
  doorNotOpen.addDialogueBox(doorNotOpenBox2);
  doorNotOpen.addDialogueBox(doorNotOpenBox3);
  dialogueManager.add(doorNotOpen);

  Dialogue doorOpen = new Dialogue();
  DialogueBox doorOpenBox1 = new DialogueBox("I knew something was off!", finn);
  DialogueBox doorOpenBox2 = new DialogueBox("Maybe dad is just getting food.", lila);
  doorOpen.addDialogueBox(doorOpenBox1);
  doorOpen.addDialogueBox(doorOpenBox2);
  dialogueManager.add(doorOpen);

  Dialogue outsideHouse = new Dialogue();
  DialogueBox outsideHouseBox1 = new DialogueBox("The house was not that green before!", lila);
  DialogueBox outsideHouseBox2 = new DialogueBox("No… Could it be?.... Are we in… The future?", finn);
  outsideHouse.addDialogueBox(outsideHouseBox1);
  outsideHouse.addDialogueBox(outsideHouseBox2);
  dialogueManager.add(doorOpen);

  Dialogue teddyPickUp = new Dialogue();
  DialogueBox teddyPickUpBox1 = new DialogueBox("OHH MY GOD, MISTER GRIZZY(jeff). There you are!", lila);
  DialogueBox teddyPickUpBox2 = new DialogueBox("Why was the bear so secured? \nAnyway let's head to the city to get some Nexxon Cells", finn);
  teddyPickUp.addDialogueBox(teddyPickUpBox1);
  teddyPickUp.addDialogueBox(teddyPickUpBox2);
  dialogueManager.add(doorOpen);

  Dialogue foundAlert = new Dialogue();
  DialogueBox foundAlertBox1 = new DialogueBox("Oh wow. An emergency alert message. I wonder what got everyone so panicked.", finn);
  DialogueBox foundAlertBox2 = new DialogueBox("Maybe they also lost their Mr Grizzies.", lila);
  foundAlert.addDialogueBox(foundAlertBox1);
  foundAlert.addDialogueBox(foundAlertBox2);
  dialogueManager.add(foundAlert);

  Dialogue enterStore = new Dialogue();
  DialogueBox enterStoreBox1 = new DialogueBox("Don’t we have to pay before we take them?", lila);
  DialogueBox enterStoreBox2 = new DialogueBox("In cases like these, you can just take them Lila.", finn);
  enterStore.addDialogueBox(enterStoreBox1);
  enterStore.addDialogueBox(enterStoreBox2);
  dialogueManager.add(enterStore);

  Dialogue foundHologram = new Dialogue();
  DialogueBox foundHologramBox1 = new DialogueBox("I have raided one of these once, they need one Nexxon Cell I think.", finn);
  foundHologram.addDialogueBox(foundHologramBox1);
  dialogueManager.add(foundHologram);

  Dialogue activatedHologram = new Dialogue();
  DialogueBox activatedHologramBox1 = new DialogueBox("I’ve still got it!", finn);
  DialogueBox activatedHologramBox2 = new DialogueBox("Ever since the launch day, things have gone south. Casualties have doubled since yesterday… Watch….. Out…. stay…….Safe………", news_reporter);
  DialogueBox activatedHologramBox3 = new DialogueBox("Must be an older projector.", finn);
  DialogueBox activatedHologramBox4 = new DialogueBox("Must be an older  projector.\nI don't want to know what those poor people went through.", finn);
  DialogueBox activatedHologramBox5 = new DialogueBox("Finn, what was the news man talking about?", lila);
  DialogueBox activatedHologramBox6 = new DialogueBox("He said that a lot of people moved away, Lila.", finn);
  activatedHologram.addDialogueBox(activatedHologramBox1);
  activatedHologram.addDialogueBox(activatedHologramBox2);  
  activatedHologram.addDialogueBox(activatedHologramBox3);  
  activatedHologram.addDialogueBox(activatedHologramBox4);  
  activatedHologram.addDialogueBox(activatedHologramBox5);  
  activatedHologram.addDialogueBox(activatedHologramBox6);
  dialogueManager.add(activatedHologram);

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

  Scene cutScene03 = new Scene("cutScene03", "labfutureoff.png");//dark room with a switch

  cutScene03.addDialogueOnEnter(dialogueCutScene03, true);
  MoveToSceneObject lightSwitch = new MoveToSceneObject("lightSwitch", 360, 349, 35, 40, "scene01");
  cutScene03.addGameObject(lightSwitch);
  sceneManager.addScene(cutScene03);

  Scene scene01 = new Scene("scene01", "labfutureon.png");// the lab

  scene01.addDialogueOnEnter(dialogueScene01, true);
  //DialogueObject s01Hologram = new DialogueObject("hologram01", 700, 400, 50, 50, "debugblock.png", testDialogue);//hologram text
  MoveToSceneObject s01GoToDoor = new MoveToSceneObject("s01GoToDoor", 1180, 330, 50, 50, "debugblock.png", "scene02");//go to door scene
  s01GoToDoor.setHoverImage("frame.png");
  MoveToSceneObject s01ZoomOnPainting = new MoveToSceneObject("s01ZoomOnPainting", 755, 356, 80, 70, "scene01Painting");//go to zoomedpainting scene

  MoveToSceneObject s01GoToTimeMachine = new MoveToSceneObject("s01GoToTimeMachine", 50, 360, 50, 50, "debugblock.png", "scene01TimeMachine");//go back to the lab
  s01GoToTimeMachine.setHoverImage("frame.png");
  s01Drawer = new ScannerObject("s01Drawer", 1090, 429, 40, 40, "drawerKeyObj" ); //
  //ScannerObject s01Frame = new ScannerObject("s01frame", 1000, 200, 150, 150, "frame.png", "drawerKeyObj");
  scene01.addScannerObject(s01Drawer);
  //scene01.addGameObject(s01Hologram); 
  scene01.addGameObject(s01ZoomOnPainting); 
  scene01.addGameObject(s01GoToDoor);
  scene01.addGameObject(s01GoToTimeMachine);
  //scene01.addGameObject(drawerLocker);
  sceneManager.addScene(scene01);
  inventoryButton = new InventoryButton(20, 20, 50, 50, "back04_apple.png");

  Scene scene01Locker = new Scene("scene01Locker", "lockerZoomed.png");
  Collectable diary = new Collectable("diary", "Notebook.png");                        
  CollectableObject diaryObj = new CollectableObject("diaryObj", 200, 400, 150, 150, diary, false, false);
  Collectable screwDriver = new Collectable("screwDriver", "Screwed.png");                        
  CollectableObject screwDriverObj = new CollectableObject("screwDriverObj", 800, 400, 150, 150, screwDriver, false, false);
  MoveToSceneObject sceneLockerBack = new MoveToSceneObject("sceneLockerBack", 640, 680, 50, 50, "debugblock.png", "scene01");
  scene01Locker.addGameObject(sceneLockerBack);
  scene01Locker.addGameObject(diaryObj);
  scene01Locker.addGameObject(screwDriverObj);
  sceneManager.addScene(scene01Locker);



  Scene scene01TimeMachine = new Scene("scene01TimeMachine", "timemachinefuture.png"); //here's the time machine
  MoveToSceneObject s01TimeMachineGoToLab = new MoveToSceneObject("s01TimeMachineGoToLab", 1180, 330, 50, 50, "debugblock.png", "scene01");//go to door scene
  MoveToSceneObject s01TimeMachineGoToScrew = new MoveToSceneObject("s01TimeMachineGoToScrew", 570, 248, 130, 100, "scene01TimeMachineScrew");//go zoomed Screw
  MoveToSceneObject s01TimeMachineGoToTimeKeypad= new MoveToSceneObject("s01TimeMachineGoToTimeKeypad", 1023, 239, 126, 160, "scene01TimeMachineKeyPad");//go zoomed keypad
  scene01TimeMachine.addGameObject(s01TimeMachineGoToScrew);
  scene01TimeMachine.addGameObject(s01TimeMachineGoToLab);
  scene01TimeMachine.addGameObject(s01TimeMachineGoToTimeKeypad);
  sceneManager.addScene(scene01TimeMachine);

  Scene scene01TimeMachineScrew = new Scene("scene01TimeMachineScrew", "debugblock.png");
  MoveToSceneObject timeMachineScrewBack = new MoveToSceneObject("timeMachineScrewBack", 640, 680, 50, 50, "debugblock.png", "scene01TimeMachine");//go back to the scene01TimeMachine
  timeScrew1 = new ScannerObject(" timeScrew1", 50, 50, 20, 20, "frame.png", "screwDriverObj");
  timeScrew2 = new ScannerObject(" timeScrew2", 50, 400, 20, 20, "frame.png", "screwDriverObj");
  timeScrew3 = new ScannerObject(" timeScrew3", 600, 400, 20, 20, "frame.png", "screwDriverObj");
  timeScrew4 = new ScannerObject(" timeScrew4", 600, 50, 20, 20, "frame.png", "screwDriverObj");
  timeBattery1 = new ScannerObject("timeBattery1", 1000, 400, 20, 20, "frame.png", "powerCell");
  timeBattery2 = new ScannerObject("timeBattery2", 1000, 50, 20, 20, "frame.png", "powerCell");
  scene01TimeMachineScrew.addScannerObject( timeScrew1);
  scene01TimeMachineScrew.addScannerObject( timeScrew2);
  scene01TimeMachineScrew.addScannerObject( timeScrew3);
  scene01TimeMachineScrew.addScannerObject( timeScrew4);
  scene01TimeMachineScrew.addGameObject(timeMachineScrewBack);
  sceneManager.addScene(scene01TimeMachineScrew);

  Scene scene01TimeMachineKeyPad = new Scene("scene01TimeMachineKeyPad", "zoom_keypad.png");
  createTimeKeypad(521, 321, 60, 15);//TODO  set coordinates correctly based on keypad.png createkeypad( top left x, top left y, keysize, pixels between keys).
  sceneManager.addScene(scene01TimeMachineKeyPad);


  Scene scene01Painting = new Scene("scene01Painting", "zoomedPainting.png");//zoomedIn painting
  MoveToSceneObject s01OpenPainting = new MoveToSceneObject("s01ZoomOutPainting", 800, 300, 10, 30, "debugblock.png", "scene01OpenPainting");//open painting
  MoveToSceneObject s01ZoomOutPainting = new MoveToSceneObject("s01ZoomOutPainting", 640, 680, 50, 50, "arrowDown.png", "scene01");//go back to the lab
  scene01Painting.addGameObject(s01OpenPainting); 
  scene01Painting.addGameObject(s01ZoomOutPainting);
  scene01Painting.addDialogueOnEnter(dialogueScene01Painting, true);
  sceneManager.addScene(scene01Painting);

  Scene scene01OpenPainting = new Scene("scene01OpenPainting", "zoomedOpenPainting.png");//painting open
  MoveToSceneObject s01ClosePainting = new MoveToSceneObject("s01ClosePainting", 640, 680, 50, 50, "arrowDown.png", "scene01");//close painting
  Collectable drawerKey = new Collectable("drawerKey", "key.png");                                   
  CollectableObject drawerKeyObj = new CollectableObject("drawerKeyObj", 600, 400, 150, 150, drawerKey, true, false);   //drawerKeyObj is identifier
  scene01OpenPainting.addDialogueOnEnter(dialogueScene01OpenPainting, true);
  scene01OpenPainting.addGameObject(drawerKeyObj); 
  scene01OpenPainting.addGameObject(s01ClosePainting); 
  sceneManager.addScene(scene01OpenPainting);

  Scene scene02 = new Scene("scene02", "door.png");//door scene
  MoveToSceneObject s02GoToLab = new MoveToSceneObject("s02GoToLab", 50, 360, 50, 50, "arrowLeft.png", "scene01");//go back to the lab
  MoveToSceneObject s02ZoomOnKeypad = new MoveToSceneObject("s02ZoomOnKeypad", 199, 275, 100, 150, "scene02Keypad");// go to keypad
  scene02.addGameObject(s02GoToLab); 
  scene02.addGameObject(s02ZoomOnKeypad); 
  sceneManager.addScene(scene02);

  Scene scene02Keypad = new Scene("scene02Keypad", "keyzoomdoor.png");//zoomed-in keypad scene
  MoveToSceneObject s02KeyPadBack = new MoveToSceneObject("s02KeyPadBack", 640, 680, 50, 50, "arrowDown.png", "scene02");//go to door scene
  scene02Keypad.addGameObject(s02KeyPadBack);
  createKeypad(493, 307, 60, 10);//TODO  set coordinates correctly based on keypad.png createkeypad( top left x, top left y, keysize, pixels between keys).

  sceneManager.addScene(scene02Keypad);

  Scene scene03 = new Scene("scene03", "housecrop.png");//outside car scene
  MoveToSceneObject s03GoToDoor = new MoveToSceneObject("s03GoToDoor", 640, 680, 50, 50, "debugblock.png", "scene02");//go back to the door scene
  MoveToSceneObject s03GoToS04 = new MoveToSceneObject("s03GoToS04", 1170, 330, 50, 50, "debugblock.png", "scene04");//continue scene
  Collectable teddy = new Collectable("teddy", "back04_apple.png");                            
  CollectableObject teddyObj = new CollectableObject("teddyObj", 600, 400, 150, 150, teddy, false, false);
  scene03.addGameObject(teddyObj);
  scene03.addGameObject(s03GoToDoor); 
  scene03.addGameObject(s03GoToS04);
  scene03.addDialogueOnEnter(outsideHouse, true);
  sceneManager.addScene(scene03);

  Scene scene04 = new Scene("scene04", "city.png");//walking to city, emergency board
  MoveToSceneObject s04GoToS03 = new MoveToSceneObject("s04GoToS03", 640, 680, 50, 50, "debugblock.png", "scene03");//go back a scene
  MoveToSceneObject s04GoToS05 = new MoveToSceneObject("s04GoToS05", 900, 330, 50, 50, "debugblock.png", "scene05");//continue scene
  scene04.addGameObject(s04GoToS03); 
  scene04.addGameObject(s04GoToS05); 
  sceneManager.addScene(scene04);

  Scene scene05 = new Scene("scene05", "store.png");//found a store scene
  MoveToSceneObject s05GoToS04 = new MoveToSceneObject("s05GoToS04", 640, 680, 50, 50, "debugblock.png", "scene04");
  MoveToSceneObject s05GoToS07 = new MoveToSceneObject("s05GoToS07", 1180, 330, 50, 50, "debugblock.png", "scene07");
  Collectable crowbar = new Collectable("crowbar", "back04_apple.png");                        
  CollectableObject crowbaObj = new CollectableObject("crowbaObj", 600, 400, 150, 150, crowbar, false, false);
  //needs a scannerobject to open the store's door make the functionality use scene05.addGameObject();  so it will add the game object, see how I did the keyapd door as example
  //for now, an object to go to the next scene
  MoveToSceneObject s05GoToS06 = new MoveToSceneObject("s05GoToS06", 640, 300, 50, 50, "debugblock.png", "scene06");
  scene05.addGameObject(s05GoToS04); 
  scene05.addGameObject(s05GoToS06); //replace this with scannerobject
  scene05.addGameObject(s05GoToS07);
  scene05.addGameObject(crowbaObj); 

  sceneManager.addScene(scene05);

  Scene scene06 = new Scene("scene06", "inside_store.png");//inside a store scene
  MoveToSceneObject s06GoToS05 = new MoveToSceneObject("s06GoToS05", 640, 680, 50, 50, "debugblock.png", "scene05");
  Collectable powerCell01 = new Collectable("powerCell1", "Battery1.png");                        
  CollectableObject powerCellObj01 = new CollectableObject("powerCellObj1", 20, 400, 150, 150, powerCell01, true, false);
  Collectable powerCell02 = new Collectable("powerCell2", "Battery1.png");                        
  CollectableObject powerCellObj02 = new CollectableObject("powerCellObj2", 200, 400, 150, 150, powerCell02, true, false);
  Collectable powerCell03 = new Collectable("powerCell3", "Battery1.png");                        
  CollectableObject powerCellObj03 = new CollectableObject("powerCellObj3", 300, 400, 150, 150, powerCell03, true, false);
  Collectable powerCell04 = new Collectable("powerCell4", "Battery1.png");                        
  CollectableObject powerCellObj04 = new CollectableObject("powerCellObj4", 500, 400, 150, 150, powerCell04, true, false);
  Collectable powerCell05 = new Collectable("powerCell5", "Battery1.png");                        
  CollectableObject powerCellObj05 = new CollectableObject("powerCellObj5", 600, 800, 150, 150, powerCell05, true, false);
  //needs a scannerobject to open the store's door make the functionality use scene05.addGameObject();  so it will add the game object, see how I did the keyapd door as example
  //for now, an object to go to the next scene
  scene06.addGameObject(s06GoToS05); 
  scene06.addGameObject(powerCellObj01);
  scene06.addGameObject(powerCellObj02); 
  scene06.addGameObject(powerCellObj03); 
  scene06.addGameObject(powerCellObj04); 
  scene06.addGameObject(powerCellObj05);
  scene06.addDialogueOnEnter(enterStore, true);
  sceneManager.addScene(scene06);

  Scene scene07 = new Scene("scene07", "billboard.png");//alert sign
  MoveToSceneObject s07GoToS05 = new MoveToSceneObject("s05GoToS04", 50, 330, 50, 50, "debugblock.png", "scene05");

  scene07.addGameObject(s07GoToS05); 
  scene07.addDialogueOnEnter(foundAlert, true);
  sceneManager.addScene(scene07);

  //startGameInScene
  sceneManager.goToScene("scene01");
} 

void draw()
{ 
  // SCANNER OBJECTS SCENARIOS ( koen: Scannerobjects should be deleted and isActive = false after they've been used)
  if (s01Drawer.isActive) {
    println("Drawer opened");
    s01Drawer.isActive = false; //if not set to false all ItemObjects will be removed at once!
    sceneManager.getCurrentScene().removeScannerObject(s01Drawer);
    MoveToSceneObject s01ZoomOnLocker = new MoveToSceneObject("s01ZoomOnLocker", 1080, 423, 140, 53, "scene01Locker");//go to zoomedLocker scene
    sceneManager.getCurrentScene().addGameObject(s01ZoomOnLocker);
    sceneManager.goToScene("scene01Locker");
    // sceneManager.getCurrentScene().addGameObject(s01Test);
  }

  if (timeScrew1.isActive) {
    timeScrew1.isActive = false;
    timeScrew1B = true;
    sceneManager.getCurrentScene().removeScannerObject(timeScrew1);
    checkTimeMachineScrew();
    println("Screwed timeScre1");
  }
  if (timeScrew2.isActive) {
    timeScrew2.isActive = false;
    timeScrew2B = true;
    sceneManager.getCurrentScene().removeScannerObject(timeScrew2);
    checkTimeMachineScrew();
    println("Screwed timeScre2");
  }
  if (timeScrew3.isActive) {
    timeScrew3.isActive = false;
    timeScrew3B = true;
    sceneManager.getCurrentScene().removeScannerObject(timeScrew3);
    checkTimeMachineScrew();
    println("Screwed timeScre3");
  }
  if (timeScrew4.isActive) {
    timeScrew4.isActive = false;
    timeScrew4B = true;
    sceneManager.getCurrentScene().removeScannerObject(timeScrew4);
    checkTimeMachineScrew();
    println("Screwed timeScre4");
  }
  if (timeBattery1.isActive) {
    timeBattery1.isActive = false;
    timeBattery1B = true;
    sceneManager.getCurrentScene().removeScannerObject(timeBattery1);//next line should replace it with a battery sprite

    checkTimeMachineBattery();
    println("Loaded battery 1");
  }
  if (timeBattery2.isActive) {
    timeBattery2.isActive = false;
    timeBattery2B = true;
    sceneManager.getCurrentScene().removeScannerObject(timeBattery2);
    checkTimeMachineBattery();
    println("Loaded battery 2");
  }

  /** if (holo1Screw1.isActive) {
   holo1Screw1.isActive = false;
   holo1Screw1B = true;
   sceneManager.getCurrentScene().removeScannerObject(holoScrew1);
   if (holo1Screw2B) {
   //summon battery
   }
   }
   if (holo1Screw2.isActive) {
   holo1Screw2.isActive = false;
   holo1Screw1B = true;
   sceneManager.getCurrentScene().removeScannerObject(holoScrew2);
   if (holo1Screw1B) {
   //summon battery
   }
   }*/



  sceneManager.getCurrentScene().draw(wwidth, wheight);
  sceneManager.getCurrentScene().updateScene();
  //inventoryManager.clearMarkedForDeathCollectables();
  if (sceneManager.getCurrentScene().getSceneName() == "scene02Keypad" || sceneManager.getCurrentScene().getSceneName() == "scene01TimeMachineKeyPad") {
    drawKeypad();
  }
  for ( CutScene cutScene : cutScenes) cutScene.update();
  //inventoryManager.clearMarkedForDeathCollectables(); //this was already here
  if (showInventory && !isDialogueActive ) {
    inventoryManager.drawInventory();
  }
  for ( Dialogue dialogue : dialogueManager) dialogue.drawDialogueBox();

  if (!isDialogueActive) {
    inventoryButton.display();      //InventoryButton
  }
}

void mouseDragged() {
  inventoryManager.mouseDragged();
}

void mouseReleased() {
  inventoryManager.mouseReleased();
}


void mouseMoved() {
  sceneManager.getCurrentScene().mouseMoved();
  inventoryButton.mouseMoved();
}

void mouseClicked() {
  if (!isDialogueActive) {
    inventoryButton.mouseClicked();

    sceneManager.getCurrentScene().mouseClicked();
    if (sceneManager.getCurrentScene().getSceneName() == "scene02Keypad" || sceneManager.getCurrentScene().getSceneName() == "scene01TimeMachineKeyPad") {
      for ( keypadButtonObject keypadButton : keypad) keypadButton.clicked();
    }
  } else {
    for ( Dialogue dialogue : dialogueManager) dialogue.nextDialogueBox();
  }
  println(mouseX + " and " + mouseY);
}

//CustomFunctions

public void checkTimeMachineScrew() {
  if (timeScrew1B && timeScrew2B && timeScrew3B && timeScrew4B && !timeMachineScrewed) {//if all screws are open,
    timeMachineScrewed = true;
    sceneManager.getCurrentScene().backgroundImage = loadImage("door_open.png");
    println("open");
    sceneManager.getCurrentScene().addScannerObject( timeBattery1);
    sceneManager.getCurrentScene().addScannerObject( timeBattery2);
    // MoveToSceneObject s02GoOutside = new MoveToSceneObject("s02GoOutside", 640, 300, 50, 50, "debugblock.png", "scene03");//create scannerobjects where the batteries must be dragged
    //  sceneManager.getCurrentScene().addGameObject(s02GoOutside); //add the scannerobjects to the scene
  }
}
public void  checkTimeMachineBattery() {
  if (timeBattery1B && timeBattery2B && !timeBatterySolved) {
    println("Batteries inserted");
    //play dialogue because it's ready!
    // dialogueManager.(" testDialogue").activateDialogue();
    timeBatterySolved = true;
  }
}
