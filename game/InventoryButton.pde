//only add inventory button to the in game screens, not in cutScenes!
class InventoryButton {
  private boolean mouseOverImage;
  private int x;
  private int y;
  private int owidth;
  private int oheight;
  private PImage gameObjectImage;
  
  public InventoryButton(int x, int y, int owidth, int oheight, String gameObjectImageFile){
   this.x = x;
   this.y = y;
   this.owidth = owidth;
   this.oheight = oheight;
   this.gameObjectImage = loadImage(gameObjectImageFile);
   
 }
  
  public void display(){
    rect(x, y, owidth, oheight);
    image (gameObjectImage, x, y, owidth, oheight);
    
  } 
  

  public void mouseClicked(){    //show Inventory when clicking on the inventoryButton
    if (mouseOverImage){
      println("I clicked the button");
      if(showInventory){ showInventory = false; }  //showInventory can be found in game
      else { showInventory = true; }
    }
  }
 public void mouseMoved(){
   mouseOverImage= false;
    if (mouseX >= x && mouseX <= x + owidth &&
      mouseY >= y && mouseY <= y + oheight) {
      mouseOverImage = true;
    }
 }
  
}
