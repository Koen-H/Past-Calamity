
//------------------------- ALL INVENTORY CLASSES----------------------------------

class InventoryManager {
  private ArrayList<Collectable> collectables;

  private ArrayList<InventoryObject> inventoryObjects;
  private ArrayList<InventorySlot> inventorySlots;
  private int numberOfSlots = 6;
  private String currentId; 
  private boolean currentlyDragging = false;

  public boolean moveToDiaryScene;


  public InventoryManager() {
    collectables = new ArrayList<Collectable>();

    inventoryObjects = new ArrayList<InventoryObject>();
    inventorySlots = new ArrayList<InventorySlot>();
    for (int i = 0; i < numberOfSlots; i++ ) {    //six slot
      inventorySlots.add(new InventorySlot (((wwidth/numberOfSlots)*i), numberOfSlots) );
      //println("created Slot");
    }
  }

  /*
  public void addCollectable(Collectable collectable) {          //currently not in use: used in requiredObject
   collectables.add(collectable);
   }
   
   public void removeCollectable(Collectable collectable) {
   markedForDeathCollectables.add(collectable);
   }
   
   public void clearMarkedForDeathCollectables() {                //not in use: used in game.draw
   if(markedForDeathCollectables.size() > 0) {
   for(Collectable collectable : markedForDeathCollectables) {
   collectables.remove(collectable);
   println("removed collectable");
   }
   markedForDeathCollectables  = new ArrayList<Collectable>();
   }
   }
   */
   
  public boolean containsCollectable(Collectable collectable) {  //used in requireObject
    return collectables.contains(collectable);
  }

  public void addInventoryObject(InventoryObject inventoryObject) {
    inventoryObjects.add(inventoryObject);
    //println(inventoryObject.getId());
  }

  public void removeInventoryObject(InventoryObject inventoryObject) {
    inventoryObjects.remove(inventoryObject);
  }

  public void drawInventory() {
    if (!currentlyDragging) {                                                          //draw entire inventory
      for (InventorySlot inventorySlot : inventorySlots) inventorySlot.drawSlots();    //draw all slots
      for (int o = inventoryObjects.size()-1; o >= 0; o--) {
        InventoryObject inventoryObject = inventoryObjects.get(o);                
        InventorySlot inventorySlot = inventorySlots.get(o);      

        push();
        inventoryObject.display(inventorySlot.objX, inventorySlot.objY);               //draw All items
        pop();
      }
    } else {                                                                           //only draw the dragged Item, hide inventory
      for (int o = inventoryObjects.size()-1; o >= 0; o--) {
        InventoryObject inventoryObject = inventoryObjects.get(o);                
        InventorySlot inventorySlot = inventorySlots.get(o); 

        if (inventoryObject.mouseIsHovering) { 
          push();
          inventoryObject.display(inventorySlot.objX, inventorySlot.objY);           
          pop();
        }
      }
    }
  }

  public void mouseClicked() {      //for opening the diary

  if(moveToDiaryScene){  sceneManager.goToScene("sceneDiary"); }

    for (int o = inventoryObjects.size()-1; o >= 0; o--) {
      InventoryObject inventoryObject = inventoryObjects.get(o);


      /*if(inventoryObject.canBeClicked && inventoryObject.mouseIsHovering){
       sceneManager.goToScene("sceneDiary");
       }*/
      if (inventoryObject.canBeClicked && inventoryObject.mouseIsHovering && sceneManager.getCurrentScene().getSceneName() != "sceneDiary2" && sceneManager.getCurrentScene().getSceneName() != "sceneDiary") {
        moveToDiaryScene = true;
        //println(sceneManager.getCurrentScene().getSceneName());
        println("Opened Diary");

        //println(sceneManager.getCurrentScene().getSceneName());
        sceneManager.goToScene("sceneDiary");
        println(sceneManager.getCurrentScene().getSceneName()); //for some reason we stay in the scene
      }                         
      /*if (inventoryObject.canBeClicked && inventoryObject.mouseIsHovering) {
        println("inventoryManager mousecanBeClicked");

        diaryX = inventorySlot.objX;
        diaryY = inventorySlot.objY;
        diaryWidth = inventoryObject.owidth;
        diaryHeight = inventoryObject.oheight;
        diaryImage = inventoryObject.imageFile;                                                    //shouldnt be visible
        moveToDiary = new MoveToSceneObject("moveToDiary", diaryX, diaryY, diaryWidth, diaryHeight, "transparent.png", "sceneDiary", buttonClick);
        sceneManager.getCurrentScene().addGameObject(moveToDiary);
      }*/
    }
  }

