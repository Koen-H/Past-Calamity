int wwidth = 1280;
int wheight = 720;
boolean currentlyDragging = false;
boolean showInventory = false;
boolean showInventoryButton = true;

boolean playDialogue = true;

//INITIALIZE Inventory + SCANNER OBJECTS + SCENE
InventoryButton inventoryButton;
ScannerObject s01Drawer;
PImage drawerHover;

ScannerObject timeScrew1, timeScrew2, timeScrew3, timeScrew4, timeBattery1, timeBattery2, hologram1;
//timeScrew variables;
boolean timeScrew1B, timeScrew2B, timeScrew3B, timeScrew4B, timeMachineScrewed, timeBattery1B, timeBattery2B, timeBatterySolved;

//hologram variables
//boolean holo1Screw1B, holo1Screw2B, holo1Active, holo2Screw1B, holo2Screw2B, holo3Screw1B, holo3Screw2B;

final SceneManager sceneManager = new SceneManager();
final InventoryManager inventoryManager = new InventoryManager();
//define diloague and gameobjects out of setup if used in draw or other voids
Dialogue activatedHologram = new Dialogue("activatedHologram");
Dialogue dialogueScene01OpenDrawer, teddyPickUp, screwedOpen, batteryOn, timeSetCorrect, doorOpened, endScene;
GameObject newsReporter, teddy, closeDiary1, closeDiary2;
SpriteCharacter finn, lila, dad;
MoveToSceneObject playButton;

PImage slotImage;


void settings()
{
  size(wwidth, wheight);
}

