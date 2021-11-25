class CollectableObject extends GameObject { 
  private Collectable collectable;
  private GameObject replaceWith;
  private boolean willReplaceByAnotherGameObject;
  public int inventoryObjectSize = 120;              //for change InventoryObjectsSize to fit the slot
  private boolean canBeRemoved;   //needed for InventoryObject
  private boolean canBeClicked;
  private AudioPlayer soundEffect;    //all collectables have the same sound!

  public CollectableObject(String identifier, int x, int y, int owidth,                 //is this ever needed?
    int oheight, Collectable collectable, boolean canBeRemoved, boolean canBeClicked, AudioPlayer soundEffect) {
    this(identifier, x, y, owidth, oheight, collectable, null, canBeRemoved, canBeClicked, soundEffect);
    this.canBeRemoved = canBeRemoved;
    this.canBeClicked = canBeClicked;

  }

  public CollectableObject(String identifier, int x, int y, int owidth, 
    int oheight, Collectable collectable, GameObject replaceWith, boolean canBeRemoved, boolean canBeClicked, AudioPlayer soundEffect) {
    super(identifier, x, y, owidth, oheight, collectable.getGameObjectImageFile(), soundEffect);
    this.collectable = collectable;
    this.soundEffect = soundEffect;

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
      //println("soundEffect " +soundEffect);
       soundEffect.rewind();
       soundEffect.play();
      
      //println("Collectable " +canBeRemoved);
            //inventoryManager.addCollectable(collectable);             //change owidth/ oheight to inventoryObjectSize, if wanted
      inventoryManager.addInventoryObject(new InventoryObject(identifier, x, y, inventoryObjectSize, inventoryObjectSize, collectable, canBeRemoved, canBeClicked)); 
      sceneManager.getCurrentScene().removeGameObject(this);
      if (willReplaceByAnotherGameObject) {
        sceneManager.getCurrentScene().addGameObject(replaceWith);
      }
      /*if(){
        dialogueScene01OpenDrawer.activateDialogue();
      }*/
    }
  }
}
