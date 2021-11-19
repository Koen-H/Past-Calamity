class InventoryObject extends GameObject {
  private Collectable collectable; //is not being used?
  private PImage imageFile;
  private int invSize;      //CURRENTLY NOT IN USE: define how big the image should be displayed
  
  boolean isDragging;
  // isOverCollider should be in the Scannerobject that needs the InventoryObject(collision) --> if not set back to inventory coordinates

  public InventoryObject(String identifier, int x, int y, int owidth, 
                         int oheight, Collectable collectable) {
    super(identifier, x, y, owidth, oheight, collectable.getGameObjectImageFile());
    identifier = collectable.name;
    this.collectable = collectable; 
   imageFile = loadImage(collectable.getGameObjectImageFile());
  }  
  
  //display InventoryObject at displayX/Y
  public void display(int displayX, int displayY){
    if(mouseIsHovering)                                   //doesnt work, gameObject doesnt apply to inventoryObjects for some reason
    rect(displayX, displayY, owidth, oheight);            //hitbox of object
    
    image(imageFile, displayX, displayY, owidth, oheight);
    if (mouseX > displayX && mouseX < displayX + owidth &&
        mouseY > displayY && mouseY < displayY + oheight){
    println("mouseOverObject");
        }
  }
  public String getId(){
    return identifier;
  }
       //not in use bc we're using this code in the inventoryManager, there is no InventoryObject in a scene!!!

 
    //WIP
    @Override    
    public void mouseDragged(){ //--> mouseHover must be true for this?
      isDragging = true;
      println("inventory DRAG");
  }
  
}