void setup()
{
  slotImage = loadImage("inventory.png");
  frameRate(30);
  textFont(createFont("Downlink Bold.otf", 32));
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

  //Arrow down coordinates  602, 630, 75, 75, "arrowDown.png";
  //Arrow left coordinates  10, 322, 75, 75, "arrowLeft.png";
  //Arrow right coordinates  1195, 322, 75, 75, "arrowRight.png";


  soundLoad();   //load all Sounds

  finn = new SpriteCharacter("Finn", "finnText2.png");
  lila = new SpriteCharacter("Lila", "lilatext2.png");

  dad = new SpriteCharacter("Dad (Hank)", "Dadddddddy.png");
  SpriteCharacter news_reporter = new SpriteCharacter("News Reporter", "reporterTekst.png");
  SpriteCharacter timeMachine = new SpriteCharacter("Finn", "TIEMMACHIEN.png");
  //SpriteCharacter dad_lila = new SpriteCharacter("Lila", "dada2.png");


  DialogueBox testDialogueBox1 = new DialogueBox("Who! this dialogue box works perfect!", finn);
  DialogueBox testDialogueBox2 = new DialogueBox("It even switches to the next one!", dad);
  DialogueBox testDialogueBox3 = new DialogueBox("It even switches to the next one!2", lila);
  Dialogue testDialogue = new Dialogue();
  testDialogue.addDialogueBox(testDialogueBox1);
  testDialogue.addDialogueBox(testDialogueBox2);
  testDialogue.addDialogueBox(testDialogueBox3);
  dialogueManager.add(testDialogue);
  //testDialogue.activateDialogue();

  //All Dialogue
  Dialogue dialogueCutScene03 = new Dialogue();
  DialogueBox dialogueCutScene03Box01 = new DialogueBox("Ow my head! What in the world happened?", finn);
  DialogueBox dialogueCutScene03Box02 = new DialogueBox("Lila, where are you??! Are you okay??!", finn);
  DialogueBox dialogueCutScene03Box03 = new DialogueBox("Finn, Help it’s so dark!  \nI’m scared Finn!", lila);
  DialogueBox dialogueCutScene03Box04 = new DialogueBox("It’s gonna be alright Lila, I am here!\nIt must be a power outage. Let’s see if the light switch works. ", finn);
  dialogueCutScene03.addDialogueBox(dialogueCutScene03Box01);
  dialogueCutScene03.addDialogueBox(dialogueCutScene03Box02);
  dialogueCutScene03.addDialogueBox(dialogueCutScene03Box03);
  dialogueCutScene03.addDialogueBox(dialogueCutScene03Box04);
  dialogueManager.add(dialogueCutScene03);

  //Dialogue First CutScene (Lab)
  Dialogue dialoguecutScene01 = new Dialogue("cutScene01");
  DialogueBox dialoguecutScene01Box = new DialogueBox("You can't catch me!", lila, projectorButton);
  DialogueBox dialoguecutScene01Box2 = new DialogueBox("No, Lila. Don't go into Dad's laboratory!", finn, projectorButton);
  DialogueBox dialoguecutScene01Box3 = new DialogueBox("...come ,Lila... stop hiding now. \nWe shouldn't be here.", finn, projectorButton);
  dialoguecutScene01.addDialogueBox(dialoguecutScene01Box);
  dialoguecutScene01.addDialogueBox(dialoguecutScene01Box2);
  dialoguecutScene01.addDialogueBox(dialoguecutScene01Box3);
  dialogueManager.add(dialoguecutScene01);

  //Dialogue 2nd Cutscene (Time Machine)
  Dialogue dialoguecutScene02 = new Dialogue("cutScene02");
  DialogueBox dialoguecutScene02Box = new DialogueBox("Aww, you found me!", lila, projectorButton);
  DialogueBox dialoguecutScene02Box2 = new DialogueBox("Come out of there, let's go back.", finn, projectorButton);
  DialogueBox dialoguecutScene02Box3 = new DialogueBox("No, I don't wanna!", lila, projectorButton);
  DialogueBox dialoguecutScene02Box4 = new DialogueBox("Come out or I'll make you come out.", finn, criticalAlarm);
  DialogueBox dialoguecutScene02Box5 = new DialogueBox("Fine\n...\n... \nWhoops", lila, impact);
  dialoguecutScene02.addDialogueBox(dialoguecutScene02Box);
  dialoguecutScene02.addDialogueBox(dialoguecutScene02Box2);
  dialoguecutScene02.addDialogueBox(dialoguecutScene02Box3);
  dialoguecutScene02.addDialogueBox(dialoguecutScene02Box4);
  dialoguecutScene02.addDialogueBox(dialoguecutScene02Box5);
  dialogueManager.add(dialoguecutScene02);

  //Dialogue hologram with dad
  Dialogue dialogueScene01 = new Dialogue();
  DialogueBox dialogueScene01Box01 = new DialogueBox("Who is that in the hologram?", finn);
  DialogueBox dialogueScene01Box02 = new DialogueBox("Hello Finn, Hello Lila, \nI wish I could see you in person. \nBut I’m afraid that it is too late...", dad);
  DialogueBox dialogueScene01Box03 = new DialogueBox("I have a lot of regrets, \nI should have been a better father.", dad);
  DialogueBox dialogueScene01Box04 = new DialogueBox("For the… Last 18 years... \nI... been trying….. \nget... back, desk... drawer...", dad);
  DialogueBox dialogueScene01Box05 = new DialogueBox("Who was that old man? Where is Dad? \nHe is always in his lab!", lila);
  DialogueBox dialogueScene01Box06 = new DialogueBox("I think it was Dad, but he never was so… caring.\nAnd he looked so old, too. \nHe also said something strange at the end.", finn);
  DialogueBox dialogueScene01Box07 = new DialogueBox("Also, the lab is so dirty. It was clean and tidy just a moment ago.\nWhat happened here while the power was turned off?", finn);
  dialogueScene01.addDialogueBox(dialogueScene01Box01);
  dialogueScene01.addDialogueBox(dialogueScene01Box02);
  dialogueScene01.addDialogueBox(dialogueScene01Box03);
  dialogueScene01.addDialogueBox(dialogueScene01Box04);
  dialogueScene01.addDialogueBox(dialogueScene01Box05);
  dialogueScene01.addDialogueBox(dialogueScene01Box06);
  dialogueScene01.addDialogueBox(dialogueScene01Box07);
  dialogueManager.add(dialogueScene01);

  //Dialogue family picture
  Dialogue dialogueScene01Painting = new Dialogue();
  DialogueBox dialogueScene01PaintingBox01 = new DialogueBox("Look, it’s a picture of us with Mom! I miss her...", lila);
  DialogueBox dialogueScene01PaintingBox02 = new DialogueBox("I do, too. I still remember when we took this picture before\nshe passed away.", finn);
  DialogueBox dialogueScene01PaintingBox03 = new DialogueBox("I'm sure, that this wasn't standing here before...", finn);
  dialogueScene01Painting.addDialogueBox(dialogueScene01PaintingBox01);
  dialogueScene01Painting.addDialogueBox(dialogueScene01PaintingBox02);
  dialogueScene01Painting.addDialogueBox(dialogueScene01PaintingBox03);
  dialogueManager.add(dialogueScene01Painting);

  //dialogue key
  Dialogue dialogueScene01OpenPainting = new Dialogue();
  DialogueBox dialogueScene01OpenPaintingBox01 = new DialogueBox("I wonder what that key opens? ", finn);
  dialogueScene01OpenPainting.addDialogueBox(dialogueScene01OpenPaintingBox01);
  dialogueManager.add(dialogueScene01OpenPainting);

  //dialogue open drawer
  dialogueScene01OpenDrawer = new Dialogue("readBook");
  DialogueBox dialogueScene01OpenDrawerBox01 = new DialogueBox("Oh, a book!", lila);
  DialogueBox dialogueScene01OpenDrawerBox02 = new DialogueBox("Could it be Dad’s notebook? I didn't even know he had one.\nIt’s so old and dusty", finn);
  dialogueScene01OpenDrawer.addDialogueBox(dialogueScene01OpenDrawerBox01);
  dialogueScene01OpenDrawer.addDialogueBox(dialogueScene01OpenDrawerBox02);
  dialogueManager.add(dialogueScene01OpenDrawer);

  //dialgue open book 
  Dialogue dialogueOpenBook = new Dialogue();
  DialogueBox dialogueOpenBookBox01 = new DialogueBox("Huh?? An entry for tomorrow? What is he talking about?", finn);
  DialogueBox dialogueOpenBookBox02 = new DialogueBox("What does the old book say? I wanna know too!", lila);
  DialogueBox dialogueOpenBookBox03 = new DialogueBox("The way those words are put together is strange,\nsomething is off!", finn);
  dialogueOpenBook.addDialogueBox(dialogueOpenBookBox01);
  dialogueOpenBook.addDialogueBox(dialogueOpenBookBox02);
  dialogueOpenBook.addDialogueBox(dialogueOpenBookBox03);
  dialogueManager.add(dialogueOpenBook);

  //pass - not in use
  Dialogue pickUpCard = new Dialogue();
  DialogueBox pickUpCardBox01 = new DialogueBox("I should take this just in case.", finn);
  pickUpCard.addDialogueBox(pickUpCardBox01);
  dialogueManager.add(pickUpCard);

  //Dialogue door scene
  Dialogue doorNotOpen = new Dialogue();
  DialogueBox doorNotOpenBox1 = new DialogueBox("That's a pretty big reinforced door\nThis wasn't here before...", finn);
  DialogueBox doorNotOpenBox2 = new DialogueBox("There seems to be a keypad connected to it!", lila);
  DialogueBox doorNotOpenBox3 = new DialogueBox("Nice find, Lila!", finn);
  doorNotOpen.addDialogueBox(doorNotOpenBox1);
  doorNotOpen.addDialogueBox(doorNotOpenBox2);
  doorNotOpen.addDialogueBox(doorNotOpenBox3);
  dialogueManager.add(doorNotOpen);

  Dialogue doorOpen = new Dialogue();
  DialogueBox doorOpenBox1 = new DialogueBox("I knew something was off!", finn);
  DialogueBox doorOpenBox2 = new DialogueBox("Maybe Dad is just getting food.", lila);
  doorOpen.addDialogueBox(doorOpenBox1);
  doorOpen.addDialogueBox(doorOpenBox2);
  dialogueManager.add(doorOpen);

  Dialogue outsideHouse = new Dialogue();
  DialogueBox outsideHouseBox1 = new DialogueBox("What happened to our house? It’s so green!\nI love it!", lila);
  DialogueBox outsideHouseBox2 = new DialogueBox("It’s just like the lab…\nCould the machine really have worked…?", finn);
  DialogueBox outsideHouseBox3 = new DialogueBox("Finn look, it’s the new car Dad bought!", lila);
  DialogueBox outsideHouseBox4 = new DialogueBox("Uhh, I don’t think it’s THAT new anymore…", finn);
  outsideHouse.addDialogueBox(outsideHouseBox1);
  outsideHouse.addDialogueBox(outsideHouseBox2);
  outsideHouse.addDialogueBox(outsideHouseBox3);
  outsideHouse.addDialogueBox(outsideHouseBox4);
  dialogueManager.add(outsideHouse);

  teddyPickUp = new Dialogue();
  DialogueBox teddyPickUpBox1 = new DialogueBox("AAAHHH, MISTER GRIZZY! There you are!", lila);
  DialogueBox teddyPickUpBox2 = new DialogueBox("At least somebody seems happy.", finn);
  teddyPickUp.addDialogueBox(teddyPickUpBox1);
  teddyPickUp.addDialogueBox(teddyPickUpBox2);
  dialogueManager.add(teddyPickUp);

  Dialogue foundAlert = new Dialogue();
  DialogueBox foundAlertBox1 = new DialogueBox("Oh wow. An emergency alert message. \nI wonder what got everyone so panicked.", finn);
  DialogueBox foundAlertBox2 = new DialogueBox("Maybe they also lost their Mr Grizzies.", lila);
  DialogueBox foundAlertBox3 = new DialogueBox("...sure, Lila", finn);
  foundAlert.addDialogueBox(foundAlertBox1);
  foundAlert.addDialogueBox(foundAlertBox2);
  foundAlert.addDialogueBox(foundAlertBox3);
  dialogueManager.add(foundAlert);

  Dialogue enterStore = new Dialogue();
  DialogueBox enterStoreBox1 = new DialogueBox("Don’t we have to pay before we take them?", lila);
  DialogueBox enterStoreBox2 = new DialogueBox("In cases like these, you can just take them Lila.", finn);
  enterStore.addDialogueBox(enterStoreBox1);
  enterStore.addDialogueBox(enterStoreBox2);
  dialogueManager.add(enterStore);

  Dialogue foundHologram = new Dialogue();
  DialogueBox foundHologramBox1 = new DialogueBox("I have raided one of these once, if I remember correctly... \nI should be able to power with a Nexxon Cell!", finn);
  foundHologram.addDialogueBox(foundHologramBox1);
  dialogueManager.add(foundHologram);


  DialogueBox activatedHologramBox1 = new DialogueBox("I’ve still got it!", finn);
  DialogueBox activatedHologramBox2 = new DialogueBox("Ever since the launch day, things have gone south. \nCasualties have doubled since yesterday…\nWatch….. Out…. stay…….Safe………", news_reporter);
  DialogueBox activatedHologramBox3 = new DialogueBox("Must be an older projector.\nI don't want to know what those poor people went through.", finn);
  DialogueBox activatedHologramBox4 = new DialogueBox("Finn, what was the news lady talking about?", lila);
  DialogueBox activatedHologramBox5 = new DialogueBox("...she said that a lot of people moved away, Lila.", finn);
  activatedHologram.addDialogueBox(activatedHologramBox1);
  activatedHologram.addDialogueBox(activatedHologramBox2);  
  activatedHologram.addDialogueBox(activatedHologramBox3);  
  activatedHologram.addDialogueBox(activatedHologramBox4);  
  activatedHologram.addDialogueBox(activatedHologramBox5);
  dialogueManager.add(activatedHologram);

  Dialogue enteredCity = new Dialogue();
  DialogueBox enteredCityBox1 = new DialogueBox(" Where is everyone?\n The city looks like a ghost town.", finn);
  enteredCity.addDialogueBox(enteredCityBox1);
  dialogueManager.add(enteredCity);

  Dialogue clickedDrawer = new Dialogue();
  DialogueBox clickedDrawerBox1 = new DialogueBox("This seems to be locked up.\nI need a key to open this.", finn);
  clickedDrawer.addDialogueBox(clickedDrawerBox1);
  dialogueManager.add(clickedDrawer);
  clickedDrawer.addDialogueBox(clickedDrawerBox1);
  dialogueManager.add(clickedDrawer);

  Dialogue screwedTight = new Dialogue();
  DialogueBox screwedTightBox1 = new DialogueBox("I can probabably unscrew those with \na screwdriver.", finn);
  screwedTight.addDialogueBox(screwedTightBox1);
  dialogueManager.add(screwedTight);

  Dialogue keyPadFound = new Dialogue();
  DialogueBox keyPadFoundBox1 = new DialogueBox("This keypad needs a 8 digit code...", finn);
  DialogueBox keyPadFoundBox2 = new DialogueBox("Maybe there is a clue somewhere!", lila);
  keyPadFound.addDialogueBox(keyPadFoundBox1);
  keyPadFound.addDialogueBox(keyPadFoundBox2);
  dialogueManager.add(keyPadFound);

  Dialogue timeMachineFound = new Dialogue();
  DialogueBox timeMachineFoundBox1 = new DialogueBox("Finn, look! This machine! I remember it!", lila);
  DialogueBox  timeMachineFoundBox2 = new DialogueBox("Yes, you hid in there not too ago \n It looks very rusty now", finn);
  timeMachineFound.addDialogueBox(timeMachineFoundBox1);
  timeMachineFound.addDialogueBox(timeMachineFoundBox2);
  dialogueManager.add(timeMachineFound);


  Dialogue timeKeyPadFound = new Dialogue();
  DialogueBox timeKeyPadFoundBox = new DialogueBox("Why does this key pad have dashes on it?\nDo we need to calculate?\nI don't like math", lila);
  DialogueBox timeKeyPadFoundBox2 = new DialogueBox("No lila, it looks like we need to fill in a date", finn);
  timeKeyPadFound.addDialogueBox(timeKeyPadFoundBox);
  timeKeyPadFound.addDialogueBox(timeKeyPadFoundBox2);
  dialogueManager.add(timeKeyPadFound);

  doorOpened = new Dialogue();
  DialogueBox doorOpenedBox1 = new DialogueBox("You did it, Finn!", lila);
  doorOpened.addDialogueBox(doorOpenedBox1);
  dialogueManager.add(doorOpened);

  screwedOpen = new Dialogue();
  DialogueBox screwedOpenBox1 = new DialogueBox("It looks like we need two Nexxon Cells to get this working again!", finn);
  DialogueBox screwedOpenBox2 = new DialogueBox("You mean those from the Electro & CO store around the corner?\n ", lila);
  DialogueBox screwedOpenBox3 = new DialogueBox("Exactly those, lila!", finn);
  screwedOpen.addDialogueBox(screwedOpenBox1);
  screwedOpen.addDialogueBox(screwedOpenBox2);
  screwedOpen.addDialogueBox(screwedOpenBox3);
  dialogueManager.add(screwedOpen);

  batteryOn = new Dialogue("checkForEnd");
  DialogueBox batteryOnBox1 = new DialogueBox("Watch out lila! It seems to be doing things!", finn);
  DialogueBox batteryOnBox2 = new DialogueBox("Ok ok! I'll watch out!", lila);
  DialogueBox batteryOnBox3 = new DialogueBox("MACHINE POWERED ON.", timeMachine);
  batteryOn.addDialogueBox(batteryOnBox1);
  batteryOn.addDialogueBox(batteryOnBox2);
  batteryOn.addDialogueBox(batteryOnBox3);
  dialogueManager.add(batteryOn);

  timeSetCorrect = new Dialogue("checkForEnd");
  DialogueBox timeSetCorrectBox1 = new DialogueBox("I love the beeping noise.", lila);
  DialogueBox timeSetCorrectBox2 = new DialogueBox("Especially if we get it correct!", finn);
  timeSetCorrect.addDialogueBox(timeSetCorrectBox1);
  timeSetCorrect.addDialogueBox(timeSetCorrectBox2);
  dialogueManager.add(timeSetCorrect);

  endScene = new Dialogue("theEnd");
  DialogueBox endSceneBox1 = new DialogueBox("TIME MACHINE IS READY \nLOW POWER DETECTED\n", timeMachine);
  DialogueBox endSceneBox2 = new DialogueBox("ONLY ONE LIVING ORGANISM CAN PASS\n ", timeMachine);
  DialogueBox endSceneBox3 = new DialogueBox("Ohno... \nLila, let's play a game...", finn);
  DialogueBox endSceneBox4 = new DialogueBox("I love games!", lila);
  DialogueBox endSceneBox5 = new DialogueBox("Take a seat, close your eyes and listen closely...\nIn a few seconds you will see dad again.", finn);
  DialogueBox endSceneBox6 = new DialogueBox("Tell him we went to the future, something bad might happen.", finn);
  DialogueBox endSceneBox7 = new DialogueBox("There isn't enough power to get us both back.\nI will find a new power supply and come aswell.", finn);
  DialogueBox endSceneBox8 = new DialogueBox("But Finn-", lila, impact);
  DialogueBox endSceneBox9 = new DialogueBox("While I'm here, I should probably figure out what happend...\n", finn, stone_steps);
  DialogueBox endSceneBox10 = new DialogueBox("...", finn);
  DialogueBox endSceneBox11 = new DialogueBox("Mom?", finn);
  endScene.addDialogueBox(endSceneBox1);
  endScene.addDialogueBox(endSceneBox2);
  endScene.addDialogueBox(endSceneBox3);
  endScene.addDialogueBox(endSceneBox4);
  endScene.addDialogueBox(endSceneBox5);
  endScene.addDialogueBox(endSceneBox6);
  endScene.addDialogueBox(endSceneBox7);
  endScene.addDialogueBox(endSceneBox8);
  endScene.addDialogueBox(endSceneBox9);
  endScene.addDialogueBox(endSceneBox10);
  endScene.addDialogueBox(endSceneBox11);
  dialogueManager.add(endScene);

  //Main menu
  Scene mainMenu = new Scene("mainMenu", "title_screen.png", null); //TODO update mainmenu.png
  playButton = new MoveToSceneObject("playButton", 0, 0, 1280, 720, "cutScene01", null);
  //playButton.setMethod("doCutScene01"); 
  mainMenu.addGameObject(playButton);
  sceneManager.addScene(mainMenu);
  //CutScene
  Scene cutScene01 = new Scene("cutScene01", "labpresent.png", roomTone, true);//playing tag
  cutScene01.addDialogueOnEnter(dialoguecutScene01, true);
  sceneManager.addScene(cutScene01);

  Scene cutScene02 = new Scene("cutScene02", "timemachine.png", labAmbience, true);//fall in teleporter
  sceneManager.addScene(cutScene02);
  cutScene02.addDialogueOnEnter(dialoguecutScene02, true);

  Scene blackScene = new Scene("blackScene", "black.png", null); //TODO update mainmenu.png
  GameObject continueButton = new MoveToSceneObject("continueButton", 0, 0, 1280, 720, "cutScene03", null);
  //playButton.setMethod("doCutScene01"); 
  blackScene.addGameObject(continueButton);
  sceneManager.addScene(blackScene);

  Scene cutScene03 = new Scene("cutScene03", "labfutureoff.png", bodyFall, true);//dark room with a switch
  cutScene03.addDialogueOnEnter(dialogueCutScene03, true);
  MoveToSceneObject lightSwitch = new MoveToSceneObject("lightSwitch", 360, 349, 35, 40, "scene01", buttonClick);
  cutScene03.addGameObject(lightSwitch);
  sceneManager.addScene(cutScene03);


  //LAB
  Scene scene01 = new Scene("scene01", "labfutureon.png", labAmbience);// the lab
  scene01.addDialogueOnEnter(dialogueScene01, true);
  //DialogueObject s01Hologram = new DialogueObject("hologram01", 700, 400, 50, 50, "debugblock.png", testDialogue);//hologram text
  MoveToSceneObject s01GoToDoor = new MoveToSceneObject("s01GoToDoor", 1195, 322, 75, 75, "arrowRight.png", "scene02", walk2);//go to door scene
  s01GoToDoor.setHoverImage("arrowRight2.png");
  MoveToSceneObject s01ZoomOnPainting = new MoveToSceneObject("s01ZoomOnPainting", 755, 356, 80, 70, "transparent.png", "scene01Painting", walk2);//go to zoomedpainting scene
  s01ZoomOnPainting.setHoverImage("pictureHover.png");
  MoveToSceneObject s01GoToTimeMachine = new MoveToSceneObject("s01GoToTimeMachine", 10, 322, 75, 75, "arrowLeft.png", "scene01TimeMachine", walk1);//go back to the lab
  s01GoToTimeMachine.setHoverImage("arrowLeft2.png");
  drawerHover = loadImage("drawerHover.png");
  s01Drawer = new ScannerObject("s01Drawer", 1090, 431, 129, 44, "drawerKeyObj", drawerHover, clickedDrawer);
  //ScannerObject s01Frame = new ScannerObje("s01frame", 1000, 200, 150, 150, "frame.png", "drawerKeyObj");

  scene01.addScannerObject(s01Drawer);
  //scene01.addGameObject(s01Hologram); 
  scene01.addGameObject(s01ZoomOnPainting); 
  scene01.addGameObject(s01GoToDoor);
  scene01.addGameObject(s01GoToTimeMachine);
  //scene01.addGameObject(drawerLocker);
  sceneManager.addScene(scene01);
  inventoryButton = new InventoryButton(20, 20, 75, 75, "bag.png");

  //LOCKER
  Scene scene01Locker = new Scene("scene01Locker", "Drawer.png", null);
  Collectable diary = new Collectable("diary", "Notebook.png");                        
  CollectableObject diaryObj = new CollectableObject("diaryObj", 548, 179, 150, 150, diary, false, true, takeItem);
  Collectable screwDriver = new Collectable("screwDriver", "Screwed.png");   
  CollectableObject screwDriverObj = new CollectableObject("screwDriverObj", 865, 299, 150, 150, screwDriver, false, false, takeItem);
  MoveToSceneObject sceneLockerBack = new MoveToSceneObject("sceneLockerBack", 602, 630, 75, 75, "arrowDown.png", "scene01", drawerClosed);
  sceneLockerBack.setHoverImage("arrowDown2.png");
  scene01Locker.addGameObject(sceneLockerBack);
  scene01Locker.addGameObject(diaryObj);
  scene01Locker.addGameObject(screwDriverObj);
  scene01Locker.addDialogueOnEnter(dialogueScene01OpenDrawer, true);
  sceneManager.addScene(scene01Locker);


  //TIME MACHINE
  Scene scene01TimeMachine = new Scene("scene01TimeMachine", "timemachinefuture.png", null); //here's the time machine
  MoveToSceneObject s01TimeMachineGoToLab = new MoveToSceneObject("s01TimeMachineGoToLab", 1195, 322, 75, 75, "arrowRight.png", "scene01", walk1);//go to door scene
  s01TimeMachineGoToLab.setHoverImage("arrowRight2.png");
  MoveToSceneObject s01TimeMachineGoToScrew = new MoveToSceneObject("s01TimeMachineGoToScrew", 570, 248, 130, 100, "transparent.png", "scene01TimeMachineScrew", buttonClick);//go zoomed Screw
  s01TimeMachineGoToScrew.setHoverImage("timeZoomInHover.png");
  MoveToSceneObject s01TimeMachineGoToTimeKeypad= new MoveToSceneObject("s01TimeMachineGoToTimeKeypad", 1023, 239, 126, 160, "transparent.png", "scene01TimeMachineKeyPad", buttonClick);//go zoomed keypad
  s01TimeMachineGoToTimeKeypad.setHoverImage("timeKeyPadHover.png");
  scene01TimeMachine.addGameObject(s01TimeMachineGoToScrew);
  scene01TimeMachine.addGameObject(s01TimeMachineGoToLab);
  scene01TimeMachine.addGameObject(s01TimeMachineGoToTimeKeypad);
  scene01TimeMachine.addDialogueOnEnter(timeMachineFound, true);
  sceneManager.addScene(scene01TimeMachine);

  //TIME MACHINE SCREWING
  Scene scene01TimeMachineScrew = new Scene("scene01TimeMachineScrew", "zoominpanel_timemachine.png", null);
  MoveToSceneObject timeMachineScrewBack = new MoveToSceneObject("timeMachineScrewBack", 602, 630, 75, 75, "arrowDown.png", "scene01TimeMachine", buttonClick);//go back to the scene01TimeMachine
  timeMachineScrewBack.setHoverImage("arrowDown2.png");
  timeScrew1 = new ScannerObject("timeScrew1", 469, 247, 75, 75, "screw1.png", "screwDriverObj", screwedTight);
  timeScrew2 = new ScannerObject("timeScrew2", 751, 242, 75, 75, "screw3.png", "screwDriverObj", screwedTight);
  timeScrew3 = new ScannerObject("timeScrew3", 486, 439, 75, 75, "screw2.png", "screwDriverObj", screwedTight);
  timeScrew4 = new ScannerObject("timeScrew4", 740, 433, 75, 75, "screw4.png", "screwDriverObj", screwedTight);
  timeBattery1 = new ScannerObject("timeBattery1", 421, 210, 300, 300, "powerCell");
  timeBattery2 = new ScannerObject("timeBattery2", 595, 229, 300, 300, "powerCell"); 
  scene01TimeMachineScrew.addScannerObject( timeScrew1);
  scene01TimeMachineScrew.addScannerObject( timeScrew2);
  scene01TimeMachineScrew.addScannerObject( timeScrew3);
  scene01TimeMachineScrew.addScannerObject( timeScrew4);
  scene01TimeMachineScrew.addGameObject(timeMachineScrewBack);
  sceneManager.addScene(scene01TimeMachineScrew);

  //TIME MACHINE KEY PAD
  Scene scene01TimeMachineKeyPad = new Scene("scene01TimeMachineKeyPad", "zoom_keypad.png", null);
  MoveToSceneObject scene01TimeMachineKeyPadBack = new MoveToSceneObject("scene01TimeMachineKeyPadBack", 602, 630, 75, 75, "arrowDown.png", "scene01TimeMachine", buttonClick);
  scene01TimeMachineKeyPadBack.setHoverImage("arrowDown2.png");
  scene01TimeMachineKeyPad.addGameObject(scene01TimeMachineKeyPadBack);
  scene01TimeMachineKeyPad.addDialogueOnEnter(timeKeyPadFound, true);
  createTimeKeypad();
  sceneManager.addScene(scene01TimeMachineKeyPad);

  //FAMILY PHOTO 
  Scene scene01Painting = new Scene("scene01Painting", "zoomedPainting.png", null);//zoomedIn painting
  MoveToSceneObject s01OpenPainting = new MoveToSceneObject("s01ZoomOutPainting", 626, 374, 75, 75, "parrow.png", "scene01OpenPainting", buttonClick);//open painting
  ///////////////.setHoverImage(".png");
  MoveToSceneObject s01ZoomOutPainting = new MoveToSceneObject("s01ZoomOutPainting", 602, 630, 75, 75, "arrowDown.png", "scene01", buttonClick);//go back to the lab
  s01ZoomOutPainting.setHoverImage("arrowDown2.png");
  scene01Painting.addGameObject(s01OpenPainting); 
  scene01Painting.addGameObject(s01ZoomOutPainting);
  scene01Painting.addDialogueOnEnter(dialogueScene01Painting, true);
  sceneManager.addScene(scene01Painting);


  //FAMILY PHOTO BACK

  Scene scene01OpenPainting = new Scene("scene01OpenPainting", "zoomedOpenPainting.png", null);//painting open
  MoveToSceneObject s01ClosePainting = new MoveToSceneObject("s01ClosePainting", 602, 630, 75, 75, "arrowDown.png", "scene01", buttonClick);//close painting
  s01ClosePainting.setHoverImage("arrowDown2.png");
  Collectable drawerKey = new Collectable("drawerKey", "key.png");                                   
  CollectableObject drawerKeyObj = new CollectableObject("drawerKeyObj", 845, 290, 75, 75, drawerKey, true, false, takeItem);   //drawerKeyObj is identifier
  scene01OpenPainting.addDialogueOnEnter(dialogueScene01OpenPainting, true);
  scene01OpenPainting.addGameObject(drawerKeyObj); 
  scene01OpenPainting.addGameObject(s01ClosePainting); 
  sceneManager.addScene(scene01OpenPainting);

  //DOOR
  Scene scene02 = new Scene("scene02", "door.png", roomTone);//door scene
  MoveToSceneObject s02GoToLab = new MoveToSceneObject("s02GoToLab", 10, 322, 75, 75, "arrowLeft.png", "scene01", walk2);//go back to the lab
  s02GoToLab.setHoverImage("arrowLeft2.png");
  MoveToSceneObject s02ZoomOnKeypad = new MoveToSceneObject("s02ZoomOnKeypad", 196, 278, 100, 150, "transparent.png", "scene02Keypad", buttonClick);// go to keypad
  s02ZoomOnKeypad.setHoverImage("doorKeyPadHover.png");
  scene02.addGameObject(s02GoToLab); 
  scene02.addGameObject(s02ZoomOnKeypad); 
  scene02.addDialogueOnEnter(doorNotOpen, true);
  sceneManager.addScene(scene02);

  //KEYPAD AT DOOR
  Scene scene02Keypad = new Scene("scene02Keypad", "keyzoomdoor.png", null);//zoomed-in keypad scene
  MoveToSceneObject s02KeyPadBack = new MoveToSceneObject("s02KeyPadBack", 602, 630, 75, 75, "arrowDown.png", "scene02", buttonClick);//go to door scene
  s02KeyPadBack.setHoverImage("arrowDown2.png");
  scene02Keypad.addGameObject(s02KeyPadBack);
  scene02Keypad.addDialogueOnEnter(keyPadFound, true);
  createKeypad(493, 307, 60, 10);//TODO  set coordinates correctly based on keypad.png createkeypad( top left x, top left y, keysize, pixels between keys).

  sceneManager.addScene(scene02Keypad);

  //OUTSIDE OF HOUSE
  Scene scene03 = new Scene("scene03", "housecrop.png", cityAmbience);//outside car scene
  MoveToSceneObject s03GoToDoor = new MoveToSceneObject("s03GoToDoor", 925, 318, 232, 375, "transparent.png", "scene02", walk1);//go back to the door scene
  s03GoToDoor.setHoverImage("doorHover.png");
  MoveToSceneObject s03GoToS04 = new MoveToSceneObject("s03GoToS04", 1195, 322, 75, 75, "arrowRight.png", "scene04", walk2);//go to city
  s03GoToS04.setHoverImage("arrowRight2.png");
  teddy = new GameObject("teddy", 284, 512, 50, 75, "teddy.png");    
  teddy.setMethod("teddyPickUp");
  scene03.addGameObject(teddy);
  scene03.addGameObject(s03GoToDoor); 
  scene03.addGameObject(s03GoToS04);
  scene03.addDialogueOnEnter(outsideHouse, true);
  sceneManager.addScene(scene03);

  //DESTROYED CITY
  Scene scene04 = new Scene("scene04", "city.png", null);//walking to city, emergency board
  MoveToSceneObject s04GoToS03 = new MoveToSceneObject("s04GoToS03", 10, 322, 75, 75, "arrowLeft.png", "scene03", walk2);//go back to house 
  s04GoToS03.setHoverImage("arrowLeft2.png");
  MoveToSceneObject s04GoToS05 = new MoveToSceneObject("s04GoToS05", 1195, 322, 75, 75, "arrowRight.png", "scene05", walk1);//continue scene
  s04GoToS05.setHoverImage("arrowRight2.png");
  scene04.addDialogueOnEnter(enteredCity, true);

  hologram1 = new ScannerObject("hologram1", 918, 609, 75, 75, "Hologram.png", "powerCell", foundHologram);
  scene04.addScannerObject(hologram1);
  scene04.addGameObject(s04GoToS03); 
  scene04.addGameObject(s04GoToS05); 
  sceneManager.addScene(scene04);

  //OUTSIDE OF STORE
  Scene scene05 = new Scene("scene05", "store.png", cityAmbience);//found a store scene
  MoveToSceneObject s05GoToS04 = new MoveToSceneObject("s05GoToS04", 10, 322, 75, 75, "arrowLeft.png", "scene04", walk1);
  s05GoToS04.setHoverImage("arrowLeft2.png");
  MoveToSceneObject s05GoToS07 = new MoveToSceneObject("s05GoToS07", 1195, 322, 75, 75, "arrowRight.png", "scene07", walk2);
  s05GoToS07.setHoverImage("arrowRight2.png");
  //Collectable crowbar = new Collectable("crowbar", "back04_apple.png");                        
  //CollectableObject crowbaObj = new CollectableObject("crowbaObj", 600, 400, 150, 150, crowbar, false, false, takeItem);
  //needs a scannerobject to open the store's door make the functionality use scene05.addGameObject();  so it will add the game object, see how I did the keyapd door as example
  //for now, an object to go to the next scene
  MoveToSceneObject s05GoToS06 = new MoveToSceneObject("s05GoToS06", 488, 430, 75, 75, "arrowUp.png", "scene06", walk1);
  s05GoToS06.setHoverImage("arrowUp2.png");
  scene05.addGameObject(s05GoToS04); 
  scene05.addGameObject(s05GoToS06); //replace this with scannerobject
  scene05.addGameObject(s05GoToS07);

  sceneManager.addScene(scene05);

  //INSIDE OF STORE
  Scene scene06 = new Scene("scene06", "inside_store.png", roomTone);//inside a store scene
  MoveToSceneObject s06GoToS05 = new MoveToSceneObject("s06GoToS05", 602, 630, 75, 75, "arrowDown.png", "scene05", walk2);  //go back outside
  s06GoToS05.setHoverImage("arrowDown2.png");
  Collectable powerCell01 = new Collectable("powerCell1", "Battery1.png");                        
  CollectableObject powerCellObj01 = new CollectableObject("powerCellObj1", 12, 323, 50, 50, powerCell01, true, false, takeItem);
  Collectable powerCell02 = new Collectable("powerCell2", "Battery1.png");                        
  CollectableObject powerCellObj02 = new CollectableObject("powerCellObj2", 299, 584, 50, 50, powerCell02, true, false, takeItem);
  Collectable powerCell03 = new Collectable("powerCell3", "Battery1.png");                        
  CollectableObject powerCellObj03 = new CollectableObject("powerCellObj3", 1109, 261, 50, 50, powerCell03, true, false, takeItem);
  scene06.addGameObject(s06GoToS05); 
  scene06.addGameObject(powerCellObj01);
  scene06.addGameObject(powerCellObj02); 
  scene06.addGameObject(powerCellObj03); 
  scene06.addDialogueOnEnter(enterStore, true);
  sceneManager.addScene(scene06);

  Scene scene07 = new Scene("scene07", "billboard.png", null);//alert sign
  MoveToSceneObject s07GoToS05 = new MoveToSceneObject("s05GoToS04", 10, 322, 75, 75, "arrowLeft.png", "scene05", walk2);
  s07GoToS05.setHoverImage("arrowLeft2.png");

  scene07.addGameObject(s07GoToS05); 
  scene07.addDialogueOnEnter(foundAlert, true);
  sceneManager.addScene(scene07);

  // DIARY PAGE 1
  //move to diaryScene: moveToSceneObject
  Scene sceneDiary = new Scene("sceneDiary", "Notebook2.png", null);  
  MoveToSceneObject diary1GoToDiary2 = new MoveToSceneObject ("diaryPage1", 1195, 322, 75, 75, "arrowRight.png", "sceneDiary2", pageFlip1);
  MoveToSceneObject diary1GoBack = new MoveToSceneObject("diary1GoBack", 602, 630, 75, 75, "arrowDown.png", true, openBook);
  sceneDiary.addGameObject(diary1GoToDiary2);
  sceneDiary.addGameObject(diary1GoBack);

  sceneManager.addScene(sceneDiary);

  // DIARY PAGE 2  
  Scene sceneDiary2 = new Scene ("sceneDiary2", "Notebook1.png", null);
  MoveToSceneObject diary2GoToDiary1 = new MoveToSceneObject("goBack_diaryPage1", 10, 322, 75, 75, "arrowLeft.png", true, pageFlip2);
  sceneDiary2.addGameObject(diary2GoToDiary1);
  sceneDiary2.addDialogueOnEnter(dialogueOpenBook, true);
  sceneManager.addScene(sceneDiary2);

  Scene endingScene = new Scene("endingScene", "timemachinefuture.png", null);
  endingScene.addDialogueOnEnter(endScene, true);
  sceneManager.addScene(endingScene);

  Scene creditScene = new Scene("creditScene", "title_screen.png", null);
  sceneManager.addScene(creditScene);

  ////////////////////////START GAME SCENE////////////////
  // sceneManager.goToScene("endingScene");//for quick access to develop
} 

