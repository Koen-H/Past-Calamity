class CollectableObject extends GameObject { 
  private Collectable collectable;
  private GameObject replaceWith;
  private boolean willReplaceByAnotherGameObject;
  private int inventoryObjectSize;                                  //for InventoryObject Size, yet not in use
  private boolean canBeRemoved;   //needed for InventoryObject
  private boolean canBeClicked;

  public CollectableObject(String identifier, int x, int y, int owidth, 
    int oheight, Collectable collectable, boolean canBeRemoved, boolean canBeClicked) {
    this(identifier, x, y, owidth, oheight, collectable, null, canBeRemoved, canBeClicked);
    this.canBeRemoved = canBeRemoved;
    this.canBeClicked = canBeClicked;
  }

  public CollectableObject(String identifier, int x, int y, int owidth, 
    int oheight, Collectable collectable, GameObject replaceWith, boolean canBeRemoved, boolean canBeClicked) {
    super(identifier, x, y, owidth, oheight, collectable.getGameObjectImageFile());
    this.collectable = collectable;
    if (replaceWith != null) {
      this.replaceWith = replaceWith;
      this.willReplaceByAnotherGameObject = true;
      this.canBeRemoved = canBeRemoved;
      this.canBeClicked = canBeClicked ;
    } else {
      this.willReplaceByAnotherGameObject = false;
    }
  }
  
  @Override
  public void draw() {
    super.draw();
  }

  @Override
  public void mouseClicked() {
    if (mouseIsHovering) {
      if (method != null) {
        method(method);
      }
      println("Collectable " +canBeRemoved);
            //inventoryManager.addCollectable(collectable);             //change owidth/ oheight to inventoryObjectSize, if wanted
      inventoryManager.addInventoryObject(new InventoryObject(identifier, x, y, owidth, oheight, collectable, canBeRemoved, canBeClicked)); 
      sceneManager.getCurrentScene().removeGameObject(this);
      if (willReplaceByAnotherGameObject) {
        sceneManager.getCurrentScene().addGameObject(replaceWith);
      }
    }
  }
}
