class ScannerObject extends GameObject{
  
  InventoryObject inventoryObject;
  private String draggingObject; //use GameObject.getIdentifier to compare
  private boolean isActive = false; //if active create an scenario
  private boolean mouseOverImage = false;
  private PImage hoverImage;
                                                                                                              //name of collectable Object! not collectable
    public ScannerObject(String identifier, int x, int y, int owidth, int oheight, String gameObjectImageFile, String draggingObject){
      super(identifier, x, y, owidth, oheight, gameObjectImageFile, null);
      this.draggingObject = draggingObject;
    }
    public ScannerObject(String identifier, int x, int y, int owidth, int oheight, String draggingObject){
      super(identifier, x, y, owidth, oheight);
      this.draggingObject = draggingObject;
    }
    
        public ScannerObject(String identifier, int x, int y, int owidth, int oheight, String draggingObject, PImage hoverImage){
      super(identifier, x, y, owidth, oheight);
      this.draggingObject = draggingObject;
      this.hoverImage = hoverImage;
    }
    


    
  public void display( ){
    
    if(mouseX > x && mouseX < x + owidth &&
       mouseY > y && mouseY < y + oheight){
       mouseOverImage = true;
      //fill(255,100);
      //rect(x, y, owidth, oheight);  //collider
      if(hoverImage!= null){ image(hoverImage, x, y, owidth, oheight); } 
    }
    else{ mouseOverImage = false;}
    super.draw();      //draw the image
  }
  
  public String getDraggingObject(){
    return draggingObject;
  }
    

    
}