void draw()
{
  //println(showInventoryButton);
  // SCANNER OBJECTS SCENARIOS ( koen: Scannerobjects should be deleted and isActive = false after they've been used)
  if (s01Drawer.isActive) {
    println("Drawer opened");
    s01Drawer.isActive = false; //if not set to false all ItemObjects will be removed at once!
    sceneManager.getCurrentScene().removeScannerObject(s01Drawer);
    MoveToSceneObject s01ZoomOnLocker = new MoveToSceneObject("s01ZoomOnLocker", 1080, 423, 140, 53, "scene01Locker", drawerOpen);//go to zoomedLocker scene
    sceneManager.getCurrentScene().addGameObject(s01ZoomOnLocker);
    sceneManager.goToScene("scene01Locker");
    // sceneManager.getCurrentScene().addGameObject(s01Test);
  }

  if (hologram1.isActive) {
    hologram1.isActive = false;
    sceneManager.getCurrentScene().removeScannerObject(hologram1);
    //newsReporter = new GameObject("newsReporter", 509, 258, 250, 302, "reporter.png");
    activatedHologram.activateDialogue();
    //sceneManager.getCurrentScene().addGameObject(newsReporter);
  }

  if (timeScrew1.isActive) {
    timeScrew1.isActive = false;
    timeScrew1B = true;
    sceneManager.getCurrentScene().removeScannerObject(timeScrew1);
    screw1.rewind();
    screw1.play();
    checkTimeMachineScrew();
    println("Screwed timeScre1");
  }
  if (timeScrew2.isActive) {
    timeScrew2.isActive = false;
    timeScrew2B = true;
    screw2.rewind();
    screw2.play();
    sceneManager.getCurrentScene().removeScannerObject(timeScrew2);
    checkTimeMachineScrew();
    println("Screwed timeScre2");
  }
  if (timeScrew3.isActive) {
    timeScrew3.isActive = false;
    timeScrew3B = true;
    screw3.rewind();
    screw3.play();
    sceneManager.getCurrentScene().removeScannerObject(timeScrew3);
    checkTimeMachineScrew();
    println("nulltimeScre3");
  }
  if (timeScrew4.isActive) {
    timeScrew4.isActive = false;
    timeScrew4B = true;
    screw1.rewind();
    screw1.play();
    sceneManager.getCurrentScene().removeScannerObject(timeScrew4);
    checkTimeMachineScrew();
    println("Screwed timeScre4");
  }
  if (timeBattery1.isActive) {
    timeBattery1.isActive = false;
    timeBattery1B = true;
    sceneManager.getCurrentScene().removeScannerObject(timeBattery1);//next line should replace it with a battery sprite
    GameObject battery1 = new GameObject("battery", 421, 210, 300, 300, "Battery1.png");
    sceneManager.getCurrentScene().addGameObject(battery1);
    checkTimeMachineBattery();
    println("Loaded battery 1");
  }
  if (timeBattery2.isActive) {
    timeBattery2.isActive = false;
    timeBattery2B = true;
    sceneManager.getCurrentScene().removeScannerObject(timeBattery2);
    GameObject battery2 = new GameObject("battery", 595, 229, 300, 300, "Battery1.png"); 
    sceneManager.getCurrentScene().addGameObject(battery2);
    checkTimeMachineBattery();
    println("Loaded battery 2");
  }

  sceneManager.getCurrentScene().draw(wwidth, wheight);
  sceneManager.getCurrentScene().updateScene();
  //inventoryManager.clearMarkedForDeathCollectables();
  if (sceneManager.getCurrentScene().getSceneName() == "scene02Keypad" || sceneManager.getCurrentScene().getSceneName() == "scene01TimeMachineKeyPad") {
    drawKeypad();
  }
  if (!isDialogueActive) {//things disabled when dialogue is active
    for ( CutScene cutScene : cutScenes) cutScene.update();
    //inventoryManager.clearMarkedForDeathCollectables(); //this was already here
    if (sceneManager.getCurrentScene().getSceneName() != "sceneDiary2" && sceneManager.getCurrentScene().getSceneName() != "sceneDiary" && sceneManager.getCurrentScene().getSceneName() != "mainMenu" && sceneManager.getCurrentScene().getSceneName() != "cutScene01" && sceneManager.getCurrentScene().getSceneName() != "cutScene02"&& sceneManager.getCurrentScene().getSceneName() != "cutScene03" && sceneManager.getCurrentScene().getSceneName() != "blackScene") {
      if (showInventory) {
        inventoryManager.drawInventory();
      }
      inventoryButton.display();
    }
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
  inventoryButton.mouseMoved();
}

void mouseClicked() {
  if (!isDialogueActive) {
    inventoryButton.mouseClicked();
    inventoryManager.mouseClicked();
    sceneManager.getCurrentScene().mouseClicked();
    if (sceneManager.getCurrentScene().getSceneName() == "scene02Keypad") {
      for ( keypadButtonObject keypadButton : keypad) keypadButton.clicked();
    } else if (sceneManager.getCurrentScene().getSceneName() == "scene01TimeMachineKeyPad") {
      for ( keypadButtonObject keypadButton : timeKeypad) keypadButton.clicked();
    }
    //beep.rewind();
    //beep.play();
  } else {
    for ( Dialogue dialogue : dialogueManager) dialogue.nextDialogueBox();
  }
  println(mouseX + " and " + mouseY);//for finding the correct coordinates
}

//CustomFunctions

public void checkTimeMachineScrew() {
  if (timeScrew1B && timeScrew2B && timeScrew3B && timeScrew4B && !timeMachineScrewed) {//if all screws are open,
    timeMachineScrewed = true;
    sceneManager.getCurrentScene().backgroundImage = loadImage("zoominpanel_timemachineopen.png");
    println("open");
    sceneManager.getCurrentScene().addScannerObject( timeBattery1);
    sceneManager.getCurrentScene().addScannerObject( timeBattery2);
    // MoveToSceneObject s02GoOutside = new MoveToSceneObject("s02GoOutside", 640, 300, 50, 50, "debugblock.png", "scene03");//create scannerobjects where the batteries must be dragged
    // sceneManager.getCurrentScene().addGameObject(s02GoOutside); //add the scannerobjects to the scene
    screwedOpen.activateDialogue();
  }
}
public void  checkTimeMachineBattery() {
  if (timeBattery1B && timeBattery2B && !timeBatterySolved) {
    println("Batteries inserted");
    batteryOn.activateDialogue(); 
    timeBatterySolved = true;
  }
}

public void teddyPickUp() {
  teddyPickUp.activateDialogue();
  sceneManager.getCurrentScene().removeGameObject(teddy);
  lila.sprite = loadImage("lilatext3.png");
}
/*public void closeBook() {
 sceneManager.scenes.get("sceneDiary").removeGameObject(closeDiary1);
 sceneManager.scenes.get("sceneDiary2").removeGameObject(closeDiary1);
 }
 */