  //if the mouse is in the image, move it when the mouse is dragged
  public void mouseDragged() {
    for (int o = inventoryObjects.size()-1; o >= 0; o--) {
      InventoryObject inventoryObject = inventoryObjects.get(o);
      InventorySlot inventorySlot = inventorySlots.get(o);      

      if (inventoryObject.mouseIsHovering && !inventoryObject.canBeClicked) {
        // println("canBeRemoved " + inventoryObject.canBeRemoved);
        currentlyDragging = true;
        float deltaX = mouseX - pmouseX;
        float deltaY = mouseY - pmouseY;

        inventorySlot.objX += deltaX;
        inventorySlot.objY += deltaY;

        currentId = inventoryObject.getId();
        //println(currentId);
        //recentScannerObject set false in game
        if (inventoryObject.canBeRemoved && sceneManager.getCurrentScene().recentScannerObject.isActive) { 
          inventoryObject.mouseIsHovering = false;
          currentlyDragging = false;
          //println(inventoryObject.mouseIsHovering);  
          inventoryObjects.remove(o);  
          currentId = null;

          inventorySlot.objX = inventorySlot.x + 40;                      //currently 40, probably needs adjustment
          inventorySlot.objY = wheight - inventorySlot.inventoryHeight;
        }
      }
    }
  }


  public void mouseReleased() {
    currentId = null;
    currentlyDragging = false;
    for (int o = inventoryObjects.size()-1; o >= 0; o--) {
      InventorySlot inventorySlot = inventorySlots.get(o);  
      //reset to slot positon
      inventorySlot.objX = inventorySlot.x + 40;                      //currently 40, probably needs adjustment
      inventorySlot.objY = wheight - inventorySlot.inventoryHeight;
    }
  }
}

// -----------------------------------------------------------------------------------------------------------------

//only add inventory button to the in game screens, not in cutScenes!
class InventoryButton {
  private boolean mouseOverImage;
  private int x;
  private int y;
  private int owidth;
  private int oheight;
  private PImage gameObjectImage;

  public InventoryButton(int x, int y, int owidth, int oheight, String gameObjectImageFile) {
    this.x = x;
    this.y = y;
    this.owidth = owidth;
    this.oheight = oheight;
    this.gameObjectImage = loadImage(gameObjectImageFile);
  }

  public void display() {
    //rect(x, y, owidth, oheight);
    image (gameObjectImage, x, y, owidth, oheight);
  } 


  public void mouseClicked() {    //show Inventory when clicking on the inventoryButton
    if (mouseOverImage) {
      //println("I clicked the button");
      if (showInventory ) { 
        showInventory = false;
      } //showInventory can be found in game
      else { 
        showInventory = true;
      }
    }
  }
  public void mouseMoved() {
    mouseOverImage= false;
    if (mouseX >= x && mouseX <= x + owidth &&
      mouseY >= y && mouseY <= y + oheight) {
      mouseOverImage = true;
    }
  }
}
// -----------------------------------------------------------------------

class InventoryObject extends GameObject {
  private PImage imageFile;                        
  boolean isDragging;
  boolean canBeRemoved;
  boolean canBeClicked;    //only for diary...

  public InventoryObject(String identifier, int x, int y, int owidth, 
    int oheight, Collectable collectable, boolean canBeRemoved, boolean canBeClicked) {
    super(identifier, x, y, owidth, oheight, collectable.getGameObjectImageFile(), null); //no sound needed
    imageFile = loadImage(collectable.getGameObjectImageFile());
    this.canBeRemoved = canBeRemoved; 
    this.canBeClicked = canBeClicked;
  }  

  //display InventoryObject at displayX/Y
  public void display(int displayX, int displayY) {
    if (mouseIsHovering) {
      //rect(displayX, displayY, owidth, oheight);     //hitbox of object
    }

    image(imageFile, displayX, displayY, owidth, oheight);

    if (mouseX > displayX && mouseX < displayX + owidth &&
      mouseY > displayY && mouseY < displayY + oheight) {
      mouseIsHovering = true;
    } else { 
      mouseIsHovering = false;
    }
  }

  public void mouseDragged() {
    if (mouseIsHovering)
      image(imageFile, mouseX, mouseY, owidth, oheight);
  }

  public String getId() {
    return identifier;
  }
}

// --------------------------------------------------------------------------------------------------

class InventorySlot {
  private int inventoryHeight = 150;
  private int x;     //inventoryX position
  private int objX;  //object slot positionX
  private int objY;  //object slot positionY
  public int numberOfSlots; //decide how many slots we need
  public boolean hasObject; //if it has object display the inventoryObject where the Slot is


  InventorySlot(int x, int numberOfSlots) {
    this.x = x;
    this.numberOfSlots = numberOfSlots;


    objX = x + 40; 
    objY = wheight - inventoryHeight;   // inventory Y position;
  }

  void drawSlots() {
    push();
    fill(255);
    strokeWeight(2);
    //println(slotImage);
    //rect(x, wheight - inventoryHeight-10, width/(numberOfSlots), inventoryHeight);
    image (slotImage, x, wheight - inventoryHeight-10, width/(numberOfSlots), inventoryHeight);
    pop();
  }
}
