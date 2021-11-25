class MoveToSceneObject extends GameObject {  

  private String nextSceneIdentifier;
  private boolean moveBack;

  public MoveToSceneObject(String identifier, int x, int y, int owidth, int oheight, boolean moveBack, AudioPlayer soundEffect) {
    this(identifier, x, y, owidth, oheight, "", moveBack, soundEffect);
  }

  public MoveToSceneObject(String identifier, int x, int y, int owidth, int oheight, String gameObjectImageFile, boolean moveBack, AudioPlayer soundEffect) {
    super(identifier, x, y, owidth, oheight, gameObjectImageFile, soundEffect);
    this.moveBack = moveBack;
  }

  public MoveToSceneObject(String identifier, int x, int y, int owidth, int oheight, String nextSceneIdentifier, AudioPlayer soundEffect) {
    this(identifier, x, y, owidth, oheight, "", nextSceneIdentifier, soundEffect);
  }

  public MoveToSceneObject(String identifier, int x, int y, int owidth, int oheight, String gameObjectImageFile, String nextSceneIdentifier, AudioPlayer soundEffect) {
    super(identifier, x, y, owidth, oheight, gameObjectImageFile, soundEffect);
    this.nextSceneIdentifier = nextSceneIdentifier;
    this.moveBack = false;
    this.soundEffect = soundEffect;
  }



  @Override
    public void mouseClicked() {

    if (mouseIsHovering) {
     // println(identifier);
      if (soundEffect != null) {
        soundEffect.rewind();
        soundEffect.play();
      }
      if (method != null) {
        method(method);
      }
      if (moveBack) {
        sceneManager.goToPreviousScene();
        sceneManager.getCurrentScene().mouseMoved();
      } else {
        try {
          sceneManager.goToScene(nextSceneIdentifier);
          sceneManager.getCurrentScene().mouseMoved();
        } 
        catch(Exception e) { 
          println(e.getMessage());
        }
      }
    }

    if (nextSceneIdentifier == "sceneDiary") {
      identifier = null;
      x = 0;
      y = 0;
      owidth = 0;
      oheight = 0;
    }
  }
}
