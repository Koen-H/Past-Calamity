class InventorySlot{
  private int inventoryHeight = 100;
  private int x;     //inventoryX position
  private int objX;  //object slot positionX
  private int objY;  //object slot positionY
  public int numberOfSlots; //decide how many slots we need for the
  public boolean hasObject; //if it has object display the inventoryObject where the Slot is
  
  InventorySlot(int x, int numberOfSlots){
    this.x = x;
    this.numberOfSlots = numberOfSlots;
    objX = x + 40; 
    objY = wheight - inventoryHeight;   // inventory Y position;
  }
  
  
  void drawSlots(){
    push();
    strokeWeight(2);
    rect(x, wheight - inventoryHeight, width/(numberOfSlots), inventoryHeight);
    pop();
  }


}
