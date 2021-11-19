class CollectableObject extends GameObject { 
  private Collectable collectable;
  private GameObject replaceWith;
  private boolean willReplaceByAnotherGameObject;
  
  public CollectableObject(String identifier, int x, int y, int owidth, 
                           int oheight, Collectable collectable) {
    this(identifier, x, y, owidth, oheight, collectable, null);
  }
  
  public CollectableObject(String identifier, int x, int y, int owidth, 
                           int oheight, Collectable collectable, GameObject replaceWith) {
    super(identifier, x, y, owidth, oheight, collectable.getGameObjectImageFile());
    this.collectable = collectable;
    if(replaceWith != null) {
      this.replaceWith = replaceWith;
      this.willReplaceByAnotherGameObject = true;
    } else {
      this.willReplaceByAnotherGameObject = false;
    }
  }
  
  @Override      //this works, but why doesnt it work for inventoryObject? 
  public void draw() {
    super.draw();
    println("collectable Object drawn");
  }
  
  
  
  //PROBLEM mouseClicked is working in a set of orders!! need to work on this :d
  @Override
  public void mouseClicked() {
    if(mouseIsHovering) {
      //inventoryManager.addCollectable(collectable);
      inventoryManager.addInventory(new InventoryObject(identifier, x, y, owidth, oheight, collectable));
      sceneManager.getCurrentScene().removeGameObject(this);
      if(willReplaceByAnotherGameObject) {
        sceneManager.getCurrentScene().addGameObject(replaceWith);  
      }
    }
  }
}
