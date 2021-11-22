class InventoryObject extends GameObject {
  private PImage imageFile;                        
  boolean isDragging;
  boolean canBeRemoved;
  boolean canBeClicked;    //only for diary...

  public InventoryObject(String identifier, int x, int y, int owidth, 
                         int oheight, Collectable collectable, boolean canBeRemoved, boolean canBeClicked) {
    super(identifier, x, y, owidth, oheight, collectable.getGameObjectImageFile());
    imageFile = loadImage(collectable.getGameObjectImageFile());
    this.canBeRemoved = canBeRemoved; 
    this.canBeClicked = canBeClicked;
  }  
  
  //display InventoryObject at displayX/Y
  public void display(int displayX, int displayY){
    if(mouseIsHovering){
    rect(displayX, displayY, owidth, oheight);     //hitbox of object
    }
    
    image(imageFile, displayX, displayY, owidth, oheight);
    
    if(mouseX > displayX && mouseX < displayX + owidth &&
       mouseY > displayY && mouseY < displayY + oheight){
       mouseIsHovering = true;
     }
     else { mouseIsHovering = false; }
   }
  
  public String getId(){
    return identifier;
  }
  
}
