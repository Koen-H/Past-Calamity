class InventoryManager {
  private ArrayList<Collectable> collectables;
  private ArrayList<Collectable> markedForDeathCollectables;
  private ArrayList<InventoryObject> inventoryObjects;
  private ArrayList<InventorySlot> inventorySlots;
  private int numberOfSlots = 6;
  private String currentId; 
  
  
  public InventoryManager() {
     collectables = new ArrayList<Collectable>();
     markedForDeathCollectables = new ArrayList<Collectable>();
     inventoryObjects = new ArrayList<InventoryObject>();
     inventorySlots = new ArrayList<InventorySlot>();
     for(int i = 0; i < numberOfSlots ; i++ ){    //six slots
       inventorySlots.add(new InventorySlot (((wwidth/numberOfSlots)*i), numberOfSlots) );
       //println("created Slot");
     }
  }

  public void addCollectable(Collectable collectable) {
    collectables.add(collectable);
  }
  
  public void removeCollectable(Collectable collectable) {
    markedForDeathCollectables.add(collectable);
  }
  
  public boolean containsCollectable(Collectable collectable) {
    return collectables.contains(collectable);
  }
  
  public void clearMarkedForDeathCollectables() {
    if(markedForDeathCollectables.size() > 0) {
      for(Collectable collectable : markedForDeathCollectables) {
        collectables.remove(collectable);
        println("removed collectable");
      }
      markedForDeathCollectables  = new ArrayList<Collectable>();
    }
  }
  
  public void addInventory(InventoryObject inventoryObject){
    inventoryObjects.add(inventoryObject);
    println(inventoryObject.getId());
  }

  public void drawInventory(){
    for (InventorySlot inventorySlot : inventorySlots) inventorySlot.drawSlots(); //draw all slots
      
      for (int o = inventoryObjects.size()-1; o >= 0 ; o--){
        InventoryObject inventoryObject = inventoryObjects.get(o);
        InventorySlot inventorySlot = inventorySlots.get(o);      //repeating code... :d
        
        push();
        inventoryObject.display(inventorySlot.objX, inventorySlot.objY);
        pop();
  
      } 
    }

  //if the mouse is in the image, mouve it when the mouse is dragged
  public void mouseDragged(){
    
      for (int o = inventoryObjects.size()-1; o >= 0 ; o--){
        InventoryObject inventoryObject = inventoryObjects.get(o);
        InventorySlot inventorySlot = inventorySlots.get(o);      //repeating code... :d
        inventoryObject.isDragging = true;         //currently not in use
        
        if(inventoryObject.mouseIsHovering){
        float deltaX = mouseX - pmouseX;
        float deltaY = mouseY - pmouseY;
        
        inventorySlot.objX += deltaX;
        inventorySlot.objY += deltaY;
        
        currentId = inventoryObject.getId();
        println(currentId);
        }
      }
  }
  
  public void mouseReleased(){
        for (int o = inventoryObjects.size()-1; o >= 0 ; o--){
        InventoryObject inventoryObject = inventoryObjects.get(o);
        InventorySlot inventorySlot = inventorySlots.get(o);     //repeating code... :d
        inventoryObject.isDragging = false;                      //currently not in use
        
        //reset to slot positon
        inventorySlot.objX = inventorySlot.x + 40;                      //current x
        inventorySlot.objY = wheight - inventorySlot.inventoryHeight;
      
    }
  
  }
}
  
