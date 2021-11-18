class InventoryObject extends GameObject {
  //private Collectable collectable; //is not being used?
  private PImage imageFile;
  private int invSize;      //CURRENTLY NOT IN USE: define how big the image should be displayed 
                            //use resize(width, height) for this, problem: x/y coordinates might still be the same
 
  boolean isDragging;
  // isOverCollider should be in the Scannerobject that needs the InventoryObject(collision) --> if not set back to inventory coordinates

  public InventoryObject(String identifier, int x, int y, int owidth, 
                         int oheight, Collectable collectable) {
    super(identifier, x, y, owidth, oheight, collectable.getGameObjectImageFile());
    identifier = collectable.name;
    //this.collectable = collectable; 
    imageFile = loadImage(collectable.getGameObjectImageFile());
  }  
  
  //display InventoryObject at displayX/Y
  public void display(int displayX, int displayY){
    if(mouseIsHovering)
    rect(displayX, displayY, owidth, oheight);            //hitbox of object
    
    image(imageFile, displayX, displayY, owidth, oheight);
    if (mouseX > displayX && mouseX < displayX + owidth &&
        mouseY > displayY && mouseY < displayY + oheight){
        mouseIsHovering = true; 
        }
    else { mouseIsHovering = false; }//can I work with this? Problem with mouseDragged still there
              
  }
  public String getId(){
    return identifier;
  }
  
  public void mouseDragged(){
    if(mouseIsHovering){          
    println("isDragging");
    }
  }
     //Override of draw and mouseDragged doesn't help bc these will be added in SceneManager
     //  we dont have ImageInventories in Scenes, which is why it doesnt help
  
}
