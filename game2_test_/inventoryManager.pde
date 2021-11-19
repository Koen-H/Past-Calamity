class InventoryManager {
  private ArrayList<Collectable> collectables;
  private ArrayList<Collectable> markedForDeathCollectables;
  private ArrayList<InventoryObject> inventoryObjects;
  private ArrayList<InventorySlot> inventorySlots;
  private int numberOfSlots = 6;
  
  
  public InventoryManager() {
     collectables = new ArrayList<Collectable>();
     markedForDeathCollectables = new ArrayList<Collectable>();
     inventoryObjects = new ArrayList<InventoryObject>();
     inventorySlots = new ArrayList<InventorySlot>();
     for(int i = 0; i < numberOfSlots ; i++ ){    //six slots
       inventorySlots.add(new InventorySlot (((wwidth/numberOfSlots)*i), numberOfSlots) );
       println("created Slot");
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
        InventorySlot inventorySlot = inventorySlots.get(o);
        
        //if(inventoryObject.isDragging){          // WIP
        push();

        inventoryObject.display(inventorySlot.objX, inventorySlot.objY);
        pop();
      //}
        
      } 
    }   
  }
  
