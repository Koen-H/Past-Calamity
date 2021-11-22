//only add inventory button to the in game screens, not in cutScenes!

class InventoryButton extends GameObject {
  boolean showInventory = false;
  
  public InventoryButton( int x, int y, int owidth, int oheight, String gameObjectImageFile){
    super("", x, y, owidth, oheight, gameObjectImageFile);
  }
  
  @Override
  public void mouseClicked(){
    if (mouseIsHovering){
      println("I clicked the button");
    }
  }
  
  
}
